const express = require('express');
const router = express.Router();
const {
  getAllQuadrants,
  getQuadrantById,
  getQuadrantStats,
  createQuadrant
} = require('../controllers/quadrantController');

// @route   GET /api/v1/quadrants
// @desc    Get all quadrants
// @access  Public
router.get('/', getAllQuadrants);

// @route   GET /api/v1/quadrants/stats
// @desc    Get quadrant statistics
// @access  Public
router.get('/stats', getQuadrantStats);

// @route   GET /api/v1/quadrants/:id
// @desc    Get quadrant by ID
// @access  Public
router.get('/:id', getQuadrantById);

// @route   POST /api/v1/quadrants
// @desc    Create new quadrant
// @access  Admin only (TODO: Add authentication middleware)
router.post('/', createQuadrant);

module.exports = router;
