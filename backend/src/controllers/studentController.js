const { query, transaction } = require('../config/database');

// Get all students with pagination
const getAllStudents = async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const search = req.query.search || '';
    const batch = req.query.batch || '';
    const section = req.query.section || '';
    const status = req.query.status || '';

    let whereClause = 'WHERE s.status != \'Dropped\'';
    const queryParams = [];
    let paramCount = 0;

    if (search) {
      paramCount++;
      whereClause += ` AND (s.name ILIKE $${paramCount} OR s.registration_no ILIKE $${paramCount})`;
      queryParams.push(`%${search}%`);
    }

    if (batch) {
      paramCount++;
      whereClause += ` AND b.name = $${paramCount}`;
      queryParams.push(batch);
    }

    if (section) {
      paramCount++;
      whereClause += ` AND sec.name = $${paramCount}`;
      queryParams.push(section);
    }

    if (status) {
      paramCount++;
      whereClause += ` AND s.status = $${paramCount}`;
      queryParams.push(status);
    }

    // Get total count
    const countQuery = `
      SELECT COUNT(*) as total
      FROM students s
      LEFT JOIN batches b ON s.batch_id = b.id
      LEFT JOIN sections sec ON s.section_id = sec.id
      ${whereClause}
    `;
    const countResult = await query(countQuery, queryParams);
    const totalStudents = parseInt(countResult.rows[0].total);

    // Get students with pagination
    paramCount++;
    const limitParam = paramCount;
    paramCount++;
    const offsetParam = paramCount;
    
    const studentsQuery = `
      SELECT 
        s.id,
        s.registration_no,
        s.name,
        s.course,
        s.gender,
        s.phone,
        s.overall_score,
        s.grade,
        s.status,
        s.current_term,
        s.created_at,
        b.name as batch_name,
        b.year as batch_year,
        sec.name as section_name,
        h.name as house_name,
        h.color as house_color
      FROM students s
      LEFT JOIN batches b ON s.batch_id = b.id
      LEFT JOIN sections sec ON s.section_id = sec.id
      LEFT JOIN houses h ON s.house_id = h.id
      ${whereClause}
      ORDER BY s.created_at DESC
      LIMIT $${limitParam} OFFSET $${offsetParam}
    `;
    
    queryParams.push(limit, offset);
    const studentsResult = await query(studentsQuery, queryParams);

    const totalPages = Math.ceil(totalStudents / limit);

    res.status(200).json({
      success: true,
      message: 'Students retrieved successfully',
      data: studentsResult.rows,
      pagination: {
        currentPage: page,
        totalPages,
        totalStudents,
        studentsPerPage: limit,
        hasNextPage: page < totalPages,
        hasPrevPage: page > 1
      },
      filters: {
        search,
        batch,
        section,
        status
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching students:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve students',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get student by ID with detailed information
const getStudentById = async (req, res) => {
  try {
    const { id } = req.params;

    const studentQuery = `
      SELECT 
        s.id,
        s.registration_no,
        s.name,
        s.course,
        s.gender,
        s.phone,
        s.preferences,
        s.overall_score,
        s.grade,
        s.status,
        s.current_term,
        s.created_at,
        s.updated_at,
        b.name as batch_name,
        b.year as batch_year,
        sec.name as section_name,
        h.name as house_name,
        h.color as house_color,
        u.username,
        u.email
      FROM students s
      LEFT JOIN batches b ON s.batch_id = b.id
      LEFT JOIN sections sec ON s.section_id = sec.id
      LEFT JOIN houses h ON s.house_id = h.id
      LEFT JOIN users u ON s.user_id = u.id
      WHERE s.id = $1
    `;

    const studentResult = await query(studentQuery, [id]);

    if (studentResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    const student = studentResult.rows[0];

    // Get student's scores by quadrant
    const scoresQuery = `
      SELECT 
        q.id as quadrant_id,
        q.name as quadrant_name,
        q.weightage as quadrant_weightage,
        sc.name as sub_category_name,
        c.name as component_name,
        c.category,
        s.obtained_score,
        s.max_score,
        s.percentage,
        s.assessment_date,
        s.notes
      FROM scores s
      JOIN components c ON s.component_id = c.id
      JOIN sub_categories sc ON c.sub_category_id = sc.id
      JOIN quadrants q ON sc.quadrant_id = q.id
      WHERE s.student_id = $1
      ORDER BY q.display_order, sc.display_order, c.display_order
    `;

    const scoresResult = await query(scoresQuery, [id]);

    // Get attendance summary
    const attendanceQuery = `
      SELECT 
        q.id as quadrant_id,
        q.name as quadrant_name,
        a.total_sessions,
        a.attended_sessions,
        a.percentage,
        a.last_updated
      FROM attendance_summary a
      JOIN quadrants q ON a.quadrant_id = q.id
      WHERE a.student_id = $1
      ORDER BY q.display_order
    `;

    const attendanceResult = await query(attendanceQuery, [id]);

    res.status(200).json({
      success: true,
      message: 'Student details retrieved successfully',
      data: {
        ...student,
        scores: scoresResult.rows,
        attendance: attendanceResult.rows
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching student details:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve student details',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Create new student
const createStudent = async (req, res) => {
  try {
    const {
      username,
      email,
      password,
      registration_no,
      name,
      course,
      batch_id,
      section_id,
      house_id,
      gender,
      phone
    } = req.body;

    // Validation
    if (!username || !email || !password || !registration_no || !name || !course || !batch_id || !section_id || !gender) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields',
        required: ['username', 'email', 'password', 'registration_no', 'name', 'course', 'batch_id', 'section_id', 'gender'],
        timestamp: new Date().toISOString()
      });
    }

    // Use transaction to create user and student
    const result = await transaction(async (client) => {
      // Create user first
      const userResult = await client.query(`
        INSERT INTO users (username, email, password_hash, role)
        VALUES ($1, $2, $3, 'student')
        RETURNING id
      `, [username, email, password]); // Note: In production, hash the password

      const userId = userResult.rows[0].id;

      // Create student
      const studentResult = await client.query(`
        INSERT INTO students (
          user_id, registration_no, name, course, batch_id, section_id, house_id, gender, phone
        )
        VALUES ($1, $2, $3, $4, $5, $6, $7, $8, $9)
        RETURNING *
      `, [userId, registration_no, name, course, batch_id, section_id, house_id, gender, phone]);

      return studentResult.rows[0];
    });

    res.status(201).json({
      success: true,
      message: 'Student created successfully',
      data: result,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error creating student:', error);
    
    if (error.code === '23505') { // Unique violation
      return res.status(409).json({
        success: false,
        message: 'Student with this registration number or email already exists',
        timestamp: new Date().toISOString()
      });
    }
    
    res.status(500).json({
      success: false,
      message: 'Failed to create student',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = {
  getAllStudents,
  getStudentById,
  createStudent
};
