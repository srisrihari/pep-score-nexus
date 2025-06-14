const { supabase } = require('../config/supabase');
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

// Get student performance data for dashboard
const getStudentPerformance = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId, includeHistory } = req.query;

    // Get student basic info
    const studentQuery = `
      SELECT 
        s.id,
        s.registration_no,
        s.name,
        s.course,
        s.gender,
        s.current_term,
        s.overall_score,
        s.grade,
        b.name as batch_name,
        b.year as batch_year,
        sec.name as section_name,
        h.name as house_name,
        h.color as house_color
      FROM students s
      LEFT JOIN batches b ON s.batch_id = b.id
      LEFT JOIN sections sec ON s.section_id = sec.id
      LEFT JOIN houses h ON s.house_id = h.id
      WHERE s.id = $1
    `;

    const studentResult = await query(studentQuery, [studentId]);

    if (studentResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    const student = studentResult.rows[0];

    // Get current term if not specified
    let currentTermId = termId;
    if (!currentTermId) {
      const termQuery = `SELECT id, name FROM terms WHERE is_current = true LIMIT 1`;
      const termResult = await query(termQuery);
      if (termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get student term data
    const studentTermQuery = `
      SELECT 
        st.total_score,
        st.grade,
        st.overall_status,
        st.rank,
        st.is_eligible,
        t.name as term_name
      FROM student_terms st
      JOIN terms t ON st.term_id = t.id
      WHERE st.student_id = $1 AND st.term_id = $2
    `;

    const studentTermResult = await query(studentTermQuery, [studentId, currentTermId]);

    // Get quadrant performance with attendance
    const quadrantQuery = `
      SELECT 
        q.id,
        q.name,
        q.weightage,
        COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) as obtained,
        CASE 
          WHEN COALESCE(att.percentage, 0) >= q.minimum_attendance THEN 'Cleared'
          ELSE CASE 
            WHEN COALESCE(att.percentage, 0) < q.minimum_attendance THEN 'Attendance Shortage'
            WHEN COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) / q.weightage * 100 >= 40 THEN 'Cleared'
            ELSE 'Not Cleared'
          END
        END as status,
        COALESCE(att.percentage, 0) as attendance,
        CASE 
          WHEN COALESCE(att.percentage, 0) >= q.minimum_attendance THEN 'Eligible'
          ELSE 'Not Eligible'
        END as eligibility,
        DENSE_RANK() OVER (PARTITION BY q.id ORDER BY 
          COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) DESC
        ) as rank
      FROM quadrants q
      LEFT JOIN sub_categories subcats ON subcats.quadrant_id = q.id
      LEFT JOIN components c ON c.sub_category_id = subcats.id
      LEFT JOIN scores sc ON sc.component_id = c.id AND sc.student_id = $1 AND sc.term_id = $2
      LEFT JOIN attendance_summary att ON att.student_id = $1 AND att.term_id = $2 AND att.quadrant_id = q.id
      WHERE q.is_active = true
      GROUP BY q.id, q.name, q.weightage, q.display_order, att.percentage
      ORDER BY q.display_order
    `;

    const quadrantResult = await query(quadrantQuery, [studentId, currentTermId]);

    // Get components for each quadrant
    const componentsQuery = `
      SELECT 
        c.id,
        c.name,
        c.category,
        c.max_score,
        sc.obtained_score as score,
        sc.assessment_date,
        sc.notes,
        subcats.quadrant_id,
        CASE 
          WHEN sc.obtained_score >= c.max_score * 0.8 THEN 'Good'
          WHEN sc.obtained_score >= c.max_score * 0.6 THEN 'Progress'
          ELSE 'Deteriorate'
        END as status
      FROM components c
      JOIN sub_categories subcats ON c.sub_category_id = subcats.id
      JOIN quadrants q ON subcats.quadrant_id = q.id
      LEFT JOIN scores sc ON sc.component_id = c.id AND sc.student_id = $1 AND sc.term_id = $2
      WHERE q.is_active = true AND c.is_active = true
      ORDER BY q.display_order, subcats.display_order, c.display_order
    `;

    const componentsResult = await query(componentsQuery, [studentId, currentTermId]);

    // Group components by quadrant
    const componentsByQuadrant = {};
    componentsResult.rows.forEach(comp => {
      if (!componentsByQuadrant[comp.quadrant_id]) {
        componentsByQuadrant[comp.quadrant_id] = [];
      }
      componentsByQuadrant[comp.quadrant_id].push({
        id: comp.id,
        name: comp.name,
        score: comp.score || 0,
        maxScore: comp.max_score,
        category: comp.category,
        status: comp.status
      });
    });

    // Get test scores (ESPA etc.)
    const testQuery = `
      SELECT 
        c.name as test_name,
        sc.obtained_score,
        c.max_score,
        sc.assessment_date
      FROM scores sc
      JOIN components c ON sc.component_id = c.id
      WHERE sc.student_id = $1 AND sc.term_id = $2 AND c.category = 'SHL'
      ORDER BY sc.assessment_date DESC
    `;

    const testResult = await query(testQuery, [studentId, currentTermId]);

    // Format quadrant data
    const quadrants = quadrantResult.rows.map(q => ({
      id: q.id,
      name: q.name,
      weightage: parseFloat(q.weightage),
      obtained: parseFloat(q.obtained),
      status: q.status,
      attendance: parseFloat(q.attendance),
      eligibility: q.eligibility,
      rank: parseInt(q.rank),
      components: componentsByQuadrant[q.id] || []
    }));

    // Current term data
    const currentTerm = {
      termId: currentTermId,
      termName: studentTermResult.rows[0]?.term_name || 'Current Term',
      totalScore: studentTermResult.rows[0]?.total_score || student.overall_score || 0,
      grade: studentTermResult.rows[0]?.grade || student.grade || 'IC',
      overallStatus: studentTermResult.rows[0]?.overall_status || 'Progress',
      quadrants: quadrants,
      tests: testResult.rows.map(test => ({
        id: test.test_name.toLowerCase().replace(/[^a-z0-9]/g, ''),
        name: test.test_name,
        scores: [test.obtained_score], // Simplified for now
        total: test.obtained_score,
        maxScore: test.max_score
      }))
    };

    // Get all terms if requested
    let allTerms = [];
    if (includeHistory === 'true') {
      const allTermsQuery = `
        SELECT 
          t.id,
          t.name,
          st.total_score,
          st.grade,
          st.overall_status
        FROM terms t
        LEFT JOIN student_terms st ON st.term_id = t.id AND st.student_id = $1
        ORDER BY t.start_date
      `;
      
      const allTermsResult = await query(allTermsQuery, [studentId]);
      allTerms = allTermsResult.rows.map(term => ({
        termId: term.id,
        termName: term.name,
        totalScore: term.total_score || 0,
        grade: term.grade || 'IC',
        overallStatus: term.overall_status || 'Progress'
      }));
    }

    res.status(200).json({
      success: true,
      data: {
        student: {
          id: student.id,
          name: student.name,
          registrationNo: student.registration_no,
          course: student.course,
          batch: student.batch_name,
          section: student.section_name,
          houseName: student.house_name,
          gender: student.gender,
          currentTerm: student.current_term
        },
        currentTerm: currentTerm,
        allTerms: allTerms
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting student performance:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve student performance data',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get student leaderboard data
const getStudentLeaderboard = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId, quadrantId } = req.query;

    // Get current term if not specified
    let currentTermId = termId;
    if (!currentTermId) {
      const termQuery = `SELECT id FROM terms WHERE is_current = true LIMIT 1`;
      const termResult = await query(termQuery);
      if (termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get student's batch for fair comparison
    const studentBatchQuery = `
      SELECT s.batch_id, s.name as student_name
      FROM students s 
      WHERE s.id = $1
    `;
    const studentBatchResult = await query(studentBatchQuery, [studentId]);
    
    if (studentBatchResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    const batchId = studentBatchResult.rows[0].batch_id;
    const studentName = studentBatchResult.rows[0].student_name;

    // Overall leaderboard
    const overallLeaderboardQuery = `
      WITH student_scores AS (
        SELECT 
          s.id,
          s.name,
          COALESCE(st.total_score, s.overall_score, 0) as total_score,
          DENSE_RANK() OVER (ORDER BY COALESCE(st.total_score, s.overall_score, 0) DESC) as rank
        FROM students s
        LEFT JOIN student_terms st ON st.student_id = s.id AND st.term_id = $1
        WHERE s.batch_id = $2 AND s.status = 'Active'
      )
      SELECT 
        *,
        (SELECT COUNT(*) FROM student_scores) as total_students,
        (SELECT AVG(total_score) FROM student_scores) as batch_avg,
        (SELECT MAX(total_score) FROM student_scores) as batch_best
      FROM student_scores
      ORDER BY rank
      LIMIT 10
    `;

    const overallResult = await query(overallLeaderboardQuery, [currentTermId, batchId]);

    // Get current student's rank
    const studentRankQuery = `
      WITH student_scores AS (
        SELECT 
          s.id,
          COALESCE(st.total_score, s.overall_score, 0) as total_score,
          DENSE_RANK() OVER (ORDER BY COALESCE(st.total_score, s.overall_score, 0) DESC) as rank
        FROM students s
        LEFT JOIN student_terms st ON st.student_id = s.id AND st.term_id = $1
        WHERE s.batch_id = $2 AND s.status = 'Active'
      )
      SELECT rank FROM student_scores WHERE id = $3
    `;

    const studentRankResult = await query(studentRankQuery, [currentTermId, batchId, studentId]);

    // Quadrant-specific leaderboard
    let quadrantLeaderboard = {};
    
    if (quadrantId) {
      const quadrantLeaderboardQuery = `
        WITH quadrant_scores AS (
          SELECT 
            s.id,
            s.name,
            COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) as quadrant_score,
            DENSE_RANK() OVER (ORDER BY COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) DESC) as rank
          FROM students s
          LEFT JOIN scores sc ON sc.student_id = s.id AND sc.term_id = $1
          LEFT JOIN components c ON sc.component_id = c.id
          LEFT JOIN sub_categories subcats ON c.sub_category_id = subcats.id
          WHERE s.batch_id = $2 AND s.status = 'Active' AND subcats.quadrant_id = $3
          GROUP BY s.id, s.name
        )
        SELECT * FROM quadrant_scores
        ORDER BY rank
        LIMIT 10
      `;

      const quadrantResult = await query(quadrantLeaderboardQuery, [currentTermId, batchId, quadrantId]);

      // Get student's quadrant rank
      const studentQuadrantRankQuery = `
        WITH quadrant_scores AS (
          SELECT 
            s.id,
            COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) as quadrant_score,
            DENSE_RANK() OVER (ORDER BY COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) DESC) as rank
          FROM students s
          LEFT JOIN scores sc ON sc.student_id = s.id AND sc.term_id = $1
          LEFT JOIN components c ON sc.component_id = c.id
          LEFT JOIN sub_categories subcats ON c.sub_category_id = subcats.id
          WHERE s.batch_id = $2 AND s.status = 'Active' AND subcats.quadrant_id = $3
          GROUP BY s.id
        )
        SELECT rank FROM quadrant_scores WHERE id = $4
      `;

      const studentQuadrantRankResult = await query(studentQuadrantRankQuery, [currentTermId, batchId, quadrantId, studentId]);

      quadrantLeaderboard = {
        [quadrantId]: {
          topStudents: quadrantResult.rows.map(student => ({
            id: student.id,
            name: student.name,
            score: parseFloat(student.quadrant_score)
          })),
          userRank: studentQuadrantRankResult.rows[0]?.rank || 0
        }
      };
    } else {
      // Get all quadrants leaderboard
      const allQuadrantsQuery = `SELECT id, name FROM quadrants WHERE is_active = true ORDER BY display_order`;
      const allQuadrantsResult = await query(allQuadrantsQuery);

      for (const quadrant of allQuadrantsResult.rows) {
        const qLeaderboardQuery = `
          WITH quadrant_scores AS (
            SELECT 
              s.id,
              s.name,
              COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) as quadrant_score,
              DENSE_RANK() OVER (ORDER BY COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) DESC) as rank
            FROM students s
            LEFT JOIN scores sc ON sc.student_id = s.id AND sc.term_id = $1
            LEFT JOIN components c ON sc.component_id = c.id
            LEFT JOIN sub_categories subcats ON c.sub_category_id = subcats.id
            WHERE s.batch_id = $2 AND s.status = 'Active' AND subcats.quadrant_id = $3
            GROUP BY s.id, s.name
          )
          SELECT * FROM quadrant_scores
          ORDER BY rank
          LIMIT 5
        `;

        const qResult = await query(qLeaderboardQuery, [currentTermId, batchId, quadrant.id]);

        const studentQRankQuery = `
          WITH quadrant_scores AS (
            SELECT 
              s.id,
              DENSE_RANK() OVER (ORDER BY COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) DESC) as rank
            FROM students s
            LEFT JOIN scores sc ON sc.student_id = s.id AND sc.term_id = $1
            LEFT JOIN components c ON sc.component_id = c.id
            LEFT JOIN sub_categories subcats ON c.sub_category_id = subcats.id
            WHERE s.batch_id = $2 AND s.status = 'Active' AND subcats.quadrant_id = $3
            GROUP BY s.id
          )
          SELECT rank FROM quadrant_scores WHERE id = $4
        `;

        const studentQRankResult = await query(studentQRankQuery, [currentTermId, batchId, quadrant.id, studentId]);

        quadrantLeaderboard[quadrant.id] = {
          topStudents: qResult.rows.map(student => ({
            id: student.id,
            name: student.name,
            score: parseFloat(student.quadrant_score)
          })),
          userRank: studentQRankResult.rows[0]?.rank || 0
        };
      }
    }

    const overallData = overallResult.rows[0];

    res.status(200).json({
      success: true,
      data: {
        overall: {
          topStudents: overallResult.rows.map(student => ({
            id: student.id,
            name: student.name,
            score: parseFloat(student.total_score)
          })),
          userRank: studentRankResult.rows[0]?.rank || 0,
          batchAvg: parseFloat(overallData?.batch_avg || 0),
          batchBest: parseFloat(overallData?.batch_best || 0),
          totalStudents: parseInt(overallData?.total_students || 0)
        },
        quadrants: quadrantLeaderboard
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting student leaderboard:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve leaderboard data',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get detailed quadrant information for a student
const getStudentQuadrantDetails = async (req, res) => {
  try {
    const { studentId, quadrantId } = req.params;
    const { termId } = req.query;

    // Get current term if not specified
    let currentTermId = termId;
    if (!currentTermId) {
      const termQuery = `SELECT id FROM terms WHERE is_current = true LIMIT 1`;
      const termResult = await query(termQuery);
      if (termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get student basic info
    const studentQuery = `
      SELECT s.id, s.name, s.registration_no, s.course,
             b.name as batch_name, sec.name as section_name
      FROM students s
      LEFT JOIN batches b ON s.batch_id = b.id
      LEFT JOIN sections sec ON s.section_id = sec.id
      WHERE s.id = $1
    `;

    const studentResult = await query(studentQuery, [studentId]);

    if (studentResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    const student = studentResult.rows[0];

    // Get quadrant details
    const quadrantQuery = `
      SELECT q.id, q.name, q.description, q.weightage, q.minimum_attendance
      FROM quadrants q
      WHERE q.id = $1 AND q.is_active = true
    `;

    const quadrantResult = await query(quadrantQuery, [quadrantId]);

    if (quadrantResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Quadrant not found',
        timestamp: new Date().toISOString()
      });
    }

    const quadrant = quadrantResult.rows[0];

    // Get sub-categories and components with scores
    const componentsQuery = `
      SELECT 
        subcats.id as sub_category_id,
        subcats.name as sub_category_name,
        subcats.weightage as sub_category_weightage,
        c.id as component_id,
        c.name as component_name,
        c.description as component_description,
        c.max_score,
        c.category,
        c.display_order,
        sc.obtained_score,
        sc.percentage,
        sc.assessment_date,
        sc.notes,
        sc.assessed_by,
        u.username as assessed_by_name
      FROM sub_categories subcats
      JOIN components c ON c.sub_category_id = subcats.id
      LEFT JOIN scores sc ON sc.component_id = c.id AND sc.student_id = $1 AND sc.term_id = $2
      LEFT JOIN users u ON sc.assessed_by = u.id
      WHERE subcats.quadrant_id = $3 AND c.is_active = true
      ORDER BY subcats.display_order, c.display_order
    `;

    const componentsResult = await query(componentsQuery, [studentId, currentTermId, quadrantId]);

    // Get attendance for this quadrant
    const attendanceQuery = `
      SELECT 
        total_sessions,
        attended_sessions,
        percentage,
        last_updated
      FROM attendance_summary
      WHERE student_id = $1 AND term_id = $2 AND quadrant_id = $3
    `;

    const attendanceResult = await query(attendanceQuery, [studentId, currentTermId, quadrantId]);

    // Get recent attendance records
    const recentAttendanceQuery = `
      SELECT 
        attendance_date,
        is_present,
        reason
      FROM attendance
      WHERE student_id = $1 AND term_id = $2 AND quadrant_id = $3
      ORDER BY attendance_date DESC
      LIMIT 10
    `;

    const recentAttendanceResult = await query(recentAttendanceQuery, [studentId, currentTermId, quadrantId]);

    // Group components by sub-category
    const subCategories = {};
    componentsResult.rows.forEach(comp => {
      if (!subCategories[comp.sub_category_id]) {
        subCategories[comp.sub_category_id] = {
          id: comp.sub_category_id,
          name: comp.sub_category_name,
          weightage: parseFloat(comp.sub_category_weightage),
          components: []
        };
      }

      subCategories[comp.sub_category_id].components.push({
        id: comp.component_id,
        name: comp.component_name,
        description: comp.component_description,
        maxScore: parseFloat(comp.max_score),
        category: comp.category,
        obtainedScore: comp.obtained_score ? parseFloat(comp.obtained_score) : null,
        percentage: comp.percentage ? parseFloat(comp.percentage) : null,
        assessmentDate: comp.assessment_date,
        notes: comp.notes,
        assessedBy: comp.assessed_by_name,
        status: comp.obtained_score 
          ? (comp.percentage >= 80 ? 'Good' : comp.percentage >= 60 ? 'Progress' : 'Deteriorate')
          : 'Not Assessed'
      });
    });

    // Calculate quadrant totals
    const totalObtained = componentsResult.rows.reduce((sum, comp) => {
      return sum + (comp.obtained_score || 0);
    }, 0);

    const totalMax = componentsResult.rows.reduce((sum, comp) => {
      return sum + comp.max_score;
    }, 0);

    const attendance = attendanceResult.rows[0] || {
      total_sessions: 0,
      attended_sessions: 0,
      percentage: 0,
      last_updated: null
    };

    // Get improvement suggestions (simplified)
    const lowPerformingComponents = componentsResult.rows
      .filter(comp => comp.obtained_score && comp.percentage < 60)
      .map(comp => ({
        component: comp.component_name,
        currentScore: comp.obtained_score,
        maxScore: comp.max_score,
        suggestion: `Focus on improving ${comp.component_name} - current performance is below expectations`
      }));

    res.status(200).json({
      success: true,
      data: {
        student: {
          id: student.id,
          name: student.name,
          registrationNo: student.registration_no,
          course: student.course,
          batch: student.batch_name,
          section: student.section_name
        },
        quadrant: {
          id: quadrant.id,
          name: quadrant.name,
          description: quadrant.description,
          weightage: parseFloat(quadrant.weightage),
          minimumAttendance: parseFloat(quadrant.minimum_attendance),
          totalObtained: totalObtained,
          totalMax: totalMax,
          percentage: totalMax > 0 ? (totalObtained / totalMax) * 100 : 0,
          status: attendance.percentage >= quadrant.minimum_attendance 
            ? (totalMax > 0 && (totalObtained / totalMax) * 100 >= 40 ? 'Cleared' : 'Not Cleared')
            : 'Attendance Shortage'
        },
        subCategories: Object.values(subCategories),
        attendance: {
          totalSessions: attendance.total_sessions,
          attendedSessions: attendance.attended_sessions,
          percentage: parseFloat(attendance.percentage),
          lastUpdated: attendance.last_updated,
          recentRecords: recentAttendanceResult.rows.map(record => ({
            date: record.attendance_date,
            present: record.is_present,
            reason: record.reason
          }))
        },
        improvementSuggestions: lowPerformingComponents,
        eligibility: {
          attendanceEligible: attendance.percentage >= quadrant.minimum_attendance,
          scoreEligible: totalMax > 0 ? (totalObtained / totalMax) * 100 >= 40 : false,
          overallEligible: attendance.percentage >= quadrant.minimum_attendance && 
                          totalMax > 0 && (totalObtained / totalMax) * 100 >= 40
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting quadrant details:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve quadrant details',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Helper function to initialize sample data for testing (development only)
const initializeSampleData = async () => {
  try {
    // Check if components already exist
    const existingComponents = await query('SELECT COUNT(*) FROM components');
    if (parseInt(existingComponents.rows[0].count) > 0) {
      console.log('Sample data already exists, skipping initialization');
      return;
    }

    console.log('Initializing sample data for PEP Score Nexus...');

    // Get current term
    const termResult = await query(`SELECT id FROM terms WHERE is_current = true LIMIT 1`);
    if (termResult.rows.length === 0) {
      console.log('No current term found, skipping sample data initialization');
      return;
    }
    const currentTermId = termResult.rows[0].id;

    // Get quadrants
    const quadrantsResult = await query(`SELECT id FROM quadrants ORDER BY display_order`);
    if (quadrantsResult.rows.length === 0) {
      console.log('No quadrants found, skipping sample data initialization');
      return;
    }

    // Insert sub-categories and components for each quadrant
    for (const quadrant of quadrantsResult.rows) {
      // Get existing sub-categories for this quadrant
      const subCatsResult = await query(
        `SELECT id FROM sub_categories WHERE quadrant_id = $1 ORDER BY display_order`,
        [quadrant.id]
      );

      if (subCatsResult.rows.length > 0) {
        // Insert sample components for existing sub-categories
        for (const subCat of subCatsResult.rows) {
          const sampleComponents = [
            {
              name: `${quadrant.id.toUpperCase()} Component 1`,
              description: `Sample component for ${quadrant.id}`,
              weightage: 50.00,
              max_score: 5.00,
              category: quadrant.id === 'persona' ? 'SHL' : 'Physical',
              display_order: 1
            },
            {
              name: `${quadrant.id.toUpperCase()} Component 2`,
              description: `Another sample component for ${quadrant.id}`,
              weightage: 50.00,
              max_score: 5.00,
              category: quadrant.id === 'persona' ? 'Professional' : 'Physical',
              display_order: 2
            }
          ];

          for (const comp of sampleComponents) {
            await query(
              `INSERT INTO components (sub_category_id, name, description, weightage, max_score, minimum_score, category, display_order, is_active)
               VALUES ($1, $2, $3, $4, $5, 0.00, $6, $7, true)
               ON CONFLICT DO NOTHING`,
              [subCat.id, comp.name, comp.description, comp.weightage, comp.max_score, comp.category, comp.display_order]
            );
          }
        }
      }
    }

    // Insert sample scores for students
    const studentsResult = await query(`SELECT id FROM students WHERE status = 'Active' LIMIT 5`);
    const componentsResult = await query(`SELECT id, max_score FROM components WHERE is_active = true`);

    if (studentsResult.rows.length > 0 && componentsResult.rows.length > 0) {
      for (const student of studentsResult.rows) {
        for (const component of componentsResult.rows) {
          // Generate random score between 60-100% of max score
          const randomPercentage = 60 + Math.random() * 40;
          const obtainedScore = Math.round((randomPercentage / 100) * component.max_score * 100) / 100;

          await query(
            `INSERT INTO scores (student_id, component_id, term_id, obtained_score, max_score, assessment_date, assessed_by, assessment_type, status)
             VALUES ($1, $2, $3, $4, $5, CURRENT_DATE, 
                     (SELECT id FROM users WHERE role = 'admin' LIMIT 1), 
                     'Teacher', 'Submitted')
             ON CONFLICT (student_id, component_id, term_id) DO NOTHING`,
            [student.id, component.id, currentTermId, obtainedScore, component.max_score]
          );
        }

        // Insert attendance summary
        for (const quadrant of quadrantsResult.rows) {
          const attendancePercentage = 75 + Math.random() * 25; // 75-100%
          const totalSessions = 20;
          const attendedSessions = Math.round((attendancePercentage / 100) * totalSessions);

          await query(
            `INSERT INTO attendance_summary (student_id, term_id, quadrant_id, total_sessions, attended_sessions, last_updated)
             VALUES ($1, $2, $3, $4, $5, CURRENT_TIMESTAMP)
             ON CONFLICT (student_id, term_id, quadrant_id) DO UPDATE SET
             total_sessions = EXCLUDED.total_sessions,
             attended_sessions = EXCLUDED.attended_sessions,
             last_updated = EXCLUDED.last_updated`,
            [student.id, currentTermId, quadrant.id, totalSessions, attendedSessions]
          );
        }

        // Calculate and update student term data
        const totalScoreResult = await query(
          `SELECT 
             COALESCE(SUM(sc.obtained_score * c.weightage / 100 * sc_sub.weightage / 100 * q.weightage / 100), 0) as total_score
           FROM scores sc
           JOIN components c ON sc.component_id = c.id
           JOIN sub_categories sc_sub ON c.sub_category_id = sc_sub.id
           JOIN quadrants q ON sc_sub.quadrant_id = q.id
           WHERE sc.student_id = $1 AND sc.term_id = $2`,
          [student.id, currentTermId]
        );

        const totalScore = Math.round(totalScoreResult.rows[0].total_score || 0);
        const grade = totalScore >= 90 ? 'A+' : totalScore >= 80 ? 'A' : totalScore >= 70 ? 'B' : totalScore >= 60 ? 'C' : totalScore >= 50 ? 'D' : totalScore >= 40 ? 'E' : 'IC';

        await query(
          `INSERT INTO student_terms (student_id, term_id, enrollment_status, total_score, grade, overall_status, is_eligible)
           VALUES ($1, $2, 'Enrolled', $3, $4, 'Good', true)
           ON CONFLICT (student_id, term_id) DO UPDATE SET
           total_score = EXCLUDED.total_score,
           grade = EXCLUDED.grade,
           overall_status = EXCLUDED.overall_status`,
          [student.id, currentTermId, totalScore, grade]
        );

        // Update student overall score
        await query(
          `UPDATE students SET overall_score = $1, grade = $2 WHERE id = $3`,
          [totalScore, grade, student.id]
        );
      }
    }

    console.log('✅ Sample data initialization completed successfully');
  } catch (error) {
    console.error('❌ Error initializing sample data:', error);
  }
};

// Submit student feedback
const submitFeedback = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { subject, category, message, priority = 'medium' } = req.body;

    // Validate input
    if (!subject || !category || !message) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: subject, category, message',
        timestamp: new Date().toISOString()
      });
    }

    // Get teacher for this student (if available)
    const teacherQuery = `
      SELECT t.id 
      FROM teachers t
      JOIN teacher_assignments ta ON t.id = ta.teacher_id
      WHERE ta.student_id = $1 AND ta.is_active = true
      LIMIT 1
    `;
    const teacherResult = await query(teacherQuery, [studentId]);

    // Insert feedback
    const feedbackResult = await query(
      `INSERT INTO feedback (student_id, teacher_id, subject, category, message, priority, status, submitted_at)
       VALUES ($1, $2, $3, $4, $5, $6::priority_type, 'Submitted', CURRENT_TIMESTAMP)
       RETURNING id, submitted_at`,
      [studentId, teacherResult.rows[0]?.id || null, subject, category, message, priority.charAt(0).toUpperCase() + priority.slice(1)]
    );

    res.status(201).json({
      success: true,
      data: {
        feedbackId: feedbackResult.rows[0].id,
        submittedAt: feedbackResult.rows[0].submitted_at,
        status: 'submitted'
      },
      message: 'Feedback submitted successfully',
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error submitting feedback:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to submit feedback',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get student feedback history
const getFeedbackHistory = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { page = 1, limit = 10, status } = req.query;
    const offset = (page - 1) * limit;

    let feedbackQuery = `
      SELECT 
        f.id,
        f.subject,
        f.category,
        f.message,
        f.priority,
        f.status,
        f.response,
        f.submitted_at,
        f.resolved_at,
        u.username as resolved_by_name
      FROM feedback f
      LEFT JOIN users u ON f.resolved_by = u.id
      WHERE f.student_id = $1
    `;

    const params = [studentId];
    
    if (status) {
      feedbackQuery += ` AND f.status = $${params.length + 1}`;
      params.push(status);
    }

    feedbackQuery += ` ORDER BY f.submitted_at DESC LIMIT $${params.length + 1} OFFSET $${params.length + 2}`;
    params.push(limit, offset);

    const feedbackResult = await query(feedbackQuery, params);

    // Get total count
    let countQuery = `SELECT COUNT(*) FROM feedback WHERE student_id = $1`;
    const countParams = [studentId];
    if (status) {
      countQuery += ` AND status = $2`;
      countParams.push(status);
    }
    const countResult = await query(countQuery, countParams);
    const totalItems = parseInt(countResult.rows[0].count);
    const totalPages = Math.ceil(totalItems / limit);

    res.status(200).json({
      success: true,
      data: {
        feedbacks: feedbackResult.rows.map(feedback => ({
          id: feedback.id,
          subject: feedback.subject,
          category: feedback.category,
          message: feedback.message,
          priority: feedback.priority,
          status: feedback.status,
          submittedAt: feedback.submitted_at,
          resolvedAt: feedback.resolved_at,
          response: feedback.response,
          resolvedBy: feedback.resolved_by_name
        })),
        pagination: {
          currentPage: parseInt(page),
          totalPages,
          totalItems,
          itemsPerPage: parseInt(limit)
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting feedback history:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve feedback history',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get student profile
const getStudentProfile = async (req, res) => {
  try {
    const { studentId } = req.params;

    const profileQuery = `
      SELECT 
        s.id,
        s.name,
        s.registration_no,
        s.course,
        s.phone,
        s.gender,
        s.preferences,
        u.email,
        u.username,
        b.name as batch_name,
        sec.name as section_name,
        h.name as house_name
      FROM students s
      JOIN users u ON s.user_id = u.id
      LEFT JOIN batches b ON s.batch_id = b.id
      LEFT JOIN sections sec ON s.section_id = sec.id
      LEFT JOIN houses h ON s.house_id = h.id
      WHERE s.id = $1
    `;

    const profileResult = await query(profileQuery, [studentId]);

    if (profileResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    const student = profileResult.rows[0];
    const preferences = student.preferences || {};

    res.status(200).json({
      success: true,
      data: {
        student: {
          id: student.id,
          name: student.name,
          email: student.email,
          phone: student.phone,
          registrationNo: student.registration_no,
          course: student.course,
          batch: student.batch_name,
          section: student.section_name,
          houseName: student.house_name,
          gender: student.gender
        },
        preferences: {
          notifyScores: preferences.notifyScores !== false,
          notifyUpdates: preferences.notifyUpdates !== false,
          darkMode: preferences.darkMode === true,
          language: preferences.language || 'en'
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting student profile:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve student profile',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Update student profile
const updateStudentProfile = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { email, phone, preferences = {} } = req.body;

    // Start transaction
    await transaction(async (client) => {
      // Update user email if provided
      if (email) {
        await client.query(
          `UPDATE users SET email = $1 WHERE id = (SELECT user_id FROM students WHERE id = $2)`,
          [email, studentId]
        );
      }

      // Update student phone and preferences
      const updateFields = [];
      const updateParams = [];
      let paramCount = 1;

      if (phone) {
        updateFields.push(`phone = $${paramCount}`);
        updateParams.push(phone);
        paramCount++;
      }

      if (Object.keys(preferences).length > 0) {
        // Get current preferences and merge
        const currentPrefsResult = await client.query(
          `SELECT preferences FROM students WHERE id = $1`,
          [studentId]
        );
        const currentPrefs = currentPrefsResult.rows[0]?.preferences || {};
        const mergedPrefs = { ...currentPrefs, ...preferences };

        updateFields.push(`preferences = $${paramCount}`);
        updateParams.push(JSON.stringify(mergedPrefs));
        paramCount++;
      }

      if (updateFields.length > 0) {
        updateParams.push(studentId);
        await client.query(
          `UPDATE students SET ${updateFields.join(', ')}, updated_at = CURRENT_TIMESTAMP WHERE id = $${paramCount}`,
          updateParams
        );
      }
    });

    res.status(200).json({
      success: true,
      message: 'Profile updated successfully',
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error updating student profile:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update profile',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Change password
const changePassword = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { currentPassword, newPassword, confirmPassword } = req.body;

    // Validate input
    if (!currentPassword || !newPassword || !confirmPassword) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields',
        timestamp: new Date().toISOString()
      });
    }

    if (newPassword !== confirmPassword) {
      return res.status(400).json({
        success: false,
        message: 'New password and confirmation do not match',
        timestamp: new Date().toISOString()
      });
    }

    // Get current password hash
    const userResult = await query(
      `SELECT u.id, u.password_hash 
       FROM users u 
       JOIN students s ON u.id = s.user_id 
       WHERE s.id = $1`,
      [studentId]
    );

    if (userResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    const user = userResult.rows[0];

    // Verify current password
    const bcrypt = require('bcryptjs');
    const isValidPassword = await bcrypt.compare(currentPassword, user.password_hash);
    
    if (!isValidPassword) {
      return res.status(401).json({
        success: false,
        message: 'Current password is incorrect',
        timestamp: new Date().toISOString()
      });
    }

    // Hash new password
    const saltRounds = 12;
    const hashedNewPassword = await bcrypt.hash(newPassword, saltRounds);

    // Update password
    await query(
      `UPDATE users SET password_hash = $1 WHERE id = $2`,
      [hashedNewPassword, user.id]
    );

    res.status(200).json({
      success: true,
      message: 'Password changed successfully',
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error changing password:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to change password',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get eligibility rules
const getEligibilityRules = async (req, res) => {
  try {
    const quadrantsQuery = `
      SELECT 
        q.id,
        q.name,
        q.description,
        q.minimum_attendance,
        q.business_rules
      FROM quadrants q
      WHERE q.is_active = true
      ORDER BY q.display_order
    `;

    const quadrantsResult = await query(quadrantsQuery);

    const rules = quadrantsResult.rows.map(quadrant => ({
      quadrant: quadrant.name,
      attendanceRequired: `${quadrant.minimum_attendance}%`,
      otherRequirements: quadrant.description,
      gradingCriteria: {
        'A+': '90-100%',
        'A': '80-89%',
        'B': '70-79%',
        'C': '60-69%',
        'D': '50-59%',
        'E': '40-49%',
        'IC': 'Below 40%'
      }
    }));

    res.status(200).json({
      success: true,
      data: {
        rules,
        generalRules: {
          minimumAttendance: '80%',
          eligibilityThreshold: '40%',
          passingGrade: 'D'
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting eligibility rules:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve eligibility rules',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Check student eligibility
const checkStudentEligibility = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId } = req.query;

    // Get current term if not specified
    let currentTermId = termId;
    if (!currentTermId) {
      const termQuery = `SELECT id FROM terms WHERE is_current = true LIMIT 1`;
      const termResult = await query(termQuery);
      if (termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get quadrant eligibility
    const eligibilityQuery = `
      SELECT 
        q.id,
        q.name,
        q.minimum_attendance,
        COALESCE(att.percentage, 0) as attendance,
        COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) / q.weightage * 100 as score_percentage,
        CASE 
          WHEN COALESCE(att.percentage, 0) >= q.minimum_attendance 
               AND COALESCE(SUM(sc.obtained_score * c.weightage / 100), 0) / q.weightage * 100 >= 40 
          THEN true 
          ELSE false 
        END as eligible
      FROM quadrants q
      LEFT JOIN sub_categories subcats ON subcats.quadrant_id = q.id
      LEFT JOIN components c ON c.sub_category_id = subcats.id
      LEFT JOIN scores sc ON sc.component_id = c.id AND sc.student_id = $1 AND sc.term_id = $2
      LEFT JOIN attendance_summary att ON att.student_id = $1 AND att.term_id = $2 AND att.quadrant_id = q.id
      WHERE q.is_active = true
      GROUP BY q.id, q.name, q.minimum_attendance, att.percentage
      ORDER BY q.display_order
    `;

    const eligibilityResult = await query(eligibilityQuery, [studentId, currentTermId]);

    const quadrants = eligibilityResult.rows.map(q => ({
      id: q.id,
      name: q.name,
      eligible: q.eligible,
      status: q.eligible ? 'Eligible' : 'Not Eligible',
      attendance: parseFloat(q.attendance),
      attendanceRequired: parseFloat(q.minimum_attendance),
      reason: q.eligible ? null : 
        (q.attendance < q.minimum_attendance ? 'Attendance below requirement' : 'Score below threshold')
    }));

    // Overall eligibility
    const overallEligible = quadrants.every(q => q.eligible);

    const recommendations = quadrants
      .filter(q => !q.eligible)
      .map(q => `Improve ${q.name}: ${q.reason}`)
      .slice(0, 3); // Top 3 recommendations

    res.status(200).json({
      success: true,
      data: {
        overall: {
          eligible: overallEligible,
          status: overallEligible ? 'Eligible' : 'Not Eligible',
          reason: overallEligible ? null : 'Some quadrants do not meet requirements'
        },
        quadrants,
        recommendations
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error checking student eligibility:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to check eligibility',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get improvement plan
const getImprovementPlan = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId, quadrantId } = req.query;

    // Get current term if not specified
    let currentTermId = termId;
    if (!currentTermId) {
      const termQuery = `SELECT id FROM terms WHERE is_current = true LIMIT 1`;
      const termResult = await query(termQuery);
      if (termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get components with low scores
    let improvementQuery = `
      SELECT 
        q.id as quadrant_id,
        q.name as quadrant_name,
        c.id as component_id,
        c.name as component_name,
        c.max_score,
        sc.obtained_score,
        sc.percentage,
        CASE 
          WHEN sc.percentage < 60 THEN 'high'
          WHEN sc.percentage < 75 THEN 'medium'
          ELSE 'low'
        END as priority
      FROM components c
      JOIN sub_categories subcats ON c.sub_category_id = subcats.id
      JOIN quadrants q ON subcats.quadrant_id = q.id
      LEFT JOIN scores sc ON sc.component_id = c.id AND sc.student_id = $1 AND sc.term_id = $2
      WHERE q.is_active = true AND c.is_active = true 
        AND (sc.percentage < 75 OR sc.percentage IS NULL)
    `;

    const params = [studentId, currentTermId];

    if (quadrantId) {
      improvementQuery += ` AND q.id = $3`;
      params.push(quadrantId);
    }

    improvementQuery += ` ORDER BY sc.percentage ASC NULLS LAST, priority DESC`;

    const improvementResult = await query(improvementQuery, params);

    const improvementAreas = improvementResult.rows.map(comp => ({
      quadrantId: comp.quadrant_id,
      quadrantName: comp.quadrant_name,
      componentId: comp.component_id,
      componentName: comp.component_name,
      score: comp.obtained_score || 0,
      maxScore: comp.max_score,
      status: comp.obtained_score ? 
        (comp.percentage >= 75 ? 'Good' : comp.percentage >= 60 ? 'Progress' : 'Deteriorate') : 
        'Not Assessed',
      priority: comp.priority,
      recommendations: {
        shortTerm: [
          `Focus on improving ${comp.component_name}`,
          'Practice regularly with available resources'
        ],
        longTerm: [
          `Develop comprehensive ${comp.component_name} skills`,
          'Seek additional guidance from teachers'
        ],
        resources: [
          'Study materials from library',
          'Online practice resources',
          'Peer study groups'
        ]
      }
    }));

    // Get existing goals count
    const goalsQuery = `
      SELECT COUNT(*) as goals_set,
             COUNT(CASE WHEN completed_at IS NOT NULL THEN 1 END) as goals_achieved
      FROM student_improvement_goals 
      WHERE student_id = $1 AND term_id = $2
    `;

    const goalsResult = await query(goalsQuery, [studentId, currentTermId]);
    const goalsData = goalsResult.rows[0] || { goals_set: 0, goals_achieved: 0 };

    const overallRecommendations = [
      'Focus on components with low scores first',
      'Create specific improvement goals',
      'Regular practice and assessment'
    ];

    res.status(200).json({
      success: true,
      data: {
        improvementAreas,
        overallRecommendations,
        progressTracking: {
          goalsSet: parseInt(goalsData.goals_set),
          goalsAchieved: parseInt(goalsData.goals_achieved),
          nextReviewDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0] // 30 days from now
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting improvement plan:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve improvement plan',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Set improvement goals
const setImprovementGoals = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { goals } = req.body;

    if (!goals || !Array.isArray(goals) || goals.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Goals array is required',
        timestamp: new Date().toISOString()
      });
    }

    // Get current term
    const termQuery = `SELECT id FROM terms WHERE is_current = true LIMIT 1`;
    const termResult = await query(termQuery);
    if (termResult.rows.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'No current term found',
        timestamp: new Date().toISOString()
      });
    }
    const currentTermId = termResult.rows[0].id;

    let goalsCreated = 0;

    // Create improvement goals table if it doesn't exist
    await query(`
      CREATE TABLE IF NOT EXISTS student_improvement_goals (
        id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
        student_id UUID NOT NULL REFERENCES students(id) ON DELETE CASCADE,
        term_id UUID NOT NULL REFERENCES terms(id) ON DELETE CASCADE,
        component_id UUID NOT NULL REFERENCES components(id) ON DELETE CASCADE,
        target_score DECIMAL(5,2) NOT NULL,
        target_date DATE NOT NULL,
        actions JSONB DEFAULT '[]',
        created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
        completed_at TIMESTAMP,
        UNIQUE(student_id, term_id, component_id)
      )
    `);

    for (const goal of goals) {
      try {
        await query(
          `INSERT INTO student_improvement_goals (student_id, term_id, component_id, target_score, target_date, actions)
           VALUES ($1, $2, $3, $4, $5, $6)
           ON CONFLICT (student_id, term_id, component_id) 
           DO UPDATE SET target_score = EXCLUDED.target_score, target_date = EXCLUDED.target_date, actions = EXCLUDED.actions`,
          [studentId, currentTermId, goal.componentId, goal.targetScore, goal.targetDate, JSON.stringify(goal.actions || [])]
        );
        goalsCreated++;
      } catch (error) {
        console.error('Error creating individual goal:', error);
      }
    }

    res.status(201).json({
      success: true,
      data: {
        goalsCreated,
        nextReviewDate: new Date(Date.now() + 30 * 24 * 60 * 60 * 1000).toISOString().split('T')[0]
      },
      message: 'Improvement goals set successfully',
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error setting improvement goals:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to set improvement goals',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get student attendance
const getStudentAttendance = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId, quadrant } = req.query;

    // Get current term if not specified
    let currentTermId = termId;
    if (!currentTermId) {
      const termQuery = `SELECT id FROM terms WHERE is_current = true LIMIT 1`;
      const termResult = await query(termQuery);
      if (termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get attendance summary
    let attendanceQuery = `
      SELECT 
        q.id,
        q.name,
        q.minimum_attendance as required,
        COALESCE(att.total_sessions, 0) as total_sessions,
        COALESCE(att.attended_sessions, 0) as attended_sessions,
        COALESCE(att.percentage, 0) as percentage,
        CASE 
          WHEN COALESCE(att.percentage, 0) >= q.minimum_attendance THEN 'Eligible'
          ELSE 'Not Eligible'
        END as eligibility
      FROM quadrants q
      LEFT JOIN attendance_summary att ON att.student_id = $1 AND att.term_id = $2 AND att.quadrant_id = q.id
      WHERE q.is_active = true
    `;

    const params = [studentId, currentTermId];

    if (quadrant) {
      attendanceQuery += ` AND q.id = $3`;
      params.push(quadrant);
    }

    attendanceQuery += ` ORDER BY q.display_order`;

    const attendanceResult = await query(attendanceQuery, params);

    // Calculate overall attendance
    const totalSessions = attendanceResult.rows.reduce((sum, q) => sum + q.total_sessions, 0);
    const totalAttended = attendanceResult.rows.reduce((sum, q) => sum + q.attended_sessions, 0);
    const overallPercentage = totalSessions > 0 ? (totalAttended / totalSessions) * 100 : 0;

    // Get attendance history by term
    const historyQuery = `
      SELECT 
        t.name as term,
        COALESCE(AVG(att.percentage), 0) as overall
      FROM terms t
      LEFT JOIN attendance_summary att ON att.term_id = t.id AND att.student_id = $1
      WHERE t.start_date <= CURRENT_DATE
      GROUP BY t.id, t.name, t.start_date
      ORDER BY t.start_date
    `;

    const historyResult = await query(historyQuery, [studentId]);

    res.status(200).json({
      success: true,
      data: {
        overall: {
          attendance: Math.round(overallPercentage),
          eligibility: overallPercentage >= 80 ? 'Eligible' : 'Not Eligible',
          required: 80
        },
        quadrants: attendanceResult.rows.map(q => ({
          id: q.id,
          name: q.name,
          attendance: Math.round(q.percentage),
          eligibility: q.eligibility,
          required: Math.round(q.required),
          totalSessions: q.total_sessions,
          attendedSessions: q.attended_sessions
        })),
        history: historyResult.rows.map(h => ({
          term: h.term,
          overall: Math.round(h.overall)
        }))
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting student attendance:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve attendance data',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get score breakdown
const getScoreBreakdown = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId, quadrantId, includeHistory } = req.query;

    // Get current term if not specified
    let currentTermId = termId;
    if (!currentTermId) {
      const termQuery = `SELECT id FROM terms WHERE is_current = true LIMIT 1`;
      const termResult = await query(termQuery);
      if (termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get student basic info
    const studentQuery = `
      SELECT s.id, s.name, s.registration_no
      FROM students s
      WHERE s.id = $1
    `;
    const studentResult = await query(studentQuery, [studentId]);

    if (studentResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    // Get detailed score breakdown
    let breakdownQuery = `
      SELECT 
        q.id as quadrant_id,
        q.name as quadrant_name,
        q.weightage as quadrant_weightage,
        subcats.id as sub_category_id,
        subcats.name as sub_category_name,
        subcats.weightage as sub_category_weightage,
        c.id as component_id,
        c.name as component_name,
        c.max_score,
        c.weightage as component_weightage,
        sc.obtained_score,
        sc.percentage,
        att.percentage as attendance_percentage,
        q.minimum_attendance
      FROM quadrants q
      JOIN sub_categories subcats ON q.id = subcats.quadrant_id
      JOIN components c ON c.sub_category_id = subcats.id
      LEFT JOIN scores sc ON sc.component_id = c.id AND sc.student_id = $1 AND sc.term_id = $2
      LEFT JOIN attendance_summary att ON att.student_id = $1 AND att.term_id = $2 AND att.quadrant_id = q.id
      WHERE q.is_active = true AND c.is_active = true
    `;

    const params = [studentId, currentTermId];

    if (quadrantId) {
      breakdownQuery += ` AND q.id = $3`;
      params.push(quadrantId);
    }

    breakdownQuery += ` ORDER BY q.display_order, subcats.display_order, c.display_order`;

    const breakdownResult = await query(breakdownQuery, params);

    // Process the results into nested structure
    const scoreBreakdown = {};
    let overallTotal = 0;
    let overallMax = 0;

    breakdownResult.rows.forEach(row => {
      const quadrantId = row.quadrant_id;
      
      if (!scoreBreakdown[quadrantId]) {
        scoreBreakdown[quadrantId] = {
          totalScore: 0,
          maxScore: parseFloat(row.quadrant_weightage),
          percentage: 0,
          weightage: parseFloat(row.quadrant_weightage),
          contribution: 0,
          subCategories: [],
          eligibility: {
            status: 'Not Eligible',
            attendance: parseFloat(row.attendance_percentage || 0),
            minimumAttendance: parseFloat(row.minimum_attendance || 80),
            attendanceEligible: false
          }
        };
      }

      let subCategory = scoreBreakdown[quadrantId].subCategories.find(sc => sc.id === row.sub_category_id);
      if (!subCategory) {
        subCategory = {
          id: row.sub_category_id,
          name: row.sub_category_name,
          score: 0,
          maxScore: 0,
          percentage: 0,
          weightage: parseFloat(row.sub_category_weightage),
          components: []
        };
        scoreBreakdown[quadrantId].subCategories.push(subCategory);
      }

      const componentScore = row.obtained_score || 0;
      const componentMax = parseFloat(row.max_score);
      const componentPercentage = componentMax > 0 ? (componentScore / componentMax) * 100 : 0;

      subCategory.components.push({
        id: row.component_id,
        name: row.component_name,
        score: componentScore,
        maxScore: componentMax,
        percentage: componentPercentage,
        weightage: parseFloat(row.component_weightage),
        status: componentPercentage >= 80 ? 'Good' : componentPercentage >= 60 ? 'Progress' : 'Deteriorate'
      });

      // Update subcategory totals
      subCategory.score += componentScore * (parseFloat(row.component_weightage) / 100);
      subCategory.maxScore += componentMax * (parseFloat(row.component_weightage) / 100);
    });

    // Calculate percentages and totals
    Object.keys(scoreBreakdown).forEach(quadrantId => {
      const quadrant = scoreBreakdown[quadrantId];
      
      quadrant.subCategories.forEach(subCategory => {
        subCategory.percentage = subCategory.maxScore > 0 ? (subCategory.score / subCategory.maxScore) * 100 : 0;
        quadrant.totalScore += subCategory.score * (subCategory.weightage / 100);
      });

      quadrant.percentage = quadrant.maxScore > 0 ? (quadrant.totalScore / quadrant.maxScore) * 100 : 0;
      quadrant.contribution = quadrant.totalScore;
      
      // Update eligibility
      quadrant.eligibility.attendanceEligible = quadrant.eligibility.attendance >= quadrant.eligibility.minimumAttendance;
      quadrant.eligibility.status = quadrant.eligibility.attendanceEligible && quadrant.percentage >= 40 ? 'Eligible' : 'Not Eligible';

      overallTotal += quadrant.contribution;
      overallMax += quadrant.maxScore;
    });

    const overallPercentage = overallMax > 0 ? (overallTotal / overallMax) * 100 : 0;
    const grade = overallPercentage >= 90 ? 'A+' : overallPercentage >= 80 ? 'A' : overallPercentage >= 70 ? 'B' : overallPercentage >= 60 ? 'C' : overallPercentage >= 50 ? 'D' : overallPercentage >= 40 ? 'E' : 'IC';

    res.status(200).json({
      success: true,
      data: {
        student: studentResult.rows[0],
        termId: currentTermId,
        scoreBreakdown,
        overallSummary: {
          totalScore: Math.round(overallTotal * 100) / 100,
          maxScore: overallMax,
          grade,
          status: overallPercentage >= 80 ? 'Good' : overallPercentage >= 60 ? 'Progress' : 'Deteriorate',
          eligibility: Object.values(scoreBreakdown).every(q => q.eligibility.status === 'Eligible') ? 'Eligible' : 'Not Eligible'
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting score breakdown:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve score breakdown',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get behavior rating scale
const getBehaviorRatingScale = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId } = req.query;

    // Get current term if not specified
    let currentTermId = termId;
    if (!currentTermId) {
      const termQuery = `SELECT id FROM terms WHERE is_current = true LIMIT 1`;
      const termResult = await query(termQuery);
      if (termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get behavior and discipline components with scores
    const behaviorQuery = `
      SELECT 
        c.id,
        c.name,
        c.description,
        c.max_score,
        sc.obtained_score,
        sc.percentage,
        sc.assessment_date,
        sc.notes,
        q.name as quadrant_name
      FROM components c
      JOIN sub_categories subcats ON c.sub_category_id = subcats.id
      JOIN quadrants q ON subcats.quadrant_id = q.id
      LEFT JOIN scores sc ON sc.component_id = c.id AND sc.student_id = $1 AND sc.term_id = $2
      WHERE q.id IN ('behavior', 'discipline') AND c.is_active = true
      ORDER BY q.display_order, c.display_order
    `;

    const behaviorResult = await query(behaviorQuery, [studentId, currentTermId]);

    const ratingScale = {
      5: { label: 'Excellent', description: 'Consistently exceeds expectations' },
      4: { label: 'Good', description: 'Usually meets or exceeds expectations' },
      3: { label: 'Satisfactory', description: 'Generally meets expectations' },
      2: { label: 'Needs Improvement', description: 'Sometimes meets expectations' },
      1: { label: 'Unsatisfactory', description: 'Rarely meets expectations' }
    };

    const behaviorComponents = behaviorResult.rows.map(comp => ({
      id: comp.id,
      name: comp.name,
      description: comp.description,
      quadrant: comp.quadrant_name,
      currentRating: comp.obtained_score || null,
      maxRating: comp.max_score,
      percentage: comp.percentage || null,
      lastAssessed: comp.assessment_date,
      notes: comp.notes,
      ratingDescription: comp.obtained_score ? ratingScale[Math.round(comp.obtained_score)]?.label : null
    }));

    res.status(200).json({
      success: true,
      data: {
        ratingScale,
        components: behaviorComponents,
        overallBehaviorScore: {
          average: behaviorComponents.length > 0 ? 
            Math.round((behaviorComponents.reduce((sum, comp) => sum + (comp.currentRating || 0), 0) / behaviorComponents.length) * 100) / 100 : 0,
          status: 'In Progress'
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting behavior rating scale:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve behavior rating scale',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get student interventions
const getStudentInterventions = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { status, quadrant } = req.query;

    // Get student interventions
    let interventionQuery = `
      SELECT 
        i.id,
        i.name,
        i.description,
        i.start_date,
        i.end_date,
        i.status,
        ie.enrollment_date,
        ie.completion_percentage as progress_percentage,
        ie.current_score,
        ie.current_score as max_score,
        ie.enrollment_date as last_activity,
        COUNT(t.id) as total_tasks,
        COUNT(CASE WHEN ts.submitted_at IS NOT NULL THEN 1 END) as completed_tasks
      FROM interventions i
      JOIN intervention_enrollments ie ON i.id = ie.intervention_id
      LEFT JOIN tasks t ON i.id = t.intervention_id
      LEFT JOIN task_submissions ts ON t.id = ts.task_id AND ts.student_id = $1
      WHERE ie.student_id = $1
    `;

    const params = [studentId];

    if (status) {
      interventionQuery += ` AND i.status = $${params.length + 1}`;
      params.push(status);
    }

    if (quadrant) {
      interventionQuery += ` AND EXISTS (
        SELECT 1 FROM intervention_quadrants iq 
        WHERE iq.intervention_id = i.id AND iq.quadrant_id = $${params.length + 1}
      )`;
      params.push(quadrant);
    }

    interventionQuery += ` GROUP BY i.id, ie.enrollment_date, ie.completion_percentage, ie.current_score ORDER BY ie.enrollment_date DESC`;

    const interventionResult = await query(interventionQuery, params);

    // Get quadrant details for each intervention
    const interventions = [];
    for (const intervention of interventionResult.rows) {
      const quadrantsQuery = `
        SELECT 
          q.id,
          q.name,
          iq.weightage,
          COALESCE(sc.obtained_score, 0) as current_score,
          iq.weightage as max_score
        FROM intervention_quadrants iq
        JOIN quadrants q ON iq.quadrant_id = q.id
        LEFT JOIN scores sc ON sc.student_id = $1 AND sc.quadrant_id = q.id
        WHERE iq.intervention_id = $2
      `;

      const quadrantsResult = await query(quadrantsQuery, [studentId, intervention.id]);

      interventions.push({
        id: intervention.id,
        name: intervention.name,
        description: intervention.description,
        startDate: intervention.start_date,
        endDate: intervention.end_date,
        status: intervention.status,
        enrollmentDate: intervention.enrollment_date,
        progress: {
          completedTasks: parseInt(intervention.completed_tasks),
          totalTasks: parseInt(intervention.total_tasks),
          completionPercentage: Math.round((intervention.completed_tasks / intervention.total_tasks) * 100) || 0,
          currentScore: parseFloat(intervention.current_score || 0),
          lastActivity: intervention.last_activity
        },
        quadrants: quadrantsResult.rows.map(q => ({
          quadrantId: q.id,
          quadrantName: q.name,
          weightage: parseFloat(q.weightage),
          currentScore: parseFloat(q.current_score),
          maxScore: parseFloat(q.max_score)
        }))
      });
    }

    // Calculate summary
    const totalInterventions = interventions.length;
    const activeInterventions = interventions.filter(i => i.status === 'active').length;
    const completedInterventions = interventions.filter(i => i.status === 'completed').length;
    const overallProgress = interventions.length > 0 ? 
      interventions.reduce((sum, i) => sum + i.progress.completionPercentage, 0) / interventions.length : 0;

    res.status(200).json({
      success: true,
      data: {
        interventions,
        summary: {
          totalInterventions,
          activeInterventions,
          completedInterventions,
          overallProgress: Math.round(overallProgress),
          averageScore: interventions.length > 0 ? 
            Math.round(interventions.reduce((sum, i) => sum + i.progress.currentScore, 0) / interventions.length) : 0,
          pendingTasks: interventions.reduce((sum, i) => sum + (i.progress.totalTasks - i.progress.completedTasks), 0)
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting student interventions:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve student interventions',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get specific intervention details for student
const getStudentInterventionDetails = async (req, res) => {
  try {
    const { studentId, interventionId } = req.params;

    // Get intervention details
    const interventionQuery = `
      SELECT 
        i.id,
        i.name,
        i.description,
        i.start_date,
        i.end_date,
        i.status,
        i.objectives,
        ie.enrollment_date,
        ie.completion_percentage as progress_percentage,
        ie.current_score,
        ie.current_score as max_score
      FROM interventions i
      JOIN intervention_enrollments ie ON i.id = ie.intervention_id
      WHERE i.id = $1 AND ie.student_id = $2
    `;

    const interventionResult = await query(interventionQuery, [interventionId, studentId]);

    if (interventionResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Intervention not found or student not enrolled',
        timestamp: new Date().toISOString()
      });
    }

    const intervention = interventionResult.rows[0];

    // Get quadrant breakdown
    const quadrantsQuery = `
      SELECT 
        q.id,
        q.name,
        iq.weightage,
        COALESCE(sc.obtained_score, 0) as current_score,
        iq.weightage as max_score
      FROM intervention_quadrants iq
      JOIN quadrants q ON iq.quadrant_id = q.id
      LEFT JOIN scores sc ON sc.student_id = $1
      WHERE iq.intervention_id = $2
    `;

    const quadrantsResult = await query(quadrantsQuery, [studentId, interventionId]);

    // Get task count
    const taskCountQuery = `
      SELECT 
        COUNT(*) as total_tasks,
        COUNT(CASE WHEN ts.submitted_at IS NOT NULL THEN 1 END) as completed_tasks
      FROM tasks t
      LEFT JOIN task_submissions ts ON t.id = ts.task_id AND ts.student_id = $1
      WHERE t.intervention_id = $2
    `;

    const taskCountResult = await query(taskCountQuery, [studentId, interventionId]);
    const taskData = taskCountResult.rows[0];

    // Get teachers
    const teachersQuery = `
      SELECT DISTINCT
        t.id,
        t.name,
        t.specialization
      FROM teachers t
      JOIN intervention_teachers it ON t.id = it.teacher_id
      WHERE it.intervention_id = $1
    `;

    const teachersResult = await query(teachersQuery, [interventionId]);

    // Get leaderboard
    const leaderboardQuery = `
      SELECT 
        s.id,
        s.name,
        ie.current_score
      FROM intervention_enrollments ie
      JOIN students s ON ie.student_id = s.id
      WHERE ie.intervention_id = $1
      ORDER BY ie.current_score DESC
      LIMIT 5
    `;

    const leaderboardResult = await query(leaderboardQuery, [interventionId]);

    // Find user rank
    const userRank = leaderboardResult.rows.findIndex(s => s.id === studentId) + 1;

    res.status(200).json({
      success: true,
      data: {
        intervention: {
          id: intervention.id,
          name: intervention.name,
          description: intervention.description,
          startDate: intervention.start_date,
          endDate: intervention.end_date,
          status: intervention.status,
          objectives: intervention.objectives || [],
          enrollmentDate: intervention.enrollment_date
        },
        progress: {
          completedTasks: parseInt(taskData.completed_tasks),
          totalTasks: parseInt(taskData.total_tasks),
          completionPercentage: Math.round((taskData.completed_tasks / taskData.total_tasks) * 100) || 0,
          currentScore: parseFloat(intervention.current_score || 0),
          maxScore: parseFloat(intervention.max_score || 100),
          rank: userRank || 0,
          totalStudents: leaderboardResult.rows.length
        },
        quadrantBreakdown: quadrantsResult.rows.map(q => ({
          quadrantId: q.id,
          quadrantName: q.name,
          weightage: parseFloat(q.weightage),
          currentScore: parseFloat(q.current_score),
          maxScore: parseFloat(q.max_score)
        })),
        teachers: teachersResult.rows.map(t => ({
          teacherId: t.id,
          teacherName: t.name,
          specialization: t.specialization
        })),
        leaderboard: {
          topStudents: leaderboardResult.rows.map(s => ({
            studentId: s.id,
            studentName: s.name,
            score: parseFloat(s.current_score)
          })),
          userRank: userRank || 0,
          batchAverage: leaderboardResult.rows.length > 0 ? 
            Math.round(leaderboardResult.rows.reduce((sum, s) => sum + parseFloat(s.current_score), 0) / leaderboardResult.rows.length) : 0
        }
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting intervention details:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve intervention details',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get intervention tasks for student
const getStudentInterventionTasks = async (req, res) => {
  try {
    const { studentId, interventionId } = req.params;
    const { status, quadrant } = req.query;

    let tasksQuery = `
      SELECT 
        t.id,
        t.name,
        t.description,
        t.max_score,
        t.due_date,
        t.instructions,
        t.attachments,
        c.name as component_name,
        q.id as quadrant_id,
        q.name as quadrant_name,
        ts.id as submission_id,
        ts.submitted_at,
        ts.score,
        ts.feedback,
        ts.graded_at,
        ts.attachments as submission_files,
        CASE 
          WHEN ts.submitted_at IS NOT NULL AND ts.graded_at IS NOT NULL THEN 'graded'
          WHEN ts.submitted_at IS NOT NULL THEN 'submitted'
          WHEN t.due_date < CURRENT_TIMESTAMP THEN 'overdue'
          ELSE 'pending'
        END as task_status
      FROM tasks t
      LEFT JOIN components c ON t.component_id = c.id
      LEFT JOIN sub_categories subcats ON c.sub_category_id = subcats.id
      LEFT JOIN quadrants q ON t.quadrant_id = q.id
      LEFT JOIN task_submissions ts ON t.id = ts.task_id AND ts.student_id = $1
      WHERE t.intervention_id = $2
    `;

    const params = [studentId, interventionId];

    if (status) {
      tasksQuery += ` AND CASE 
        WHEN ts.submitted_at IS NOT NULL AND ts.graded_at IS NOT NULL THEN 'graded'
        WHEN ts.submitted_at IS NOT NULL THEN 'submitted'
        WHEN t.due_date < CURRENT_TIMESTAMP THEN 'overdue'
        ELSE 'pending'
      END = $${params.length + 1}`;
      params.push(status);
    }

    if (quadrant) {
      tasksQuery += ` AND q.id = $${params.length + 1}`;
      params.push(quadrant);
    }

    tasksQuery += ` ORDER BY t.due_date ASC`;

    const tasksResult = await query(tasksQuery, params);

    const tasks = tasksResult.rows.map(task => {
      const taskData = {
        taskId: task.id,
        taskName: task.name,
        description: task.description,
        quadrant: task.quadrant_name,
        component: task.component_name,
        maxScore: parseFloat(task.max_score),
        dueDate: task.due_date,
        status: task.task_status,
        instructions: task.instructions,
        attachments: task.attachments || []
      };

      if (task.task_status === 'pending' || task.task_status === 'overdue') {
        const dueDate = new Date(task.due_date);
        const today = new Date();
        const daysRemaining = Math.ceil((dueDate - today) / (1000 * 60 * 60 * 24));
        taskData.daysRemaining = daysRemaining;
      }

      if (task.submission_id) {
        taskData.submission = {
          submissionId: task.submission_id,
          submittedAt: task.submitted_at,
          score: parseFloat(task.score || 0),
          feedback: task.feedback,
          gradedAt: task.graded_at,
          files: task.submission_files || []
        };
      }

      return taskData;
    });

    res.status(200).json({
      success: true,
      data: {
        tasks
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting intervention tasks:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve intervention tasks',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Submit intervention task
const submitInterventionTask = async (req, res) => {
  try {
    const { studentId, interventionId, taskId } = req.params;
    const { notes } = req.body;

    // Check if task exists and is part of the intervention
    const taskQuery = `
      SELECT t.id, t.name, t.due_date, t.max_score
      FROM tasks t
      WHERE t.id = $1 AND t.intervention_id = $2
    `;

    const taskResult = await query(taskQuery, [taskId, interventionId]);

    if (taskResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Task not found in this intervention',
        timestamp: new Date().toISOString()
      });
    }

    const task = taskResult.rows[0];
    const isLate = new Date() > new Date(task.due_date);

    // Check if already submitted
    const existingSubmissionQuery = `
      SELECT id FROM task_submissions 
      WHERE task_id = $1 AND student_id = $2
    `;

    const existingResult = await query(existingSubmissionQuery, [taskId, studentId]);

    if (existingResult.rows.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Task already submitted',
        timestamp: new Date().toISOString()
      });
    }

    // Create task submission
    const submissionResult = await query(
      `INSERT INTO task_submissions (task_id, student_id, submitted_at, submission_text, is_late)
       VALUES ($1, $2, CURRENT_TIMESTAMP, $3, $4)
       RETURNING id, submitted_at`,
      [taskId, studentId, notes || '', isLate]
    );

    res.status(201).json({
      success: true,
      data: {
        submissionId: submissionResult.rows[0].id,
        taskId: taskId,
        submittedAt: submissionResult.rows[0].submitted_at,
        status: 'submitted',
        isLate: isLate,
        files: [] // Would handle file uploads in real implementation
      },
      message: 'Task submitted successfully',
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error submitting task:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to submit task',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get intervention impact on quadrant scores
const getInterventionQuadrantImpact = async (req, res) => {
  try {
    const { studentId } = req.params;
    const { termId, quadrant } = req.query;

    // Get current term if not specified
    let currentTermId = termId;
    if (!currentTermId) {
      const termQuery = `SELECT id FROM terms WHERE is_current = true LIMIT 1`;
      const termResult = await query(termQuery);
      if (termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    let impactQuery = `
      SELECT 
        q.id as quadrant_id,
        q.name as quadrant_name,
        q.weightage as max_score,
        COALESCE(SUM(sc.obtained_score), 0) as base_score,
        COALESCE(SUM(i_scores.intervention_score), 0) as intervention_contribution,
        COALESCE(SUM(sc.obtained_score), 0) + COALESCE(SUM(i_scores.intervention_score), 0) as total_score
      FROM quadrants q
      LEFT JOIN sub_categories subcats ON q.id = subcats.quadrant_id
      LEFT JOIN components c ON subcats.id = c.sub_category_id
      LEFT JOIN scores sc ON c.id = sc.component_id AND sc.student_id = $1 AND sc.term_id = $2
      LEFT JOIN (
        SELECT 
          iq.quadrant_id,
          SUM(ie.current_score * (iq.weightage / 100)) as intervention_score
        FROM intervention_enrollments ie
        JOIN intervention_quadrants iq ON ie.intervention_id = iq.intervention_id
        WHERE ie.student_id = $1
        GROUP BY iq.quadrant_id
      ) i_scores ON q.id = i_scores.quadrant_id
      WHERE q.is_active = true
    `;

    const params = [studentId, currentTermId];
    
    if (quadrant) {
      impactQuery += ` AND q.id = $3`;
      params.push(quadrant);
    }

    impactQuery += ` GROUP BY q.id, q.name, q.weightage ORDER BY q.display_order`;

    const impactResult = await query(impactQuery, params);

    const quadrantScores = [];

    for (const quadrantData of impactResult.rows) {
      // Get interventions for this quadrant
      const interventionsQuery = `
        SELECT 
          i.id,
          i.name,
          ie.current_score * (iq.weightage / 100) as contribution
        FROM interventions i
        JOIN intervention_enrollments ie ON i.id = ie.intervention_id
        JOIN intervention_quadrants iq ON i.id = iq.intervention_id
        WHERE ie.student_id = $1 AND iq.quadrant_id = $2
      `;

      const interventionsResult = await query(interventionsQuery, [studentId, quadrantData.quadrant_id]);

      quadrantScores.push({
        quadrantId: quadrantData.quadrant_id,
        quadrantName: quadrantData.quadrant_name,
        baseScore: parseFloat(quadrantData.base_score),
        interventionContribution: parseFloat(quadrantData.intervention_contribution),
        totalScore: parseFloat(quadrantData.total_score),
        maxScore: parseFloat(quadrantData.max_score),
        interventions: interventionsResult.rows.map(int => ({
          interventionId: int.id,
          interventionName: int.name,
          contribution: parseFloat(int.contribution)
        }))
      });
    }

    res.status(200).json({
      success: true,
      data: {
        quadrantScores
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error getting intervention quadrant impact:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve intervention impact',
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
  createStudentForExistingUser,
  getStudentPerformance,
  getStudentLeaderboard,
  getStudentQuadrantDetails,
  initializeSampleData,
  submitFeedback,
  getFeedbackHistory,
  getStudentProfile,
  updateStudentProfile,
  changePassword,
  getEligibilityRules,
  checkStudentEligibility,
  getImprovementPlan,
  setImprovementGoals,
  getStudentAttendance,
  getScoreBreakdown,
  getBehaviorRatingScale,
  getStudentInterventions,
  getStudentInterventionDetails,
  getStudentInterventionTasks,
  submitInterventionTask,
  getInterventionQuadrantImpact
};
