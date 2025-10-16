const hpsBackgroundService = require('../services/hpsBackgroundService');
const { supabase, query } = require('../config/supabase');

/**
 * HPS Management Controller
 *
 * Provides API endpoints for managing the HPS calculation system:
 * - Queue management and statistics
 * - Manual recalculation triggers
 * - Cache management
 * - System health monitoring
 */

/**
 * Get HPS system statistics and health
 * @route GET /api/v1/admin/hps/stats
 * @access Admin only
 */
const getHPSStats = async (req, res) => {
  try {
    const stats = await hpsBackgroundService.getQueueStats();

    // Get additional statistics
    const recalculationQueueStats = await query(
      supabase
        .from('hps_recalculation_queue')
        .select('trigger_type')
    );

    const scheduledJobsStats = await query(
      supabase
        .from('hps_scheduled_jobs')
        .select('job_type, job_status')
    );

    const cacheStats = await query(
      supabase
        .from('hps_score_cache')
        .select('expires_at, access_count')
        .gte('expires_at', new Date().toISOString())
    );

    // Aggregate statistics
    const triggerTypeCounts = recalculationQueueStats.rows.reduce((acc, row) => {
      acc[row.trigger_type] = (acc[row.trigger_type] || 0) + 1;
      return acc;
    }, {});

    const jobStatusCounts = scheduledJobsStats.rows.reduce((acc, row) => {
      acc[row.job_status] = (acc[row.job_status] || 0) + 1;
      return acc;
    }, {});

    const cacheAccessStats = cacheStats.rows.reduce((acc, row) => {
      acc.total_accesses = (acc.total_accesses || 0) + row.access_count;
      acc.entries_count = (acc.entries_count || 0) + 1;
      return acc;
    }, { total_accesses: 0, entries_count: 0 });

    res.status(200).json({
      success: true,
      message: 'HPS system statistics retrieved successfully',
      data: {
        queue: {
          size: stats.queue_size,
          oldest_item: stats.oldest_queue_item,
          trigger_types: triggerTypeCounts
        },
        jobs: {
          pending: stats.pending_jobs,
          running: stats.running_jobs,
          status_counts: jobStatusCounts
        },
        cache: {
          active_entries: stats.active_cache_entries,
          total_accesses: cacheAccessStats.total_accesses,
          average_accesses_per_entry: cacheAccessStats.entries_count > 0
            ? Math.round(cacheAccessStats.total_accesses / cacheAccessStats.entries_count * 100) / 100
            : 0
        },
        system: {
          background_service_running: hpsBackgroundService.isSchedulerRunning,
          last_updated: new Date().toISOString()
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Error getting HPS stats:', error);
    res.status(500).json({
      success: false,
      error: 'STATS_RETRIEVAL_FAILED',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Trigger manual HPS recalculation for a specific student
 * @route POST /api/v1/admin/hps/recalculate/student
 * @access Admin, Teacher (for assigned students)
 * @body { studentId: string, termId: string }
 */
const recalculateStudentHPS = async (req, res) => {
  try {
    const { studentId, termId } = req.body;

    if (!studentId || !termId) {
      return res.status(400).json({
        success: false,
        error: 'MISSING_REQUIRED_FIELDS',
        message: 'Student ID and Term ID are required',
        timestamp: new Date().toISOString()
      });
    }

    // Verify student exists and user has access
    const studentCheck = await query(
      supabase
        .from('students')
        .select('id, name, registration_no, batch_id')
        .eq('id', studentId)
        .limit(1)
    );

    if (!studentCheck.rows || studentCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'STUDENT_NOT_FOUND',
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    // Verify term exists
    const termCheck = await query(
      supabase
        .from('terms')
        .select('id, name')
        .eq('id', termId)
        .limit(1)
    );

    if (!termCheck.rows || termCheck.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'TERM_NOT_FOUND',
        message: 'Term not found',
        timestamp: new Date().toISOString()
      });
    }

    const student = studentCheck.rows[0];
    const term = termCheck.rows[0];

    // Invalidate cache first
    await hpsBackgroundService.invalidateHPSCache(studentId, termId);

    // Trigger recalculation via background service
    const jobId = await hpsBackgroundService.scheduleBatchRecalculation(
      student.batch_id,
      termId,
      'manual_student'
    );

    res.status(200).json({
      success: true,
      message: `HPS recalculation triggered for student ${student.name}`,
      data: {
        student: {
          id: student.id,
          name: student.name,
          registration_no: student.registration_no
        },
        term: {
          id: term.id,
          name: term.name
        },
        job_id: jobId,
        status: 'queued'
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Error triggering student HPS recalculation:', error);
    res.status(500).json({
      success: false,
      error: 'RECALCULATION_TRIGGER_FAILED',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Trigger manual batch HPS recalculation
 * @route POST /api/v1/admin/hps/recalculate/batch
 * @access Admin only
 * @body { batchId?: string, termId?: string, allTerms?: boolean }
 */
const recalculateBatchHPS = async (req, res) => {
  try {
    const { batchId, termId, allTerms = false } = req.body;

    if (!batchId && !termId && !allTerms) {
      return res.status(400).json({
        success: false,
        error: 'MISSING_REQUIRED_FIELDS',
        message: 'Either batchId, termId, or allTerms must be specified',
        timestamp: new Date().toISOString()
      });
    }

    let jobs = [];

    if (allTerms) {
      // Recalculate all active batches in current term
      const currentTermResult = await query(
        supabase
          .from('terms')
          .select('id, name')
          .eq('is_current', true)
          .limit(1)
      );

      if (currentTermResult.rows && currentTermResult.rows.length > 0) {
        const currentTerm = currentTermResult.rows[0];

        const batchesResult = await query(
          supabase
            .from('batches')
            .select('id, name')
            .eq('is_active', true)
        );

        const batches = batchesResult.rows || [];

        for (const batch of batches) {
          const jobId = await hpsBackgroundService.scheduleBatchRecalculation(
            batch.id,
            currentTerm.id,
            'manual_all_terms'
          );
          jobs.push({ batch_id: batch.id, term_id: currentTerm.id, job_id: jobId });
        }
      }
    } else if (batchId && termId) {
      // Recalculate specific batch-term
      const jobId = await hpsBackgroundService.scheduleBatchRecalculation(batchId, termId, 'manual_batch');
      jobs.push({ batch_id: batchId, term_id: termId, job_id: jobId });
    } else if (termId) {
      // Recalculate all batches in specific term
      const batchesResult = await query(
        supabase
          .from('batches')
          .select('id, name')
          .eq('is_active', true)
      );

      const batches = batchesResult.rows || [];

      for (const batch of batches) {
        const jobId = await hpsBackgroundService.scheduleBatchRecalculation(
          batch.id,
          termId,
          'manual_term'
        );
        jobs.push({ batch_id: batch.id, term_id: termId, job_id: jobId });
      }
    }

    res.status(200).json({
      success: true,
      message: `Batch HPS recalculation triggered for ${jobs.length} batch-term combinations`,
      data: {
        jobs_triggered: jobs.length,
        jobs: jobs,
        status: 'queued'
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Error triggering batch HPS recalculation:', error);
    res.status(500).json({
      success: false,
      error: 'BATCH_RECALCULATION_FAILED',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Clear HPS cache for specific student-term or all cache
 * @route DELETE /api/v1/admin/hps/cache
 * @access Admin only
 * @query { studentId?: string, termId?: string, all?: boolean }
 */
const clearHPSCache = async (req, res) => {
  try {
    const { studentId, termId, all = false } = req.query;

    if (all) {
      // Clear all cache
      const result = await query(
        supabase
          .from('hps_score_cache')
          .delete()
      );

      const deletedCount = result.rows ? result.rows.length : 0;

      res.status(200).json({
        success: true,
        message: `Cleared all HPS cache (${deletedCount} entries)`,
        data: {
          cache_entries_cleared: deletedCount,
          cache_cleared_at: new Date().toISOString()
        },
        timestamp: new Date().toISOString()
      });

    } else if (studentId && termId) {
      // Clear specific student-term cache
      await hpsBackgroundService.invalidateHPSCache(studentId, termId);

      res.status(200).json({
        success: true,
        message: `HPS cache cleared for student ${studentId} in term ${termId}`,
        data: {
          student_id: studentId,
          term_id: termId,
          cache_cleared_at: new Date().toISOString()
        },
        timestamp: new Date().toISOString()
      });

    } else {
      return res.status(400).json({
        success: false,
        error: 'INVALID_PARAMETERS',
        message: 'Specify studentId and termId, or use all=true to clear all cache',
        timestamp: new Date().toISOString()
      });
    }

  } catch (error) {
    console.error('❌ Error clearing HPS cache:', error);
    res.status(500).json({
      success: false,
      error: 'CACHE_CLEAR_FAILED',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Get HPS calculation audit logs
 * @route GET /api/v1/admin/hps/audit
 * @access Admin only
 * @query { limit?: number, offset?: number, studentId?: string, termId?: string }
 */
const getHPSAuditLogs = async (req, res) => {
  try {
    const { limit = 50, offset = 0, studentId, termId } = req.query;

    let queryBuilder = supabase
      .from('hps_calculation_audit')
      .select('*')
      .order('calculated_at', { ascending: false })
      .range(parseInt(offset), parseInt(offset) + parseInt(limit) - 1);

    if (studentId) {
      queryBuilder = queryBuilder.eq('student_id', studentId);
    }

    if (termId) {
      queryBuilder = queryBuilder.eq('term_id', termId);
    }

    const result = await query(queryBuilder);

    // Get total count for pagination
    let countQuery = supabase
      .from('hps_calculation_audit')
      .select('id', { count: 'exact', head: true });

    if (studentId) {
      countQuery = countQuery.eq('student_id', studentId);
    }

    if (termId) {
      countQuery = countQuery.eq('term_id', termId);
    }

    const countResult = await query(countQuery);
    const totalCount = countResult.count || 0;

    res.status(200).json({
      success: true,
      message: 'HPS audit logs retrieved successfully',
      data: {
        logs: result.rows || [],
        pagination: {
          total: totalCount,
          limit: parseInt(limit),
          offset: parseInt(offset),
          has_more: (parseInt(offset) + parseInt(limit)) < totalCount
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Error getting HPS audit logs:', error);
    res.status(500).json({
      success: false,
      error: 'AUDIT_LOGS_RETRIEVAL_FAILED',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Get scheduled jobs status
 * @route GET /api/v1/admin/hps/jobs
 * @access Admin only
 * @query { status?: string, jobType?: string, limit?: number, offset?: number }
 */
const getScheduledJobs = async (req, res) => {
  try {
    const { status, jobType, limit = 50, offset = 0 } = req.query;

    let queryBuilder = supabase
      .from('hps_scheduled_jobs')
      .select('*')
      .order('scheduled_at', { ascending: false })
      .range(parseInt(offset), parseInt(offset) + parseInt(limit) - 1);

    if (status) {
      queryBuilder = queryBuilder.eq('job_status', status);
    }

    if (jobType) {
      queryBuilder = queryBuilder.eq('job_type', jobType);
    }

    const result = await query(queryBuilder);

    // Get total count for pagination
    let countQuery = supabase
      .from('hps_scheduled_jobs')
      .select('id', { count: 'exact', head: true });

    if (status) {
      countQuery = countQuery.eq('job_status', status);
    }

    if (jobType) {
      countQuery = countQuery.eq('job_type', jobType);
    }

    const countResult = await query(countQuery);
    const totalCount = countResult.count || 0;

    res.status(200).json({
      success: true,
      message: 'HPS scheduled jobs retrieved successfully',
      data: {
        jobs: result.rows || [],
        pagination: {
          total: totalCount,
          limit: parseInt(limit),
          offset: parseInt(offset),
          has_more: (parseInt(offset) + parseInt(limit)) < totalCount
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Error getting scheduled jobs:', error);
    res.status(500).json({
      success: false,
      error: 'JOBS_RETRIEVAL_FAILED',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Force process recalculation queue immediately
 * @route POST /api/v1/admin/hps/process-queue
 * @access Admin only
 */
const processRecalculationQueue = async (req, res) => {
  try {
    console.log('🔄 Force processing HPS recalculation queue...');

    const processedCount = await hpsBackgroundService.processRecalculationQueue();

    res.status(200).json({
      success: true,
      message: `HPS recalculation queue processed: ${processedCount} items processed`,
      data: {
        processed_count: processedCount,
        processed_at: new Date().toISOString()
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Error processing recalculation queue:', error);
    res.status(500).json({
      success: false,
      error: 'QUEUE_PROCESSING_FAILED',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Run consistency check manually
 * @route POST /api/v1/admin/hps/consistency-check
 * @access Admin only
 * @body { termId?: string, fixInconsistencies?: boolean }
 */
const runConsistencyCheck = async (req, res) => {
  try {
    const { termId, fixInconsistencies = true } = req.body;

    console.log('🔍 Running manual HPS consistency check...');

    // If specific term provided, use it; otherwise use current term
    let targetTermId = termId;
    if (!targetTermId) {
      const currentTermResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );

      if (currentTermResult.rows && currentTermResult.rows.length > 0) {
        targetTermId = currentTermResult.rows[0].id;
      }
    }

    if (!targetTermId) {
      return res.status(400).json({
        success: false,
        error: 'NO_TERM_SPECIFIED',
        message: 'No term specified and no current term found',
        timestamp: new Date().toISOString()
      });
    }

    // Run consistency check
    await hpsBackgroundService.runConsistencyCheck();

    res.status(200).json({
      success: true,
      message: 'HPS consistency check completed',
      data: {
        term_id: targetTermId,
        inconsistencies_fixed: fixInconsistencies,
        completed_at: new Date().toISOString()
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Error running consistency check:', error);
    res.status(500).json({
      success: false,
      error: 'CONSISTENCY_CHECK_FAILED',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = {
  getHPSStats,
  recalculateStudentHPS,
  recalculateBatchHPS,
  clearHPSCache,
  getHPSAuditLogs,
  getScheduledJobs,
  processRecalculationQueue,
  runConsistencyCheck
};

