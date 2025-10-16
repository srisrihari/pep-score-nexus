const express = require('express');
const router = express.Router();
const { authenticateToken, requireRole } = require('../middleware/auth');
const {
  getHPSStats,
  recalculateStudentHPS,
  recalculateBatchHPS,
  clearHPSCache,
  getHPSAuditLogs,
  getScheduledJobs,
  processRecalculationQueue,
  runConsistencyCheck
} = require('../controllers/hpsManagementController');

/**
 * HPS Management Routes
 *
 * Provides comprehensive API endpoints for managing the HPS calculation system
 */

// All routes require authentication and admin role (except where noted)
router.use(authenticateToken);
router.use(requireRole('admin'));

/**
 * @route   GET /api/v1/admin/hps/stats
 * @desc    Get HPS system statistics and health
 * @access  Admin only
 */
router.get('/stats', getHPSStats);

/**
 * @route   POST /api/v1/admin/hps/recalculate/student
 * @desc    Trigger manual HPS recalculation for a specific student
 * @access  Admin only
 * @body    { studentId: string, termId: string }
 */
router.post('/recalculate/student', recalculateStudentHPS);

/**
 * @route   POST /api/v1/admin/hps/recalculate/batch
 * @desc    Trigger manual batch HPS recalculation
 * @access  Admin only
 * @body    { batchId?: string, termId?: string, allTerms?: boolean }
 */
router.post('/recalculate/batch', recalculateBatchHPS);

/**
 * @route   DELETE /api/v1/admin/hps/cache
 * @desc    Clear HPS cache for specific student-term or all cache
 * @access  Admin only
 * @query   { studentId?: string, termId?: string, all?: boolean }
 */
router.delete('/cache', clearHPSCache);

/**
 * @route   GET /api/v1/admin/hps/audit
 * @desc    Get HPS calculation audit logs
 * @access  Admin only
 * @query   { limit?: number, offset?: number, studentId?: string, termId?: string }
 */
router.get('/audit', getHPSAuditLogs);

/**
 * @route   GET /api/v1/admin/hps/jobs
 * @desc    Get scheduled jobs status
 * @access  Admin only
 * @query   { status?: string, jobType?: string, limit?: number, offset?: number }
 */
router.get('/jobs', getScheduledJobs);

/**
 * @route   POST /api/v1/admin/hps/process-queue
 * @desc    Force process recalculation queue immediately
 * @access  Admin only
 */
router.post('/process-queue', processRecalculationQueue);

/**
 * @route   POST /api/v1/admin/hps/consistency-check
 * @desc    Run consistency check manually
 * @access  Admin only
 * @body    { termId?: string, fixInconsistencies?: boolean }
 */
router.post('/consistency-check', runConsistencyCheck);

module.exports = router;

