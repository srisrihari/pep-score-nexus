const { supabase, query } = require('../config/supabase');

/**
 * Comprehensive Attendance Management Controller
 * Handles all attendance-related operations for students
 */

/**
 * Get student attendance summary for a specific term
 * @route GET /api/v1/attendance/student/:studentId/summary
 * @access Admins, Teachers, Students (own data)
 */
const getStudentAttendanceSummary = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId } = req.query;

    if (!termId) {
      return res.status(400).json({
        success: false,
        message: 'Term ID is required',
        timestamp: new Date().toISOString()
      });
    }

    // Get attendance summary for all quadrants
    const summaryResult = await query(
      supabase
        .from('attendance_summary')
        .select(`
          *,
          quadrants!inner(id, name, description)
        `)
        .eq('student_id', studentId)
        .eq('term_id', termId)
        .order('quadrant_id')
    );

    // Get recent attendance records
    const recentAttendanceResult = await query(
      supabase
        .from('attendance')
        .select(`
          *,
          quadrants!inner(id, name),
          users!attendance_marked_by_fkey(username)
        `)
        .eq('student_id', studentId)
        .eq('term_id', termId)
        .order('attendance_date', { ascending: false })
        .limit(10)
    );

    res.json({
      success: true,
      data: {
        summary: summaryResult.rows,
        recentAttendance: recentAttendanceResult.rows
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Get attendance summary error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch attendance summary',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Get detailed attendance records for a student
 * @route GET /api/v1/attendance/student/:studentId/records
 * @access Admins, Teachers, Students (own data)
 */
const getStudentAttendanceRecords = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId, quadrantId, startDate, endDate, page = 1, limit = 50 } = req.query;

    if (!termId) {
      return res.status(400).json({
        success: false,
        message: 'Term ID is required',
        timestamp: new Date().toISOString()
      });
    }

    let query_builder = supabase
      .from('attendance')
      .select(`
        *,
        quadrants!inner(id, name),
        users!attendance_marked_by_fkey(id, username)
      `)
      .eq('student_id', studentId)
      .eq('term_id', termId);

    if (quadrantId) {
      query_builder = query_builder.eq('quadrant_id', quadrantId);
    }

    if (startDate) {
      query_builder = query_builder.gte('attendance_date', startDate);
    }

    if (endDate) {
      query_builder = query_builder.lte('attendance_date', endDate);
    }

    query_builder = query_builder
      .order('attendance_date', { ascending: false })
      .range((page - 1) * limit, page * limit - 1);

    const result = await query(query_builder);

    res.json({
      success: true,
      data: result.rows,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total: result.count || 0
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Get attendance records error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch attendance records',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Update attendance record
 * @route PUT /api/v1/attendance/:attendanceId
 * @access Admins, Teachers
 */
const updateAttendanceRecord = async (req, res) => {
  try {
    const { attendanceId } = req.params;
    const { isPresent, reason } = req.body;
    const userId = req.user?.userId || req.user?.id;

    console.log('🔧 Update attendance - User details:', {
      userId,
      userObject: req.user
    });

    if (!userId) {
      return res.status(400).json({
        success: false,
        message: 'User authentication required - no user ID found',
        timestamp: new Date().toISOString()
      });
    }

    const updateResult = await query(
      supabase
        .from('attendance')
        .update({
          is_present: isPresent,
          reason: reason || null,
          marked_by: userId
        })
        .eq('id', attendanceId)
        .select()
    );

    if (!updateResult.rows || updateResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Attendance record not found',
        timestamp: new Date().toISOString()
      });
    }

    // Recalculate attendance summary for affected student/term/quadrant
    const updatedRecord = updateResult.rows[0];
    await recalculateAttendanceSummary(
      updatedRecord.student_id,
      updatedRecord.term_id,
      updatedRecord.quadrant_id
    );

    res.json({
      success: true,
      data: updatedRecord,
      message: 'Attendance record updated successfully',
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Update attendance error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to update attendance record',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Mark attendance for multiple dates for a student
 * @route POST /api/v1/attendance/student/:studentId/bulk-mark
 * @access Admins, Teachers
 */
const bulkMarkStudentAttendance = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId, quadrantId, attendanceRecords } = req.body;
    const userId = req.user?.userId || req.user?.id;

    console.log('🔧 Bulk marking attendance:', {
      studentId,
      termId,
      quadrantId,
      userId,
      userObject: req.user,
      recordCount: attendanceRecords?.length
    });

    if (!termId || !quadrantId || !attendanceRecords || !Array.isArray(attendanceRecords)) {
      return res.status(400).json({
        success: false,
        message: 'Term ID, quadrant ID, and attendance records array are required',
        timestamp: new Date().toISOString()
      });
    }

    if (!userId) {
      console.error('❌ No user ID found in request:', req.user);
      return res.status(400).json({
        success: false,
        message: 'User authentication required - no user ID found',
        timestamp: new Date().toISOString()
      });
    }

    const results = [];
    const errors = [];

    for (const record of attendanceRecords) {
      try {
        const { attendanceDate, isPresent, reason } = record;

        console.log('📝 Marking attendance for date:', attendanceDate, 'User:', userId);

        // Upsert attendance record
        const upsertResult = await query(
          supabase
            .from('attendance')
            .upsert({
              student_id: studentId,
              term_id: termId,
              quadrant_id: quadrantId,
              attendance_date: attendanceDate,
              is_present: isPresent,
              reason: reason || null,
              marked_by: userId
            }, {
              onConflict: 'student_id,term_id,quadrant_id,attendance_date',
              ignoreDuplicates: false
            })
            .select()
        );

        if (upsertResult.rows && upsertResult.rows[0]) {
          results.push(upsertResult.rows[0]);
          console.log('✅ Successfully marked attendance for:', attendanceDate);
        } else {
          console.error('❌ No rows returned from upsert for:', attendanceDate);
        }
      } catch (error) {
        console.error(`❌ Error marking attendance for ${record.attendanceDate}:`, error);
        errors.push({
          date: record.attendanceDate,
          error: error.message
        });
      }
    }

    // Recalculate attendance summary
    await recalculateAttendanceSummary(studentId, termId, quadrantId);

    res.json({
      success: true,
      data: {
        successful: results,
        errors: errors,
        totalProcessed: attendanceRecords.length,
        successCount: results.length,
        errorCount: errors.length
      },
      message: `Bulk attendance marking completed. ${results.length} successful, ${errors.length} errors.`,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Bulk mark attendance error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to bulk mark attendance',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Get attendance statistics for a student
 * @route GET /api/v1/attendance/student/:studentId/stats
 * @access Admins, Teachers, Students (own data)
 */
const getStudentAttendanceStats = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId } = req.query;

    if (!termId) {
      return res.status(400).json({
        success: false,
        message: 'Term ID is required',
        timestamp: new Date().toISOString()
      });
    }

    // Get comprehensive stats using Supabase queries
    const attendanceRecordsResult = await query(
      supabase
        .from('attendance')
        .select(`
          quadrant_id,
          is_present,
          attendance_date,
          quadrants!inner(id, name, display_order)
        `)
        .eq('student_id', studentId)
        .eq('term_id', termId)
    );

    // Process results to calculate stats
    const statsByQuadrant = {};
    
    attendanceRecordsResult.rows.forEach(record => {
      const quadrantId = record.quadrant_id;
      
      if (!statsByQuadrant[quadrantId]) {
        statsByQuadrant[quadrantId] = {
          quadrant_id: quadrantId,
          quadrant_name: record.quadrants.name,
          total_marked_days: 0,
          present_days: 0,
          absent_days: 0,
          attendance_percentage: 0,
          first_marked_date: record.attendance_date,
          last_marked_date: record.attendance_date,
          display_order: record.quadrants.display_order
        };
      }

      const stats = statsByQuadrant[quadrantId];
      stats.total_marked_days++;
      
      if (record.is_present) {
        stats.present_days++;
      } else {
        stats.absent_days++;
      }

      // Update date range
      if (record.attendance_date < stats.first_marked_date) {
        stats.first_marked_date = record.attendance_date;
      }
      if (record.attendance_date > stats.last_marked_date) {
        stats.last_marked_date = record.attendance_date;
      }
    });

    // Calculate percentages
    Object.values(statsByQuadrant).forEach(stats => {
      stats.attendance_percentage = stats.total_marked_days > 0 
        ? Math.round((stats.present_days / stats.total_marked_days) * 100 * 100) / 100
        : 0;
    });

    // Convert to array and sort by display order
    const statsResult = { 
      rows: Object.values(statsByQuadrant).sort((a, b) => a.display_order - b.display_order) 
    };

    res.json({
      success: true,
      data: statsResult.rows,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Get attendance stats error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch attendance statistics',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

/**
 * Helper function to recalculate attendance summary
 */
async function recalculateAttendanceSummary(studentId, termId, quadrantId) {
  try {
    // Get total and attended sessions from actual attendance records
    const attendanceResult = await query(
      supabase
        .from('attendance')
        .select('is_present')
        .eq('student_id', studentId)
        .eq('term_id', termId)
        .eq('quadrant_id', quadrantId)
    );

    const total_sessions = attendanceResult.rows.length;
    const attended_sessions = attendanceResult.rows.filter(r => r.is_present).length;

    // Upsert attendance summary
    await query(
      supabase
        .from('attendance_summary')
        .upsert({
          student_id: studentId,
          term_id: termId,
          quadrant_id: quadrantId,
          total_sessions: parseInt(total_sessions) || 0,
          attended_sessions: parseInt(attended_sessions) || 0,
          last_updated: new Date().toISOString()
        }, {
          onConflict: 'student_id,term_id,quadrant_id',
          ignoreDuplicates: false
        })
    );

    console.log(`✅ Recalculated attendance summary for student ${studentId}, term ${termId}, quadrant ${quadrantId}`);
  } catch (error) {
    console.error('❌ Error recalculating attendance summary:', error);
  }
}

/**
 * Delete attendance record
 * @route DELETE /api/v1/attendance/:attendanceId
 * @access Admins only
 */
const deleteAttendanceRecord = async (req, res) => {
  try {
    const { attendanceId } = req.params;

    // First get the record details for recalculation
    const recordResult = await query(
      supabase
        .from('attendance')
        .select('student_id, term_id, quadrant_id')
        .eq('id', attendanceId)
        .limit(1)
    );

    if (!recordResult.rows || recordResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Attendance record not found',
        timestamp: new Date().toISOString()
      });
    }

    const record = recordResult.rows[0];

    // Delete the record
    await query(
      supabase
        .from('attendance')
        .delete()
        .eq('id', attendanceId)
    );

    // Recalculate attendance summary
    await recalculateAttendanceSummary(
      record.student_id,
      record.term_id,
      record.quadrant_id
    );

    res.json({
      success: true,
      message: 'Attendance record deleted successfully',
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Delete attendance error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to delete attendance record',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = {
  getStudentAttendanceSummary,
  getStudentAttendanceRecords,
  updateAttendanceRecord,
  bulkMarkStudentAttendance,
  getStudentAttendanceStats,
  deleteAttendanceRecord
};
