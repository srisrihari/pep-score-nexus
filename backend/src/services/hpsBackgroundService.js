const { supabase, query } = require('../config/supabase');
const cron = require('node-cron');
const enhancedScoreService = require('./enhancedUnifiedScoreCalculationServiceV2');

/**
 * HPS Background Processing Service
 *
 * Handles:
 * - Background HPS recalculation queue processing
 * - Scheduled batch HPS calculations
 * - Cache management and cleanup
 * - Consistency checks and data integrity
 */
class HPSBackgroundService {
  constructor() {
    this.isSchedulerRunning = false;
    this.scheduledJobs = new Map();
    this.processingQueue = false;
  }

  /**
   * Initialize the background service scheduler
   */
  initializeScheduler() {
    if (this.isSchedulerRunning) {
      console.log('⚠️ HPS background scheduler already running');
      return;
    }

    console.log('🚀 Initializing HPS background service scheduler...');

    // Process recalculation queue every 30 seconds
    cron.schedule('*/30 * * * * *', async () => {
      await this.processRecalculationQueue();
    });

    // Clean up expired cache every hour
    cron.schedule('0 * * * *', async () => {
      await this.cleanupExpiredCache();
    });

    // Run consistency check daily at 3 AM
    cron.schedule('0 3 * * *', async () => {
      await this.runConsistencyCheck();
    });

    // Run batch recalculation for active terms weekly
    cron.schedule('0 4 * * 0', async () => { // Sunday at 4 AM
      await this.runScheduledBatchRecalculation();
    });

    this.isSchedulerRunning = true;
    console.log('✅ HPS background service scheduler initialized');
  }

  /**
   * Process the HPS recalculation queue
   */
  async processRecalculationQueue() {
    if (this.processingQueue) {
      return; // Prevent concurrent processing
    }

    this.processingQueue = true;

    try {
      console.log('🔄 Processing HPS recalculation queue...');

      // Call the database function to process the queue
      const result = await query(
        supabase.rpc('process_hps_recalculation_queue')
      );

      const processedCount = result.rows && result.rows.length > 0 ? result.rows[0].process_hps_recalculation_queue : 0;

      if (processedCount > 0) {
        console.log(`✅ Processed ${processedCount} HPS recalculation jobs`);
      }

    } catch (error) {
      console.error('❌ Error processing HPS recalculation queue:', error);
    } finally {
      this.processingQueue = false;
    }
  }

  /**
   * Clean up expired cache entries
   */
  async cleanupExpiredCache() {
    try {
      console.log('🧹 Cleaning up expired HPS cache entries...');

      const result = await query(
        supabase.rpc('cleanup_expired_hps_cache')
      );

      const cleanedCount = result.rows && result.rows.length > 0 ? result.rows[0].cleanup_expired_hps_cache : 0;

      if (cleanedCount > 0) {
        console.log(`✅ Cleaned up ${cleanedCount} expired HPS cache entries`);
      }

    } catch (error) {
      console.error('❌ Error cleaning up HPS cache:', error);
    }
  }

