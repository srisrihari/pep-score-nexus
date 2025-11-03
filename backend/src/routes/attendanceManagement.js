const express = require('express');
const router = express.Router();
const { authenticateToken, requireRole } = require('../middleware/auth');
const {
  getStudentAttendanceSummary,
  getStudentAttendanceRecords,
  updateAttendanceRecord,
  bulkMarkStudentAttendance,
  getStudentAttendanceStats,
  deleteAttendanceRecord
} = require('../controllers/attendanceManagementController');

/**
 * Comprehensive Attendance Management Routes
 * All routes require authentication and appropriate role permissions
 */

/**
 * @route   GET /api/v1/attendance-management/student/:studentId/summary
 * @desc    Get attendance summary for a student in a specific term
 * @access  Admins, Teachers, Students (own data)
 * @query   termId: string (required)
 */
router.get('/student/:studentId/summary', 
  authenticateToken,
  getStudentAttendanceSummary
);

/**
 * @route   GET /api/v1/attendance-management/student/:studentId/records
 * @desc    Get detailed attendance records for a student
 * @access  Admins, Teachers, Students (own data)
 * @query   termId: string (required), quadrantId?: string, startDate?: string, endDate?: string, page?: number, limit?: number
 */
router.get('/student/:studentId/records', 
  authenticateToken,
  getStudentAttendanceRecords
);

/**
 * @route   GET /api/v1/attendance-management/student/:studentId/stats
 * @desc    Get attendance statistics for a student
 * @access  Admins, Teachers, Students (own data)
 * @query   termId: string (required)
 */
router.get('/student/:studentId/stats', 
  authenticateToken,
  getStudentAttendanceStats
);

/**
 * @route   POST /api/v1/attendance-management/student/:studentId/bulk-mark
 * @desc    Mark attendance for multiple dates for a student
 * @access  Admins, Teachers
 * @body    { termId: string, quadrantId: string, attendanceRecords: Array<{ attendanceDate: string, isPresent: boolean, reason?: string }> }
 */
router.post('/student/:studentId/bulk-mark', 
  authenticateToken,
  requireRole('admin', 'teacher'),
  bulkMarkStudentAttendance
);

/**
 * @route   PUT /api/v1/attendance-management/record/:attendanceId
 * @desc    Update an existing attendance record
 * @access  Admins, Teachers
 * @body    { isPresent: boolean, reason?: string }
 */
router.put('/record/:attendanceId', 
  authenticateToken,
  requireRole('admin', 'teacher'),
  updateAttendanceRecord
);

/**
 * @route   DELETE /api/v1/attendance-management/record/:attendanceId
 * @desc    Delete an attendance record
 * @access  Admins only
 */
router.delete('/record/:attendanceId', 
  authenticateToken,
  requireRole('admin'),
  deleteAttendanceRecord
);

module.exports = router;









