const express = require('express');
const router = express.Router();
const studentDeedController = require('../controllers/studentDeedController');
const { authenticateToken, requireRole } = require('../middleware/auth');

/**
 * @route   POST /api/v1/teachers/students/:studentId/deeds
 * @desc    Add a good/bad deed for a student
 * @access  Teacher, Admin
 */
router.post(
  '/teachers/students/:studentId/deeds',
  authenticateToken,
  requireRole('teacher', 'admin'),
  studentDeedController.addDeed
);

/**
 * @route   GET /api/v1/teachers/students/:studentId/deeds
 * @desc    Get all deeds for a student
 * @access  Teacher, Admin
 */
router.get(
  '/teachers/students/:studentId/deeds',
  authenticateToken,
  requireRole('teacher', 'admin'),
  studentDeedController.getStudentDeeds
);

/**
 * @route   GET /api/v1/teachers/students/:studentId/deeds/my
 * @desc    Get all deeds for a student by current teacher
 * @access  Teacher, Admin
 */
router.get(
  '/teachers/students/:studentId/deeds/my',
  authenticateToken,
  requireRole('teacher', 'admin'),
  studentDeedController.getMyDeedsForStudent
);

/**
 * @route   GET /api/v1/admin/students/:studentId/deeds
 * @desc    Admin view of all deeds (optional term filter)
 * @access  Admin
 */
router.get(
  '/admin/students/:studentId/deeds',
  authenticateToken,
  requireRole('admin'),
  studentDeedController.getAdminStudentDeeds
);

/**
 * @route   DELETE /api/v1/admin/deeds/:deedId
 * @desc    Delete a deed
 * @access  Admin
 */
router.delete(
  '/admin/deeds/:deedId',
  authenticateToken,
  requireRole('admin'),
  studentDeedController.deleteDeed
);

/**
 * @route   GET /api/v1/students/me/deeds
 * @desc    Get own deeds (student view)
 * @access  Student
 */
router.get(
  '/students/me/deeds',
  authenticateToken,
  requireRole('student'),
  studentDeedController.getOwnDeeds
);

module.exports = router;

