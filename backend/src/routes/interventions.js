const express = require('express');
const router = express.Router();
const { authenticateToken, requireRole } = require('../middleware/auth');
const {
  createIntervention,
  getAllInterventions,
  getInterventionById,
  updateIntervention,
  assignTeachers,
  enrollStudents,
  getInterventionAnalytics,
  updateInterventionStatus,
  createTask,
  getTeacherInterventions,
  getTeacherInterventionDetails,
  getTeacherSubmissions,
  gradeSubmission
} = require('../controllers/interventionController');

// ==========================================
// ADMIN INTERVENTION ROUTES
// ==========================================

/**
 * @route   POST /api/v1/interventions
 * @desc    Create new intervention
 * @access  Admin only
 * @body    {
 *   name: string,
 *   description: string,
 *   startDate: string (YYYY-MM-DD),
 *   endDate: string (YYYY-MM-DD),
 *   quadrantWeightages: object,
 *   prerequisites: array,
 *   maxStudents: number,
 *   objectives: array
 * }
 */
router.post('/',
  authenticateToken,
  requireRole('admin'),
  createIntervention
);

/**
 * @route   GET /api/v1/interventions
 * @desc    Get all interventions with filtering and pagination
 * @access  Admin only
 * @query   {
 *   status?: string,
 *   page?: number,
 *   limit?: number,
 *   search?: string,
 *   sortBy?: string,
 *   sortOrder?: 'asc' | 'desc'
 * }
 */
router.get('/',
  authenticateToken,
  requireRole('admin'),
  getAllInterventions
);

/**
 * @route   GET /api/v1/interventions/:id
 * @desc    Get intervention details by ID
 * @access  Admin only
 * @params  id: intervention UUID
 */
router.get('/:id',
  authenticateToken,
  requireRole('admin'),
  getInterventionById
);

/**
 * @route   PUT /api/v1/interventions/:id
 * @desc    Update intervention details
 * @access  Admin only
 * @params  id: intervention UUID
 * @body    {
 *   name?: string,
 *   description?: string,
 *   startDate?: string,
 *   endDate?: string,
 *   quadrantWeightages?: object,
 *   prerequisites?: array,
 *   maxStudents?: number,
 *   objectives?: array
 * }
 */
router.put('/:id',
  authenticateToken,
  requireRole('admin'),
  updateIntervention
);

/**
 * @route   POST /api/v1/interventions/:id/assign-teachers
 * @desc    Assign teachers to intervention
 * @access  Admin only
 * @params  id: intervention UUID
 * @body    {
 *   teachers: [
 *     {
 *       teacherId: string,
 *       assignedQuadrants: array,
 *       role: 'Lead' | 'Assistant',
 *       permissions: array
 *     }
 *   ]
 * }
 */
router.post('/:id/assign-teachers',
  authenticateToken,
  requireRole('admin'),
  assignTeachers
);

/**
 * @route   POST /api/v1/interventions/:id/enroll-students
 * @desc    Enroll students in intervention
 * @access  Admin only
 * @params  id: intervention UUID
 * @body    {
 *   students: array of student UUIDs,
 *   enrollmentType: 'Mandatory' | 'Optional'
 * }
 */
router.post('/:id/enroll-students',
  authenticateToken,
  requireRole('admin'),
  enrollStudents
);

/**
 * @route   GET /api/v1/interventions/:id/analytics
 * @desc    Get intervention analytics and statistics
 * @access  Admin only
 * @params  id: intervention UUID
 */
router.get('/:id/analytics',
  authenticateToken,
  requireRole('admin'),
  getInterventionAnalytics
);

/**
 * @route   PUT /api/v1/interventions/:id/status
 * @desc    Update intervention status
 * @access  Admin only
 * @params  id: intervention UUID
 * @body    {
 *   status: 'Draft' | 'Active' | 'Completed' | 'Archived' | 'Cancelled'
 * }
 */
router.put('/:id/status',
  authenticateToken,
  requireRole('admin'),
  updateInterventionStatus
);

/**
 * @route   POST /api/v1/interventions/:interventionId/tasks
 * @desc    Create task for intervention (Admin only)
 * @access  Admin only
 * @params  interventionId: intervention UUID
 * @body    {
 *   name: string,
 *   description: string,
 *   quadrantId: string,
 *   componentId: string,
 *   maxScore: number,
 *   dueDate: string,
 *   instructions: string,
 *   rubric: array,
 *   submissionType: string,
 *   allowLateSubmission: boolean,
 *   latePenalty: number
 * }
 */
router.post('/:interventionId/tasks',
  authenticateToken,
  requireRole('admin'),
  createTask
);

// ==========================================
// TEACHER INTERVENTION ROUTES
// ==========================================

/**
 * @route   GET /api/v1/interventions/teachers/:teacherId
 * @desc    Get teacher's assigned interventions
 * @access  Teacher or Admin
 * @params  teacherId: teacher UUID
 */
router.get('/teachers/:teacherId',
  authenticateToken,
  requireRole('teacher', 'admin'),
  getTeacherInterventions
);

/**
 * @route   GET /api/v1/interventions/teachers/:teacherId/:interventionId
 * @desc    Get specific intervention details for teacher
 * @access  Teacher or Admin
 * @params  teacherId: teacher UUID, interventionId: intervention UUID
 */
router.get('/teachers/:teacherId/:interventionId',
  authenticateToken,
  requireRole('teacher', 'admin'),
  getTeacherInterventionDetails
);

/**
 * @route   GET /api/v1/interventions/teachers/:teacherId/:interventionId/submissions
 * @desc    Get task submissions for teacher review
 * @access  Teacher or Admin
 * @params  teacherId: teacher UUID, interventionId: intervention UUID
 * @query   taskId?: string, status?: string
 */
router.get('/teachers/:teacherId/:interventionId/submissions',
  authenticateToken,
  requireRole('teacher', 'admin'),
  getTeacherSubmissions
);

/**
 * @route   POST /api/v1/interventions/teachers/:teacherId/:interventionId/submissions/:submissionId/grade
 * @desc    Grade a task submission
 * @access  Teacher or Admin
 * @params  teacherId: teacher UUID, interventionId: intervention UUID, submissionId: submission UUID
 * @body    {
 *   score: number,
 *   feedback: string,
 *   privateNotes: string
 * }
 */
router.post('/teachers/:teacherId/:interventionId/submissions/:submissionId/grade',
  authenticateToken,
  requireRole('teacher', 'admin'),
  gradeSubmission
);

module.exports = router;
