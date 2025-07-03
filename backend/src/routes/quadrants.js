const express = require('express');
const router = express.Router();
const { authenticateToken, requireRole } = require('../middleware/auth');
const {
  getAllQuadrants,
  getQuadrantById,
  getQuadrantStats,
  createQuadrant,
  updateQuadrant,
  deleteQuadrant,
  getQuadrantHierarchy
} = require('../controllers/quadrantController');

/**
 * @route   GET /api/v1/quadrants
 * @desc    Get all quadrants
 * @access  Public
 */
router.get('/', getAllQuadrants);

/**
 * @route   GET /api/v1/quadrants/stats
 * @desc    Get quadrant statistics
 * @access  Public
 */
router.get('/stats', getQuadrantStats);

/**
 * @route   GET /api/v1/quadrants/:id/hierarchy
 * @desc    Get quadrant with full hierarchy (sub-categories, components, microcompetencies)
 * @access  Admin, Teacher
 * @params  id: quadrant ID
 * @query   includeInactive?: boolean
 */
router.get('/:id/hierarchy',
  authenticateToken,
  requireRole('admin', 'teacher'),
  getQuadrantHierarchy
);

/**
 * @route   GET /api/v1/quadrants/:id
 * @desc    Get quadrant by ID
 * @access  Public
 */
router.get('/:id', getQuadrantById);

/**
 * @route   POST /api/v1/quadrants
 * @desc    Create new quadrant
 * @access  Admin
 */
router.post('/',
  authenticateToken,
  requireRole('admin'),
  createQuadrant
);

/**
 * @route   PUT /api/v1/quadrants/:id
 * @desc    Update quadrant
 * @access  Admin
 * @params  id: quadrant ID
 */
router.put('/:id',
  authenticateToken,
  requireRole('admin'),
  updateQuadrant
);

/**
 * @route   DELETE /api/v1/quadrants/:id
 * @desc    Delete quadrant (soft delete)
 * @access  Admin
 * @params  id: quadrant ID
 */
router.delete('/:id',
  authenticateToken,
  requireRole('admin'),
  deleteQuadrant
);

module.exports = router;
