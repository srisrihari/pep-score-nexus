const bcrypt = require('bcryptjs');
const jwt = require('jsonwebtoken');
const { supabase, query } = require('../config/supabase');

// JWT secret from environment variables
const JWT_SECRET = process.env.JWT_SECRET || 'your-super-secret-jwt-key-change-this-in-production';
const JWT_REFRESH_SECRET = process.env.JWT_REFRESH_SECRET || 'your-super-secret-refresh-key-change-this-in-production';
const JWT_EXPIRES_IN = process.env.JWT_EXPIRES_IN || '24h';
const JWT_REFRESH_EXPIRES_IN = process.env.JWT_REFRESH_EXPIRES_IN || '7d';

// Helper function to generate JWT token
const generateToken = (userId, role) => {
  return jwt.sign(
    { userId, role },
    JWT_SECRET,
    { expiresIn: JWT_EXPIRES_IN }
  );
};

// Helper function to generate refresh token
const generateRefreshToken = (userId, role) => {
  return jwt.sign(
    { userId, role, type: 'refresh' },
    JWT_REFRESH_SECRET,
    { expiresIn: JWT_REFRESH_EXPIRES_IN }
  );
};

// Register new user
const register = async (req, res) => {
  try {
    const { username, email, password, role = 'student', name, additionalData = {} } = req.body;

    // Validation
    if (!username || !email || !password || !name) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: username, email, password, name',
        timestamp: new Date().toISOString()
      });
    }

    // Check if user already exists
    const existingUser = await query(
      supabase
        .from('users')
        .select('id, username, email')
        .or(`username.eq.${username},email.eq.${email}`)
        .limit(1)
    );

    if (existingUser.rows.length > 0) {
      return res.status(409).json({
        success: false,
        message: 'User with this username or email already exists',
        timestamp: new Date().toISOString()
      });
    }

    // Hash password
    const saltRounds = 12;
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    // Create user
    const userResult = await query(
      supabase
        .from('users')
        .insert({
          username,
          email,
          password_hash: hashedPassword,
          role,
          status: 'active'
        })
        .select('id, username, email, role, status, created_at')
    );

    if (!userResult.rows || userResult.rows.length === 0) {
      throw new Error('Failed to create user');
    }

    const newUser = userResult.rows[0];

    // Create role-specific profile (student, teacher, admin)
    if (role === 'student' && additionalData.registration_no) {
      await query(
        supabase
          .from('students')
          .insert({
            user_id: newUser.id,
            registration_no: additionalData.registration_no,
            name,
            course: additionalData.course || 'PGDM',
            batch_id: additionalData.batch_id,
            section_id: additionalData.section_id,
            house_id: additionalData.house_id,
            gender: additionalData.gender,
            phone: additionalData.phone
          })
      );
    } else if (role === 'teacher' && additionalData.employee_id) {
      await query(
        supabase
          .from('teachers')
          .insert({
            user_id: newUser.id,
            employee_id: additionalData.employee_id,
            name,
            specialization: additionalData.specialization,
            department: additionalData.department
          })
      );
    } else if (role === 'admin') {
      await query(
        supabase
          .from('admins')
          .insert({
            user_id: newUser.id,
            name,
            access_level: additionalData.access_level || 'standard'
          })
      );
    }

    // Generate JWT tokens
    const token = generateToken(newUser.id, newUser.role);
    const refreshToken = generateRefreshToken(newUser.id, newUser.role);

    res.status(201).json({
      success: true,
      message: 'User registered successfully',
      data: {
        user: {
          id: newUser.id,
          username: newUser.username,
          email: newUser.email,
          role: newUser.role,
          status: newUser.status,
          created_at: newUser.created_at
        },
        token,
        refreshToken
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Registration error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to register user',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Login user
const login = async (req, res) => {
  try {
    const { username, password } = req.body;

    // Validation
    if (!username || !password) {
      return res.status(400).json({
        success: false,
        message: 'Username and password are required',
        timestamp: new Date().toISOString()
      });
    }

    // Find user by username or email
    const userResult = await query(
      supabase
        .from('users')
        .select('id, username, email, password_hash, role, status, last_login')
        .or(`username.eq.${username},email.eq.${username}`)
        .eq('status', 'active')
        .limit(1)
    );

    if (!userResult.rows || userResult.rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: 'Invalid credentials',
        timestamp: new Date().toISOString()
      });
    }

    const user = userResult.rows[0];

    // Verify password
    const isValidPassword = await bcrypt.compare(password, user.password_hash);
    if (!isValidPassword) {
      return res.status(401).json({
        success: false,
        message: 'Invalid credentials',
        timestamp: new Date().toISOString()
      });
    }

    // Update last login
    await query(
      supabase
        .from('users')
        .update({ last_login: new Date().toISOString() })
        .eq('id', user.id)
    );

    // Generate JWT tokens
    const token = generateToken(user.id, user.role);
    const refreshToken = generateRefreshToken(user.id, user.role);

    // Get role-specific profile data
    let profileData = null;
    if (user.role === 'student') {
      const studentResult = await query(
        supabase
          .from('students')
          .select(`
            id,
            registration_no,
            name,
            course,
            overall_score,
            grade,
            status,
            batches:batch_id(name, year),
            sections:section_id(name),
            houses:house_id(name, color)
          `)
          .eq('user_id', user.id)
          .limit(1)
      );
      profileData = studentResult.rows[0] || null;
    } else if (user.role === 'teacher') {
      const teacherResult = await query(
        supabase
          .from('teachers')
          .select('id, employee_id, name, specialization, department, is_active')
          .eq('user_id', user.id)
          .limit(1)
      );
      profileData = teacherResult.rows[0] || null;
    } else if (user.role === 'admin') {
      const adminResult = await query(
        supabase
          .from('admins')
          .select('id, name, access_level, permissions')
          .eq('user_id', user.id)
          .limit(1)
      );
      profileData = adminResult.rows[0] || null;
    }

    res.status(200).json({
      success: true,
      message: 'Login successful',
      data: {
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          role: user.role,
          status: user.status,
          last_login: user.last_login
        },
        profile: profileData,
        token,
        refreshToken
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Login error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to login',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get current user profile
const getProfile = async (req, res) => {
  try {
    const userId = req.user.userId; // From JWT middleware

    // Get user data
    const userResult = await query(
      supabase
        .from('users')
        .select('id, username, email, role, status, last_login, created_at')
        .eq('id', userId)
        .limit(1)
    );

    if (!userResult.rows || userResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'User not found',
        timestamp: new Date().toISOString()
      });
    }

    const user = userResult.rows[0];

    // Get role-specific profile data
    let profileData = null;
    if (user.role === 'student') {
      const studentResult = await query(
        supabase
          .from('students')
          .select(`
            id,
            registration_no,
            name,
            course,
            gender,
            phone,
            overall_score,
            grade,
            status,
            current_term,
            preferences,
            created_at,
            batches:batch_id(name, year),
            sections:section_id(name),
            houses:house_id(name, color)
          `)
          .eq('user_id', user.id)
          .limit(1)
      );
      profileData = studentResult.rows[0] || null;
    } else if (user.role === 'teacher') {
      const teacherResult = await query(
        supabase
          .from('teachers')
          .select('*')
          .eq('user_id', user.id)
          .limit(1)
      );
      profileData = teacherResult.rows[0] || null;
    } else if (user.role === 'admin') {
      const adminResult = await query(
        supabase
          .from('admins')
          .select('*')
          .eq('user_id', user.id)
          .limit(1)
      );
      profileData = adminResult.rows[0] || null;
    }

    res.status(200).json({
      success: true,
      message: 'Profile retrieved successfully',
      data: {
        user,
        profile: profileData
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Get profile error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to get profile',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Refresh token
const refreshToken = async (req, res) => {
  try {
    const { refreshToken } = req.body;

    if (!refreshToken) {
      return res.status(400).json({
        success: false,
        message: 'Refresh token is required',
        timestamp: new Date().toISOString()
      });
    }

    // Verify refresh token
    let decoded;
    try {
      decoded = jwt.verify(refreshToken, JWT_REFRESH_SECRET);
    } catch (error) {
      return res.status(401).json({
        success: false,
        message: 'Invalid refresh token',
        timestamp: new Date().toISOString()
      });
    }

    // Check if it's a refresh token
    if (decoded.type !== 'refresh') {
      return res.status(401).json({
        success: false,
        message: 'Invalid token type',
        timestamp: new Date().toISOString()
      });
    }

    // Verify user still exists and is active
    const userResult = await query(
      supabase
        .from('users')
        .select('id, username, email, role, status')
        .eq('id', decoded.userId)
        .eq('status', 'active')
        .limit(1)
    );

    if (!userResult.rows || userResult.rows.length === 0) {
      return res.status(401).json({
        success: false,
        message: 'User not found or inactive',
        timestamp: new Date().toISOString()
      });
    }

    const user = userResult.rows[0];

    // Generate new tokens
    const newToken = generateToken(user.id, user.role);
    const newRefreshToken = generateRefreshToken(user.id, user.role);

    res.status(200).json({
      success: true,
      message: 'Token refreshed successfully',
      data: {
        token: newToken,
        refreshToken: newRefreshToken,
        user: {
          id: user.id,
          username: user.username,
          email: user.email,
          role: user.role
        }
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Refresh token error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to refresh token',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Logout user (optional - mainly for token invalidation in future)
const logout = async (req, res) => {
  try {
    // In a more sophisticated setup, you might invalidate the token here
    // For now, we'll just return success
    res.status(200).json({
      success: true,
      message: 'Logout successful',
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Logout error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to logout',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = {
  register,
  login,
  getProfile,
  refreshToken,
  logout
};