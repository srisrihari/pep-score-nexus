const express = require('express');
const router = express.Router();
const { authenticateToken, requireRole } = require('../middleware/auth');
const {
  getDashboardOverview,
  getAllStudents,
  searchStudents,
  getStudentDetails,
  addStudent,
  updateStudent,
  deleteStudent,
  getAllTeachers,
  addTeacher,
  updateTeacher
} = require('../controllers/adminController');

// Admin Dashboard
router.get('/dashboard', authenticateToken, requireRole('admin'), getDashboardOverview);

// Student Management
router.get('/students', authenticateToken, requireRole('admin'), getAllStudents);
router.get('/students/search', authenticateToken, requireRole('admin'), searchStudents);
router.get('/students/:studentId', authenticateToken, requireRole('admin'), getStudentDetails);
router.post('/students', authenticateToken, requireRole('admin'), addStudent);
router.put('/students/:studentId', authenticateToken, requireRole('admin'), updateStudent);
router.delete('/students/:studentId', authenticateToken, requireRole('admin'), deleteStudent);

// Teacher Management
router.get('/teachers', authenticateToken, requireRole('admin'), getAllTeachers);
router.post('/teachers', authenticateToken, requireRole('admin'), addTeacher);
router.put('/teachers/:teacherId', authenticateToken, requireRole('admin'), updateTeacher);

module.exports = router; 