const express = require('express');
const router = express.Router();
const {
  getAllStudents,
  getStudentById,
  createStudent,
  getCurrentStudent,
  createStudentForExistingUser
} = require('../controllers/studentController');
const { authenticateToken, requireRole } = require('../middleware/auth');

// @route   GET /api/v1/students/me
// @desc    Get current student's profile
// @access  Students only
router.get('/me', authenticateToken, getCurrentStudent);

// @route   GET /api/v1/students
// @desc    Get all students with pagination and filters
// @access  Teachers, Admins
// @query   page, limit, search, batch, section, status
router.get('/', authenticateToken, requireRole('teacher', 'admin'), getAllStudents);

// @route   GET /api/v1/students/:id
// @desc    Get student by ID with detailed information
// @access  Teachers, Admins
router.get('/:id', authenticateToken, requireRole('teacher', 'admin'), getStudentById);

// @route   POST /api/v1/students
// @desc    Create new student
// @access  Admin only
router.post('/', authenticateToken, requireRole('admin'), createStudent);

// @route   POST /api/v1/students/create-for-user
// @desc    Create student record for existing user (temporary helper)
// @access  Admin only
router.post('/create-for-user', authenticateToken, requireRole('admin'), createStudentForExistingUser);

module.exports = router;
