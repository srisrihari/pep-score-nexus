const express = require('express');
const router = express.Router();
const {
  getAllStudents,
  getStudentById,
  createStudent
} = require('../controllers/studentController');

// @route   GET /api/v1/students
// @desc    Get all students with pagination and filters
// @access  Public (TODO: Add authentication)
// @query   page, limit, search, batch, section, status
router.get('/', getAllStudents);

// @route   GET /api/v1/students/:id
// @desc    Get student by ID with detailed information
// @access  Public (TODO: Add authentication)
router.get('/:id', getStudentById);

// @route   POST /api/v1/students
// @desc    Create new student
// @access  Admin only (TODO: Add authentication middleware)
router.post('/', createStudent);

module.exports = router;