  /**
   * Run consistency check for HPS calculations
   */
  async runConsistencyCheck() {
    try {
      console.log('🔍 Running HPS consistency check...');

      // Get current term
      const currentTermResult = await query(
        supabase
          .from('terms')
          .select('id, name')
          .eq('is_current', true)
          .limit(1)
      );

      if (!currentTermResult.rows || currentTermResult.rows.length === 0) {
        console.log('ℹ️ No current term found for consistency check');
        return;
      }

      const currentTerm = currentTermResult.rows[0];

      // Get all students in current term
      const studentsResult = await query(
        supabase
          .from('students')
          .select('id, name, registration_no')
          .eq('current_term_id', currentTerm.id)
      );

      const students = studentsResult.rows || [];
      const inconsistencies = [];

      // Check each student for consistency
      for (const student of students) {
        try {
          // Get stored HPS from summary table
          const summaryResult = await query(
            supabase
              .from('student_score_summary')
              .select('*')
              .eq('student_id', student.id)
              .eq('term_id', currentTerm.id)
              .limit(1)
          );

          if (summaryResult.rows && summaryResult.rows.length > 0) {
            const storedSummary = summaryResult.rows[0];

            // Recalculate HPS to check for consistency
            const recalculated = await enhancedScoreService.calculateUnifiedHPS(student.id, currentTerm.id);

            const difference = Math.abs(parseFloat(storedSummary.total_hps) - recalculated.totalHPS);

            if (difference > 0.01) { // Allow for small floating point differences
              inconsistencies.push({
                student_id: student.id,
                student_name: student.name,
                stored_hps: storedSummary.total_hps,
                calculated_hps: recalculated.totalHPS,
                difference: difference
              });

              // Update the stored value if it's significantly different
              if (difference > 1.0) {
                await query(
                  supabase
                    .from('student_score_summary')
                    .update({
                      total_hps: recalculated.totalHPS,
                      persona_score: recalculated.quadrantScores['persona']?.finalScore || 0,
                      wellness_score: recalculated.quadrantScores['wellness']?.finalScore || 0,
                      behavior_score: recalculated.quadrantScores['behavior']?.finalScore || 0,
                      discipline_score: recalculated.quadrantScores['discipline']?.finalScore || 0,
                      last_calculated_at: new Date().toISOString()
                    })
                    .eq('student_id', student.id)
                    .eq('term_id', currentTerm.id)
                );

                console.log(`🔧 Fixed HPS inconsistency for student ${student.name}: ${storedSummary.total_hps} → ${recalculated.totalHPS}`);
              }
            }
          }
        } catch (error) {
          console.error(`❌ Error checking consistency for student ${student.id}:`, error);
        }
      }

      if (inconsistencies.length > 0) {
        console.log(`⚠️ Found ${inconsistencies.length} HPS inconsistencies in term ${currentTerm.name}`);

        // Log consistency check results
        await this.logScheduledJob('consistency_check', 'completed', null, currentTerm.id, {
          total_students_checked: students.length,
          inconsistencies_found: inconsistencies.length,
          inconsistencies_fixed: inconsistencies.filter(i => i.difference > 1.0).length,
          inconsistencies: inconsistencies.slice(0, 10) // Log first 10 for reference
        });
      } else {
        console.log(`✅ HPS consistency check passed for ${students.length} students in term ${currentTerm.name}`);
      }

    } catch (error) {
      console.error('❌ Error running HPS consistency check:', error);
      await this.logScheduledJob('consistency_check', 'failed', null, null, {
        error: error.message
      });
    }
  }

  /**
   * Run scheduled batch recalculation for active terms
   */
  async runScheduledBatchRecalculation() {
    try {
      console.log('🔄 Running scheduled batch HPS recalculation...');

      // Get current term
      const currentTermResult = await query(
        supabase
          .from('terms')
          .select('id, name')
          .eq('is_current', true)
          .limit(1)
      );

      if (!currentTermResult.rows || currentTermResult.rows.length === 0) {
        console.log('ℹ️ No current term found for batch recalculation');
        return;
      }

      const currentTerm = currentTermResult.rows[0];

      // Get all batches in current term
      const batchesResult = await query(
        supabase
          .from('batches')
          .select('id, name')
          .eq('is_active', true)
      );

      const batches = batchesResult.rows || [];

      for (const batch of batches) {
        await this.scheduleBatchRecalculation(batch.id, currentTerm.id, 'scheduled_batch');
      }

    } catch (error) {
      console.error('❌ Error running scheduled batch recalculation:', error);
    }
  }

  /**
   * Schedule a batch recalculation job
   */
  async scheduleBatchRecalculation(batchId, termId, reason = 'manual') {
    try {
      const jobId = await this.createScheduledJob('batch_recalculation', 'pending', batchId, termId, {
        reason: reason,
        scheduled_at: new Date().toISOString()
      });

      console.log(`⏰ Scheduled batch HPS recalculation for batch ${batchId} in term ${termId}`);

      // Start processing immediately if it's a manual request
      if (reason === 'manual') {
        await this.processBatchRecalculationJob(jobId);
      }

      return jobId;

    } catch (error) {
      console.error('❌ Error scheduling batch recalculation:', error);
      throw error;
    }
  }

