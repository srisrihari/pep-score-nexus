const { supabase, query } = require('../config/supabase');
const { transaction } = require('../config/database');

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

    // Build Supabase query with filters
    let studentsQuery = supabase
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
        created_at,
        batches:batch_id(name, year),
        sections:section_id(name),
        houses:house_id(name, color)
      `)
      .neq('status', 'Dropped');

    // Apply filters
    if (search) {
      studentsQuery = studentsQuery.or(`name.ilike.%${search}%,registration_no.ilike.%${search}%`);
    }

    if (batch) {
      studentsQuery = studentsQuery.eq('batches.name', batch);
    }

    if (section) {
      studentsQuery = studentsQuery.eq('sections.name', section);
    }

    if (status) {
      studentsQuery = studentsQuery.eq('status', status);
    }

    // Get total count for pagination
    const countQuery = supabase
      .from('students')
      .select('*', { count: 'exact', head: true })
      .neq('status', 'Dropped');

    // Apply same filters to count query
    let finalCountQuery = countQuery;
    if (search) {
      finalCountQuery = finalCountQuery.or(`name.ilike.%${search}%,registration_no.ilike.%${search}%`);
    }
    if (status) {
      finalCountQuery = finalCountQuery.eq('status', status);
    }

    // Execute count query
    const { count: totalStudents } = await finalCountQuery;

    // Execute main query with pagination
    const result = await query(
      studentsQuery
        .order('created_at', { ascending: false })
        .range(offset, offset + limit - 1)
    );

    const totalPages = Math.ceil((totalStudents || 0) / limit);

    // Transform data to match expected format
    const transformedData = result.rows.map(student => ({
      ...student,
      batch_name: student.batches?.name || null,
      batch_year: student.batches?.year || null,
      section_name: student.sections?.name || null,
      house_name: student.houses?.name || null,
      house_color: student.houses?.color || null
    }));

    res.status(200).json({
      success: true,
      message: 'Students retrieved successfully',
      data: transformedData,
      pagination: {
        currentPage: page,
        totalPages,
        totalStudents: totalStudents || 0,
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

// Get current user's student profile
const getCurrentStudent = async (req, res) => {
  try {
    if (req.user.role !== 'student') {
      return res.status(403).json({
        success: false,
        message: 'Access denied. Only students can access this endpoint.',
        timestamp: new Date().toISOString()
      });
    }

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
          preferences,
          overall_score,
          grade,
          status,
          current_term,
          created_at,
          updated_at,
          batches:batch_id(name, year),
          sections:section_id(name),
          houses:house_id(name, color)
        `)
        .eq('user_id', req.user.userId)
        .limit(1)
    );

    if (!studentResult.rows || studentResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student profile not found',
        timestamp: new Date().toISOString()
      });
    }

    const student = studentResult.rows[0];

    // Transform data to match expected format
    const transformedData = {
      ...student,
      batch_name: student.batches?.name || null,
      batch_year: student.batches?.year || null,
      section_name: student.sections?.name || null,
      house_name: student.houses?.name || null,
      house_color: student.houses?.color || null
    };

    res.status(200).json({
      success: true,
      message: 'Current student profile retrieved successfully',
      data: transformedData,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching current student:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve current student profile',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Create student record for existing user (temporary helper)
const createStudentForExistingUser = async (req, res) => {
  try {
    const {
      username,
      registration_no,
      name,
      email,
      batch_id,
      section_id,
      house_id,
      gender,
      date_of_birth,
      phone,
      address,
      emergency_contact_name,
      emergency_contact_phone
    } = req.body;

    // Validation
    if (!username || !registration_no || !name) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: username, registration_no, name',
        timestamp: new Date().toISOString()
      });
    }

    // Create supporting data using Supabase
    console.log('Creating supporting data...');
    
    // Check if batch exists, create if not
    let batchResult = await query(
      supabase
        .from('batches')
        .select('id')
        .eq('name', 'Batch 2024')
        .limit(1)
    );

    let batchId;
    if (batchResult.rows.length === 0) {
      const newBatch = await supabase
        .from('batches')
        .insert({
          name: 'Batch 2024',
          year: 2024,
          start_date: '2024-01-01',
          end_date: '2024-12-31',
          is_active: true
        })
        .select()
        .single();
      
      if (newBatch.error) throw newBatch.error;
      batchId = newBatch.data.id;
    } else {
      batchId = batchResult.rows[0].id;
    }

    // Check if section exists, create if not
    let sectionResult = await query(
      supabase
        .from('sections')
        .select('id')
        .eq('name', 'Section A')
        .eq('batch_id', batchId)
        .limit(1)
    );

    let sectionId;
    if (sectionResult.rows.length === 0) {
      const newSection = await supabase
        .from('sections')
        .insert({
          name: 'Section A',
          batch_id: batchId,
          capacity: 50,
          is_active: true
        })
        .select()
        .single();
      
      if (newSection.error) throw newSection.error;
      sectionId = newSection.data.id;
    } else {
      sectionId = sectionResult.rows[0].id;
    }

    // Check if house exists, create if not
    let houseResult = await query(
      supabase
        .from('houses')
        .select('id')
        .eq('name', 'Red House')
        .limit(1)
    );

    let houseId;
    if (houseResult.rows.length === 0) {
      const newHouse = await supabase
        .from('houses')
        .insert({
          name: 'Red House',
          description: 'Red house for students',
          color: '#EF4444',
          is_active: true
        })
        .select()
        .single();
      
      if (newHouse.error) throw newHouse.error;
      houseId = newHouse.data.id;
    } else {
      houseId = houseResult.rows[0].id;
    }

    // Get user ID
    const userResult = await query(
      supabase
        .from('users')
        .select('id')
        .eq('username', username)
        .limit(1)
    );

    if (userResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: `User with username '${username}' not found`,
        timestamp: new Date().toISOString()
      });
    }

    const userId = userResult.rows[0].id;
    console.log('Found user ID:', userId);

    // Create student record
    const studentData = {
      user_id: userId,
      registration_no,
      name,
      course: 'General Course', // Required field
      batch_id: batchId,
      section_id: sectionId,
      house_id: houseId,
      gender: gender || 'Male',
      phone: phone || '+1234567890',
      preferences: {
        address: address || '123 Test Street',
        emergency_contact_name: emergency_contact_name || 'Emergency Contact',
        emergency_contact_phone: emergency_contact_phone || '+1234567891',
        date_of_birth: date_of_birth || '2000-01-01'
      },
      status: 'Active',
      current_term: 'Term1'
    };

    const studentResult = await supabase
      .from('students')
      .upsert(studentData, { onConflict: 'user_id' })
      .select()
      .single();

    if (studentResult.error) {
      throw studentResult.error;
    }

    res.status(201).json({
      success: true,
      message: 'Student record created successfully for existing user',
      data: studentResult.data,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error creating student record:', error);
    
    res.status(500).json({
      success: false,
      message: 'Failed to create student record',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = {
  getAllStudents,
  getStudentById,
  createStudent,
  getCurrentStudent,
  createStudentForExistingUser
};
