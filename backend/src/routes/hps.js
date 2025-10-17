const express = require('express');
const router = express.Router();
const hpsController = require('../controllers/hpsController');
const { authenticateToken } = require('../middleware/auth');
const { validateParams } = require('../middleware/validation');

// Calculate HPS for a single student
router.post(
    '/calculate/:studentId/:termId',
    authenticateToken,
    validateParams(['studentId', 'termId']),
    hpsController.calculateStudentHPS
);

// Calculate HPS for all students in a term
router.post(
    '/calculate-batch/:termId',
    authenticateToken,
    validateParams(['termId']),
    hpsController.calculateBatchHPS
);

// Get HPS details for a student
router.get(
    '/details/:studentId/:termId',
    authenticateToken,
    validateParams(['studentId', 'termId']),
    hpsController.getHPSDetails
);

// Get HPS calculation history for a student
router.get(
    '/history/:studentId/:termId',
    authenticateToken,
    validateParams(['studentId', 'termId']),
    hpsController.getHPSHistory
);

// Process HPS calculation queue
router.post(
    '/process-queue',
    authenticateToken,
    hpsController.processQueue
);

module.exports = router;