  /**
   * Process a batch recalculation job
   */
  async processBatchRecalculationJob(jobId) {
    try {
      // Update job status to running
      await query(
        supabase
          .from('hps_scheduled_jobs')
          .update({
            job_status: 'running',
            started_at: new Date().toISOString()
          })
          .eq('id', jobId)
      );

      // Get job details
      const jobResult = await query(
        supabase
          .from('hps_scheduled_jobs')
          .select('*')
          .eq('id', jobId)
          .limit(1)
      );

      if (!jobResult.rows || jobResult.rows.length === 0) {
        throw new Error('Job not found');
      }

      const job = jobResult.rows[0];
      const batchId = job.target_batch_id;
      const termId = job.target_term_id;

      // Get all students in this batch-term
      const studentsResult = await query(
        supabase
          .from('students')
          .select('id, name, registration_no')
          .eq('batch_id', batchId)
          .eq('current_term_id', termId)
      );

      const students = studentsResult.rows || [];
      const results = [];
      let successCount = 0;
      let errorCount = 0;

      console.log(`🔄 Processing batch HPS recalculation for ${students.length} students in batch ${batchId}`);

      // Process students in batches to avoid memory issues
      const batchSize = 50;
      for (let i = 0; i < students.length; i += batchSize) {
        const batch = students.slice(i, i + batchSize);

        for (const student of batch) {
          try {
            const startTime = Date.now();
            const result = await enhancedScoreService.calculateUnifiedHPS(student.id, termId);
            const processingTime = Date.now() - startTime;

            results.push({
              student_id: student.id,
              student_name: student.name,
              success: true,
              hps: result.totalHPS,
              processing_time_ms: processingTime
            });

            successCount++;

          } catch (error) {
            results.push({
              student_id: student.id,
              student_name: student.name,
              success: false,
              error: error.message
            });

            errorCount++;
          }
        }
      }

      // Update job with results
      await query(
        supabase
          .from('hps_scheduled_jobs')
          .update({
            job_status: 'completed',
            completed_at: new Date().toISOString(),
            result_summary: {
              total_students: students.length,
              successful_calculations: successCount,
              failed_calculations: errorCount,
              results: results.slice(0, 100) // Store first 100 results for reference
            }
          })
          .eq('id', jobId)
      );

      console.log(`✅ Batch recalculation completed: ${successCount}/${students.length} successful`);

      return {
        success: true,
        total_students: students.length,
        successful_calculations: successCount,
        failed_calculations: errorCount
      };

    } catch (error) {
      console.error('❌ Error processing batch recalculation job:', error);

      // Update job with error status
      await query(
        supabase
          .from('hps_scheduled_jobs')
          .update({
            job_status: 'failed',
            error_message: error.message,
            completed_at: new Date().toISOString()
          })
          .eq('id', jobId)
      );

      throw error;
    }
  }

  /**
   * Create a scheduled job record
   */
  async createScheduledJob(jobType, jobStatus, batchId = null, termId = null, parameters = {}) {
    const result = await query(
      supabase
        .from('hps_scheduled_jobs')
        .insert({
          job_type: jobType,
          job_status: jobStatus,
          target_batch_id: batchId,
          target_term_id: termId,
          job_parameters: parameters,
          scheduled_at: new Date().toISOString(),
          created_by: parameters.created_by || null
        })
        .select('id')
        .limit(1)
    );

    return result.rows && result.rows.length > 0 ? result.rows[0].id : null;
  }

  /**
   * Log a scheduled job completion
   */
  async logScheduledJob(jobType, jobStatus, batchId, termId, resultSummary) {
    await this.createScheduledJob(jobType, jobStatus, batchId, termId, {
      result_summary: resultSummary,
      completed_at: new Date().toISOString()
    });
  }

