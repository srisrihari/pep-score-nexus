const express = require('express');
const { register, login, getProfile, refreshToken, logout } = require('../controllers/authController');
const { authenticateToken } = require('../middleware/auth');

const router = express.Router();

// Public routes (no authentication required)
router.post('/register', register);
router.post('/login', login);
router.post('/refresh', refreshToken);

// Protected routes (authentication required)
router.get('/profile', authenticateToken, getProfile);
router.post('/logout', authenticateToken, logout);

// Token validation endpoint
router.get('/validate', authenticateToken, (req, res) => {
  res.status(200).json({
    success: true,
    message: 'Token is valid',
    data: {
      user: req.user.userDetails,
      role: req.user.role
    },
    timestamp: new Date().toISOString()
  });
});

module.exports = router; 