  /**
   * Get HPS score from cache or calculate if not cached
   */
  async getCachedHPS(studentId, termId) {
    try {
      // Check cache first
      const cacheResult = await query(
        supabase
          .from('hps_score_cache')
          .select('*')
          .eq('student_id', studentId)
          .eq('term_id', termId)
          .gte('expires_at', new Date().toISOString())
          .limit(1)
      );

      if (cacheResult.rows && cacheResult.rows.length > 0) {
        const cached = cacheResult.rows[0];

        // Update access statistics
        await query(
          supabase
            .from('hps_score_cache')
            .update({
              last_accessed_at: new Date().toISOString(),
              access_count: cached.access_count + 1
            })
            .eq('id', cached.id)
        );

        return {
          hps: cached.cached_hps,
          quadrant_scores: cached.quadrant_scores,
          from_cache: true,
          cache_version: cached.cache_version
        };
      }

      // Not in cache, calculate and cache
      const calculated = await enhancedScoreService.calculateUnifiedHPS(studentId, termId);

      // Store in cache
      const cacheKey = `${studentId}_${termId}_${Date.now()}`;
      await query(
        supabase
          .from('hps_score_cache')
          .upsert({
            student_id: studentId,
            term_id: termId,
            cached_hps: calculated.totalHPS,
            quadrant_scores: calculated.quadrantScores,
            cache_key: cacheKey,
            expires_at: new Date(Date.now() + 60 * 60 * 1000).toISOString() // 1 hour
          }, {
            onConflict: 'student_id,term_id'
          })
      );

      return {
        hps: calculated.totalHPS,
        quadrant_scores: calculated.quadrantScores,
        from_cache: false,
        cache_version: 1
      };

    } catch (error) {
      console.error('❌ Error getting cached HPS:', error);
      throw error;
    }
  }

  /**
   * Invalidate cache for a specific student-term
   */
  async invalidateHPSCache(studentId, termId) {
    try {
      await query(
        supabase
          .from('hps_score_cache')
          .delete()
          .eq('student_id', studentId)
          .eq('term_id', termId)
      );

      console.log(`🗑️ Invalidated HPS cache for student ${studentId} in term ${termId}`);

    } catch (error) {
      console.error('❌ Error invalidating HPS cache:', error);
    }
  }

  /**
   * Get queue statistics
   */
  async getQueueStats() {
    try {
      const queueResult = await query(
        supabase
          .from('hps_recalculation_queue')
          .select('id, trigger_type, created_at')
      );

      const jobsResult = await query(
        supabase
          .from('hps_scheduled_jobs')
          .select('id, job_type, job_status, scheduled_at')
          .in('job_status', ['pending', 'running'])
      );

      const cacheResult = await query(
        supabase
          .from('hps_score_cache')
          .select('id, expires_at')
          .gte('expires_at', new Date().toISOString())
      );

      return {
        queue_size: queueResult.rows ? queueResult.rows.length : 0,
        pending_jobs: jobsResult.rows ? jobsResult.rows.filter(j => j.job_status === 'pending').length : 0,
        running_jobs: jobsResult.rows ? jobsResult.rows.filter(j => j.job_status === 'running').length : 0,
        active_cache_entries: cacheResult.rows ? cacheResult.rows.length : 0,
        oldest_queue_item: queueResult.rows && queueResult.rows.length > 0 ?
          queueResult.rows[0].created_at : null
      };

    } catch (error) {
      console.error('❌ Error getting queue stats:', error);
      return {
        queue_size: 0,
        pending_jobs: 0,
        running_jobs: 0,
        active_cache_entries: 0
      };
    }
  }

  /**
   * Stop the scheduler
   */
  stopScheduler() {
    // Stop all scheduled jobs
    this.scheduledJobs.forEach((job, jobId) => {
      job.destroy();
      console.log(`⏹️ Stopped scheduled job ${jobId}`);
    });

    this.scheduledJobs.clear();
    this.isSchedulerRunning = false;
    console.log('⏹️ HPS background service scheduler stopped');
  }
}

module.exports = new HPSBackgroundService();

