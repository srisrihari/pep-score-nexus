const { supabase, query } = require('../config/supabase');

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

    // Get student with related data using Supabase
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
          houses:house_id(name, color),
          users:user_id(username, email)
        `)
        .eq('id', id)
        .limit(1)
    );

    if (!studentResult.rows || studentResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    const student = studentResult.rows[0];

    // Get student's scores with component details
    const scoresResult = await query(
      supabase
        .from('scores')
        .select(`
          obtained_score,
          max_score,
          percentage,
          assessment_date,
          notes,
          components:component_id(
            name,
            category,
            sub_categories:sub_category_id(
              name,
              quadrants:quadrant_id(
                id,
                name,
                weightage,
                display_order
              )
            )
          )
        `)
        .eq('student_id', id)
        .order('assessment_date', { ascending: false })
    );

    // Get attendance summary
    const attendanceResult = await query(
      supabase
        .from('attendance_summary')
        .select(`
          total_sessions,
          attended_sessions,
          percentage,
          last_updated,
          quadrants:quadrant_id(
            id,
            name,
            display_order
          )
        `)
        .eq('student_id', id)
        .order('quadrants.display_order', { ascending: true })
    );

    // Transform student data
    const transformedStudent = {
      ...student,
      batch_name: student.batches?.name || null,
      batch_year: student.batches?.year || null,
      section_name: student.sections?.name || null,
      house_name: student.houses?.name || null,
      house_color: student.houses?.color || null,
      username: student.users?.username || null,
      email: student.users?.email || null
    };

    res.status(200).json({
      success: true,
      message: 'Student details retrieved successfully',
      data: {
        ...transformedStudent,
        scores: scoresResult.rows || [],
        attendance: attendanceResult.rows || []
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

    // Hash password
    const bcrypt = require('bcryptjs');
    const saltRounds = 12;
    const hashedPassword = await bcrypt.hash(password, saltRounds);

    // Create user first
    const userResult = await query(
      supabase
        .from('users')
        .insert({
          username,
          email,
          password_hash: hashedPassword,
          role: 'student',
          status: 'active'
        })
        .select('id')
    );

    if (!userResult.rows || userResult.rows.length === 0) {
      throw new Error('Failed to create user');
    }

    const userId = userResult.rows[0].id;

    // Create student record
    const studentResult = await query(
      supabase
        .from('students')
        .insert({
          user_id: userId,
          registration_no,
          name,
          course,
          batch_id,
          section_id,
          house_id,
          gender,
          phone,
          status: 'Active',
          current_term: 'Term1'
        })
        .select('*')
    );

    if (!studentResult.rows || studentResult.rows.length === 0) {
      // Rollback user creation if student creation fails
      await query(
        supabase
          .from('users')
          .delete()
          .eq('id', userId)
      );
      throw new Error('Failed to create student record');
    }

    const result = studentResult.rows[0];

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
      const newBatchResult = await query(
        supabase
          .from('batches')
          .insert({
            name: 'Batch 2024',
            year: 2024,
            start_date: '2024-01-01',
            end_date: '2024-12-31',
            is_active: true
          })
          .select('id')
      );

      if (!newBatchResult.rows || newBatchResult.rows.length === 0) {
        throw new Error('Failed to create batch');
      }
      batchId = newBatchResult.rows[0].id;
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
      const newSectionResult = await query(
        supabase
          .from('sections')
          .insert({
            name: 'Section A',
            batch_id: batchId,
            capacity: 50,
            is_active: true
          })
          .select('id')
      );

      if (!newSectionResult.rows || newSectionResult.rows.length === 0) {
        throw new Error('Failed to create section');
      }
      sectionId = newSectionResult.rows[0].id;
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
      const newHouseResult = await query(
        supabase
          .from('houses')
          .insert({
            name: 'Red House',
            description: 'Red house for students',
            color: '#EF4444',
            is_active: true
          })
          .select('id')
      );

      if (!newHouseResult.rows || newHouseResult.rows.length === 0) {
        throw new Error('Failed to create house');
      }
      houseId = newHouseResult.rows[0].id;
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

    const studentResult = await query(
      supabase
        .from('students')
        .upsert(studentData, { onConflict: 'user_id' })
        .select('*')
    );

    if (!studentResult.rows || studentResult.rows.length === 0) {
      throw new Error('Failed to create student record');
    }

    res.status(201).json({
      success: true,
      message: 'Student record created successfully for existing user',
      data: studentResult.rows[0],
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

    // Get student basic info using Supabase
    const studentResult = await query(
      supabase
        .from('students')
        .select(`
          id,
          registration_no,
          name,
          course,
          gender,
          current_term,
          overall_score,
          grade,
          batches:batch_id(name, year),
          sections:section_id(name),
          houses:house_id(name, color)
        `)
        .eq('id', studentId)
        .limit(1)
    );

    if (!studentResult.rows || studentResult.rows.length === 0) {
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
      const termResult = await query(
        supabase
          .from('terms')
          .select('id, name')
          .eq('is_current', true)
          .limit(1)
      );
      if (termResult.rows && termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get student term data
    const studentTermResult = await query(
      supabase
        .from('student_terms')
        .select(`
          total_score,
          grade,
          overall_status,
          rank,
          is_eligible,
          terms:term_id(name)
        `)
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
        .limit(1)
    );

    // Get quadrant performance with attendance using Supabase
    const quadrantResult = await query(
      supabase
        .from('quadrants')
        .select(`
          id,
          name,
          weightage,
          minimum_attendance,
          display_order
        `)
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    // Get attendance summary for each quadrant
    const attendanceResult = await query(
      supabase
        .from('attendance_summary')
        .select(`
          quadrant_id,
          total_sessions,
          attended_sessions,
          percentage
        `)
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
    );

    // Create attendance lookup
    const attendanceMap = {};
    if (attendanceResult.rows) {
      attendanceResult.rows.forEach(att => {
        attendanceMap[att.quadrant_id] = att;
      });
    }

    // Get components with scores for each quadrant
    const componentsResult = await query(
      supabase
        .from('components')
        .select(`
          id,
          name,
          category,
          max_score,
          display_order,
          sub_categories:sub_category_id(
            quadrant_id,
            display_order
          )
        `)
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    // Get scores for this student and term
    const scoresResult = await query(
      supabase
        .from('scores')
        .select(`
          component_id,
          obtained_score,
          assessment_date,
          notes
        `)
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
    );

    // Create scores lookup
    const scoresMap = {};
    if (scoresResult.rows) {
      scoresResult.rows.forEach(score => {
        scoresMap[score.component_id] = score;
      });
    }

    // Group components by quadrant and add scores
    const componentsByQuadrant = {};
    if (componentsResult.rows) {
      componentsResult.rows.forEach(comp => {
        const quadrantId = comp.sub_categories?.quadrant_id;
        if (!quadrantId) return;

        if (!componentsByQuadrant[quadrantId]) {
          componentsByQuadrant[quadrantId] = [];
        }

        const score = scoresMap[comp.id];
        const obtainedScore = score?.obtained_score || 0;

        // Calculate status based on score
        let status = 'Deteriorate';
        if (obtainedScore >= comp.max_score * 0.8) status = 'Good';
        else if (obtainedScore >= comp.max_score * 0.6) status = 'Progress';

        componentsByQuadrant[quadrantId].push({
          id: comp.id,
          name: comp.name,
          score: obtainedScore,
          maxScore: comp.max_score,
          category: comp.category,
          status: status
        });
      });
    }

    // Get test scores (SHL components)
    const testScores = [];
    if (componentsResult.rows) {
      componentsResult.rows
        .filter(comp => comp.category === 'SHL')
        .forEach(comp => {
          const score = scoresMap[comp.id];
          if (score) {
            testScores.push({
              id: comp.name.toLowerCase().replace(/[^a-z0-9]/g, ''),
              name: comp.name,
              scores: [score.obtained_score],
              total: score.obtained_score,
              maxScore: comp.max_score
            });
          }
        });
    }

    // Format quadrant data according to API documentation
    const quadrants = [];
    if (quadrantResult.rows) {
      quadrantResult.rows.forEach(q => {
        const attendance = attendanceMap[q.id];
        const attendancePercentage = attendance?.percentage || 0;

        // Calculate obtained score from components
        const components = componentsByQuadrant[q.id] || [];
        const totalObtained = components.reduce((sum, comp) => sum + comp.score, 0);

        // Determine status and eligibility
        const isAttendanceEligible = attendancePercentage >= (q.minimum_attendance || 80);
        const status = isAttendanceEligible && totalObtained >= (q.weightage * 0.4) ? 'Cleared' : 'Not Cleared';
        const eligibility = isAttendanceEligible ? 'Eligible' : 'Not Eligible';

        quadrants.push({
          id: q.id,
          name: q.name,
          weightage: parseFloat(q.weightage),
          obtained: totalObtained,
          status: status,
          attendance: attendancePercentage,
          eligibility: eligibility,
          rank: 1, // Simplified for now
          components: components
        });
      });
    }

    // Current term data formatted according to API documentation
    const currentTerm = {
      termId: currentTermId,
      termName: studentTermResult.rows?.[0]?.terms?.name || 'Current Term',
      totalScore: studentTermResult.rows?.[0]?.total_score || student.overall_score || 0,
      grade: studentTermResult.rows?.[0]?.grade || student.grade || 'IC',
      overallStatus: studentTermResult.rows?.[0]?.overall_status || 'Progress',
      quadrants: quadrants,
      tests: testScores
    };

    // Get all terms if requested
    let allTerms = [];
    if (includeHistory === 'true') {
      const allTermsResult = await query(
        supabase
          .from('terms')
          .select(`
            id,
            name,
            student_terms:student_terms(
              total_score,
              grade,
              overall_status
            )
          `)
          .order('start_date', { ascending: true })
      );

      if (allTermsResult.rows) {
        allTerms = allTermsResult.rows.map(term => {
          const studentTerm = term.student_terms?.[0];
          return {
            termId: term.id,
            termName: term.name,
            totalScore: studentTerm?.total_score || 0,
            grade: studentTerm?.grade || 'IC',
            overallStatus: studentTerm?.overall_status || 'Progress'
          };
        });
      }
    }

    // Format response according to API documentation
    res.status(200).json({
      success: true,
      data: {
        student: {
          id: student.id,
          name: student.name,
          registrationNo: student.registration_no,
          course: student.course,
          batch: student.batches?.name || null,
          section: student.sections?.name || null,
          houseName: student.houses?.name || null,
          gender: student.gender,
          currentTerm: student.current_term
        },
        currentTerm: currentTerm,
        allTerms: allTerms
      }
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
      const termResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );
      if (termResult.rows && termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get student's batch for fair comparison
    const studentBatchResult = await query(
      supabase
        .from('students')
        .select('batch_id, name')
        .eq('id', studentId)
        .limit(1)
    );

    if (!studentBatchResult.rows || studentBatchResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    const batchId = studentBatchResult.rows[0].batch_id;
    const studentName = studentBatchResult.rows[0].name;

    // Get all students in the same batch with their scores
    const batchStudentsResult = await query(
      supabase
        .from('students')
        .select(`
          id,
          name,
          overall_score
        `)
        .eq('batch_id', batchId)
        .eq('status', 'Active')
    );

    // Get student term scores separately if needed
    let termScores = {};
    if (currentTermId) {
      const termScoresResult = await query(
        supabase
          .from('student_terms')
          .select('student_id, total_score')
          .eq('term_id', currentTermId)
      );

      if (termScoresResult.rows) {
        termScoresResult.rows.forEach(ts => {
          termScores[ts.student_id] = ts.total_score;
        });
      }
    }

    // Process and rank students
    let studentScores = [];
    if (batchStudentsResult.rows) {
      studentScores = batchStudentsResult.rows.map(student => {
        const totalScore = termScores[student.id] || student.overall_score || 0;
        return {
          id: student.id,
          name: student.name,
          total_score: totalScore
        };
      });

      // Sort by score descending and add ranks
      studentScores.sort((a, b) => b.total_score - a.total_score);
      studentScores = studentScores.map((student, index) => ({
        ...student,
        rank: index + 1
      }));
    }

    // Calculate batch statistics
    const totalStudents = studentScores.length;
    const batchAvg = totalStudents > 0 ? studentScores.reduce((sum, s) => sum + s.total_score, 0) / totalStudents : 0;
    const batchBest = totalStudents > 0 ? studentScores[0].total_score : 0;

    // Get top 10 students
    const topStudents = studentScores.slice(0, 10);

    // Get current student's rank from the processed data
    const currentStudentRank = studentScores.find(s => s.id === studentId)?.rank || 0;

    // Quadrant-specific leaderboard (simplified for Supabase)
    let quadrantLeaderboard = {};

    if (quadrantId) {
      // For now, create a simplified quadrant leaderboard
      // In a full implementation, this would require more complex queries
      // or a separate microservice for analytics

      quadrantLeaderboard = {
        [quadrantId]: {
          topStudents: topStudents.slice(0, 5).map(student => ({
            id: student.id,
            name: student.name,
            score: Math.floor(student.total_score * 0.7) // Simplified quadrant score
          })),
          userRank: Math.min(currentStudentRank + 1, totalStudents),
          batchAvg: Math.floor(batchAvg * 0.7),
          batchBest: Math.floor(batchBest * 0.7)
        }
      };
    } else {
      // Get all quadrants leaderboard (simplified)
      const allQuadrantsResult = await query(
        supabase
          .from('quadrants')
          .select('id, name')
          .eq('is_active', true)
          .order('display_order', { ascending: true })
      );

      if (allQuadrantsResult.rows) {
        for (const quadrant of allQuadrantsResult.rows) {
          // Simplified quadrant leaderboard using overall scores as approximation
          const quadrantMultiplier = {
            'persona': 0.5,    // 50% weightage
            'wellness': 0.3,   // 30% weightage
            'behavior': 0.1,   // 10% weightage
            'discipline': 0.1  // 10% weightage
          };

          const multiplier = quadrantMultiplier[quadrant.id] || 0.25;

          quadrantLeaderboard[quadrant.id] = {
            topStudents: topStudents.slice(0, 5).map(student => ({
              id: student.id,
              name: student.name,
              score: Math.floor(student.total_score * multiplier)
            })),
            userRank: currentStudentRank,
            batchAvg: Math.floor(batchAvg * multiplier),
            batchBest: Math.floor(batchBest * multiplier)
          };
        }
      }
    }

    res.status(200).json({
      success: true,
      data: {
        overall: {
          topStudents: topStudents.map(student => ({
            id: student.id,
            name: student.name,
            score: parseFloat(student.total_score)
          })),
          userRank: currentStudentRank,
          batchAvg: parseFloat(batchAvg),
          batchBest: parseFloat(batchBest),
          totalStudents: totalStudents
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
      const termResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );
      if (termResult.rows && termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get student basic info
    const studentResult = await query(
      supabase
        .from('students')
        .select(`
          id,
          name,
          registration_no,
          course,
          batches:batch_id(name),
          sections:section_id(name)
        `)
        .eq('id', studentId)
        .limit(1)
    );

    if (!studentResult.rows || studentResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    const student = studentResult.rows[0];

    // Get quadrant details
    const quadrantResult = await query(
      supabase
        .from('quadrants')
        .select('id, name, description, weightage, minimum_attendance')
        .eq('id', quadrantId)
        .eq('is_active', true)
        .limit(1)
    );

    if (!quadrantResult.rows || quadrantResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Quadrant not found',
        timestamp: new Date().toISOString()
      });
    }

    const quadrant = quadrantResult.rows[0];

    // Get sub-categories for this quadrant
    const subCategoriesResult = await query(
      supabase
        .from('sub_categories')
        .select('id, name, weightage, display_order')
        .eq('quadrant_id', quadrantId)
        .order('display_order', { ascending: true })
    );

    // Get components for these sub-categories
    const componentsResult = await query(
      supabase
        .from('components')
        .select(`
          id,
          name,
          description,
          max_score,
          category,
          display_order,
          sub_category_id
        `)
        .in('sub_category_id', subCategoriesResult.rows?.map(sc => sc.id) || [])
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    // Get scores for these components
    const scoresResult = await query(
      supabase
        .from('scores')
        .select(`
          component_id,
          obtained_score,
          percentage,
          assessment_date,
          notes,
          assessed_by,
          users:assessed_by(username)
        `)
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
        .in('component_id', componentsResult.rows?.map(c => c.id) || [])
    );

    // Create lookup maps
    const subCategoriesMap = {};
    if (subCategoriesResult.rows) {
      subCategoriesResult.rows.forEach(sc => {
        subCategoriesMap[sc.id] = sc;
      });
    }

    const scoresMap = {};
    if (scoresResult.rows) {
      scoresResult.rows.forEach(score => {
        scoresMap[score.component_id] = score;
      });
    }

    // Get attendance for this quadrant
    const attendanceResult = await query(
      supabase
        .from('attendance_summary')
        .select('total_sessions, attended_sessions, percentage, last_updated')
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
        .eq('quadrant_id', quadrantId)
        .limit(1)
    );

    // Get recent attendance records
    const recentAttendanceResult = await query(
      supabase
        .from('attendance')
        .select('attendance_date, is_present, reason')
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
        .eq('quadrant_id', quadrantId)
        .order('attendance_date', { ascending: false })
        .limit(10)
    );

    // Group components by sub-category
    const subCategories = {};

    if (componentsResult.rows) {
      componentsResult.rows.forEach(comp => {
        const subCat = subCategoriesMap[comp.sub_category_id];
        const score = scoresMap[comp.id];

        if (!subCategories[comp.sub_category_id]) {
          subCategories[comp.sub_category_id] = {
            id: comp.sub_category_id,
            name: subCat?.name || 'Unknown',
            weightage: parseFloat(subCat?.weightage || 0),
            components: []
          };
        }

        const obtainedScore = score?.obtained_score || null;
        const percentage = score?.percentage || (obtainedScore && comp.max_score ? (obtainedScore / comp.max_score) * 100 : null);

        subCategories[comp.sub_category_id].components.push({
          id: comp.id,
          name: comp.name,
          description: comp.description,
          maxScore: parseFloat(comp.max_score),
          category: comp.category,
          obtainedScore: obtainedScore ? parseFloat(obtainedScore) : null,
          percentage: percentage ? parseFloat(percentage) : null,
          assessmentDate: score?.assessment_date || null,
          notes: score?.notes || null,
          assessedBy: score?.users?.username || null,
          status: obtainedScore
            ? (percentage >= 80 ? 'Good' : percentage >= 60 ? 'Progress' : 'Deteriorate')
            : 'Not Assessed'
        });
      });
    }

    // Calculate quadrant totals
    let totalObtained = 0;
    let totalMax = 0;

    if (componentsResult.rows) {
      componentsResult.rows.forEach(comp => {
        const score = scoresMap[comp.id];
        totalObtained += score?.obtained_score || 0;
        totalMax += comp.max_score;
      });
    }

    const attendance = attendanceResult.rows?.[0] || {
      total_sessions: 0,
      attended_sessions: 0,
      percentage: 0,
      last_updated: null
    };

    // Get improvement suggestions (simplified)
    const lowPerformingComponents = [];
    if (componentsResult.rows) {
      componentsResult.rows.forEach(comp => {
        const score = scoresMap[comp.id];
        const percentage = score?.percentage || (score?.obtained_score && comp.max_score ? (score.obtained_score / comp.max_score) * 100 : 0);

        if (score?.obtained_score && percentage < 60) {
          lowPerformingComponents.push({
            component: comp.name,
            currentScore: score.obtained_score,
            maxScore: comp.max_score,
            suggestion: `Focus on improving ${comp.name} - current performance is below expectations`
          });
        }
      });
    }

    res.status(200).json({
      success: true,
      data: {
        student: {
          id: student.id,
          name: student.name,
          registrationNo: student.registration_no,
          course: student.course,
          batch: student.batches?.name || null,
          section: student.sections?.name || null
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
          recentRecords: recentAttendanceResult.rows?.map(record => ({
            date: record.attendance_date,
            present: record.is_present,
            reason: record.reason
          })) || []
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
    console.log('🔄 Initializing sample data using Supabase REST API...');

    // Check if sample data already exists
    const existingComponentsResult = await query(
      supabase
        .from('components')
        .select('id', { count: 'exact', head: true })
    );

    if (existingComponentsResult.count > 0) {
      console.log('✅ Sample data already exists, skipping initialization');
      return;
    }

    // Get current term
    const termResult = await query(
      supabase
        .from('terms')
        .select('id')
        .eq('is_current', true)
        .limit(1)
    );

    if (!termResult.rows || termResult.rows.length === 0) {
      console.log('⚠️  No current term found, skipping sample data initialization');
      return;
    }

    const currentTermId = termResult.rows[0].id;

    // Get quadrants
    const quadrantsResult = await query(
      supabase
        .from('quadrants')
        .select('id, name')
        .order('display_order', { ascending: true })
    );

    if (!quadrantsResult.rows || quadrantsResult.rows.length === 0) {
      console.log('⚠️  No quadrants found, skipping sample data initialization');
      return;
    }

    console.log(`📊 Found ${quadrantsResult.rows.length} quadrants, creating sample components...`);

    // Create sample components for each quadrant
    for (const quadrant of quadrantsResult.rows) {
      // Get existing sub-categories for this quadrant
      const subCatsResult = await query(
        supabase
          .from('sub_categories')
          .select('id, name')
          .eq('quadrant_id', quadrant.id)
          .order('display_order', { ascending: true })
      );

      if (subCatsResult.rows && subCatsResult.rows.length > 0) {
        console.log(`  📝 Creating components for quadrant: ${quadrant.name}`);

        // Insert sample components for existing sub-categories
        for (const subCat of subCatsResult.rows) {
          const sampleComponents = [
            {
              sub_category_id: subCat.id,
              name: `${quadrant.name} Assessment 1`,
              description: `Sample assessment for ${quadrant.name}`,
              weightage: 50.00,
              max_score: 5.00,
              minimum_score: 0.00,
              category: quadrant.id === 'persona' ? 'SHL' : 'Physical',
              display_order: 1,
              is_active: true
            },
            {
              sub_category_id: subCat.id,
              name: `${quadrant.name} Assessment 2`,
              description: `Another sample assessment for ${quadrant.name}`,
              weightage: 50.00,
              max_score: 5.00,
              minimum_score: 0.00,
              category: quadrant.id === 'persona' ? 'Professional' : 'Physical',
              display_order: 2,
              is_active: true
            }
          ];

          // Insert components using upsert to avoid conflicts
          for (const comp of sampleComponents) {
            try {
              await query(
                supabase
                  .from('components')
                  .upsert(comp, { onConflict: 'sub_category_id,name' })
              );
            } catch (error) {
              console.log(`    ⚠️  Component already exists: ${comp.name}`);
            }
          }
        }
      }
    }

    // Create sample scores for active students
    const studentsResult = await query(
      supabase
        .from('students')
        .select('id, name')
        .eq('status', 'Active')
        .limit(5)
    );

    const componentsResult = await query(
      supabase
        .from('components')
        .select('id, max_score')
        .eq('is_active', true)
    );

    if (studentsResult.rows && studentsResult.rows.length > 0 &&
        componentsResult.rows && componentsResult.rows.length > 0) {

      console.log(`👥 Creating sample scores for ${studentsResult.rows.length} students...`);

      // Get an admin user for assessed_by
      const adminResult = await query(
        supabase
          .from('users')
          .select('id')
          .eq('role', 'admin')
          .limit(1)
      );

      const adminId = adminResult.rows?.[0]?.id;

      for (const student of studentsResult.rows) {
        for (const component of componentsResult.rows) {
          // Generate random score between 60-100% of max score
          const randomPercentage = 60 + Math.random() * 40;
          const obtainedScore = Math.round((randomPercentage / 100) * component.max_score * 100) / 100;

          try {
            await query(
              supabase
                .from('scores')
                .upsert({
                  student_id: student.id,
                  component_id: component.id,
                  term_id: currentTermId,
                  obtained_score: obtainedScore,
                  max_score: component.max_score,
                  assessment_date: new Date().toISOString().split('T')[0],
                  assessed_by: adminId,
                  assessment_type: 'Teacher',
                  status: 'Submitted'
                }, { onConflict: 'student_id,component_id,term_id' })
            );
          } catch (error) {
            // Score already exists, skip
          }
        }

        // Create attendance summary for each quadrant
        for (const quadrant of quadrantsResult.rows) {
          const attendancePercentage = 75 + Math.random() * 25; // 75-100%
          const totalSessions = 20;
          const attendedSessions = Math.round((attendancePercentage / 100) * totalSessions);

          try {
            await query(
              supabase
                .from('attendance_summary')
                .upsert({
                  student_id: student.id,
                  term_id: currentTermId,
                  quadrant_id: quadrant.id,
                  total_sessions: totalSessions,
                  attended_sessions: attendedSessions,
                  last_updated: new Date().toISOString()
                }, { onConflict: 'student_id,term_id,quadrant_id' })
            );
          } catch (error) {
            // Attendance already exists, skip
          }
        }

        // Calculate simple total score (simplified calculation)
        const studentScoresResult = await query(
          supabase
            .from('scores')
            .select('obtained_score')
            .eq('student_id', student.id)
            .eq('term_id', currentTermId)
        );

        let totalScore = 0;
        if (studentScoresResult.rows) {
          totalScore = studentScoresResult.rows.reduce((sum, score) => sum + (score.obtained_score || 0), 0);
          totalScore = Math.round(totalScore);
        }

        const grade = totalScore >= 90 ? 'A+' : totalScore >= 80 ? 'A' : totalScore >= 70 ? 'B' :
                     totalScore >= 60 ? 'C' : totalScore >= 50 ? 'D' : totalScore >= 40 ? 'E' : 'IC';

        // Update student term data
        try {
          await query(
            supabase
              .from('student_terms')
              .upsert({
                student_id: student.id,
                term_id: currentTermId,
                enrollment_status: 'Enrolled',
                total_score: totalScore,
                grade: grade,
                overall_status: 'Good',
                is_eligible: true
              }, { onConflict: 'student_id,term_id' })
          );
        } catch (error) {
          // Student term already exists, skip
        }

        // Update student overall score
        await query(
          supabase
            .from('students')
            .update({
              overall_score: totalScore,
              grade: grade
            })
            .eq('id', student.id)
        );
      }
    }

    console.log('✅ Sample data initialization completed successfully!');
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
    const teacherResult = await query(
      supabase
        .from('teacher_assignments')
        .select(`
          teachers:teacher_id(id)
        `)
        .eq('student_id', studentId)
        .eq('is_active', true)
        .limit(1)
    );

    const teacherId = teacherResult.rows?.[0]?.teachers?.id || null;

    // Insert feedback
    const feedbackResult = await query(
      supabase
        .from('feedback')
        .insert({
          student_id: studentId,
          teacher_id: teacherId,
          subject: subject,
          category: category,
          message: message,
          priority: priority.charAt(0).toUpperCase() + priority.slice(1),
          status: 'Submitted',
          submitted_at: new Date().toISOString()
        })
        .select('id, submitted_at')
    );

    if (!feedbackResult.rows || feedbackResult.rows.length === 0) {
      throw new Error('Failed to submit feedback');
    }

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

    // Build the query with filters
    let feedbackQuery = supabase
      .from('feedback')
      .select(`
        id,
        subject,
        category,
        message,
        priority,
        status,
        response,
        submitted_at,
        resolved_at,
        users:resolved_by(username)
      `)
      .eq('student_id', studentId);

    // Add status filter if provided
    if (status) {
      feedbackQuery = feedbackQuery.eq('status', status);
    }

    // Add pagination and ordering
    feedbackQuery = feedbackQuery
      .order('submitted_at', { ascending: false })
      .range(offset, offset + limit - 1);

    const feedbackResult = await query(feedbackQuery);

    // Get total count
    let countQuery = supabase
      .from('feedback')
      .select('id', { count: 'exact', head: true })
      .eq('student_id', studentId);

    if (status) {
      countQuery = countQuery.eq('status', status);
    }

    const countResult = await query(countQuery);
    const totalItems = countResult.count || 0;
    const totalPages = Math.ceil(totalItems / limit);

    res.status(200).json({
      success: true,
      data: {
        feedbacks: feedbackResult.rows?.map(feedback => ({
          id: feedback.id,
          subject: feedback.subject,
          category: feedback.category,
          message: feedback.message,
          priority: feedback.priority,
          status: feedback.status,
          submittedAt: feedback.submitted_at,
          resolvedAt: feedback.resolved_at,
          response: feedback.response,
          resolvedBy: feedback.users?.username || null
        })) || [],
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

    const profileResult = await query(
      supabase
        .from('students')
        .select(`
          id,
          name,
          registration_no,
          course,
          phone,
          gender,
          preferences,
          users:user_id(email, username),
          batches:batch_id(name),
          sections:section_id(name),
          houses:house_id(name)
        `)
        .eq('id', studentId)
        .limit(1)
    );

    if (!profileResult.rows || profileResult.rows.length === 0) {
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
          email: student.users?.email || null,
          phone: student.phone,
          registrationNo: student.registration_no,
          course: student.course,
          batch: student.batches?.name || null,
          section: student.sections?.name || null,
          houseName: student.houses?.name || null,
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

    // Update user email if provided
    if (email) {
      // First get the user_id for this student
      const studentUserResult = await query(
        supabase
          .from('students')
          .select('user_id')
          .eq('id', studentId)
          .limit(1)
      );

      if (studentUserResult.rows && studentUserResult.rows.length > 0) {
        const userId = studentUserResult.rows[0].user_id;

        await query(
          supabase
            .from('users')
            .update({ email: email })
            .eq('id', userId)
        );
      }
    }

    // Prepare student updates
    const studentUpdates = {};

    if (phone) {
      studentUpdates.phone = phone;
    }

    if (Object.keys(preferences).length > 0) {
      // Get current preferences and merge
      const currentPrefsResult = await query(
        supabase
          .from('students')
          .select('preferences')
          .eq('id', studentId)
          .limit(1)
      );

      const currentPrefs = currentPrefsResult.rows?.[0]?.preferences || {};
      const mergedPrefs = { ...currentPrefs, ...preferences };
      studentUpdates.preferences = mergedPrefs;
    }

    // Update student record if there are changes
    if (Object.keys(studentUpdates).length > 0) {
      studentUpdates.updated_at = new Date().toISOString();

      await query(
        supabase
          .from('students')
          .update(studentUpdates)
          .eq('id', studentId)
      );
    }

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
      supabase
        .from('students')
        .select(`
          users:user_id(id, password_hash)
        `)
        .eq('id', studentId)
        .limit(1)
    );

    if (!userResult.rows || userResult.rows.length === 0 || !userResult.rows[0].users) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    const user = userResult.rows[0].users;

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
      supabase
        .from('users')
        .update({ password_hash: hashedNewPassword })
        .eq('id', user.id)
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
    const quadrantsResult = await query(
      supabase
        .from('quadrants')
        .select('id, name, description, minimum_attendance, business_rules')
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    const rules = quadrantsResult.rows?.map(quadrant => ({
      quadrant: quadrant.name,
      attendanceRequired: `${quadrant.minimum_attendance}%`,
      otherRequirements: quadrant.description,
      businessRules: quadrant.business_rules,
      gradingCriteria: {
        'A+': '90-100%',
        'A': '80-89%',
        'B': '70-79%',
        'C': '60-69%',
        'D': '50-59%',
        'E': '40-49%',
        'IC': 'Below 40%'
      }
    })) || [];

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
      const termResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );
      if (termResult.rows && termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get quadrants
    const quadrantsResult = await query(
      supabase
        .from('quadrants')
        .select('id, name, minimum_attendance, weightage')
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    // Get attendance data for all quadrants
    const attendanceResult = await query(
      supabase
        .from('attendance_summary')
        .select('quadrant_id, percentage')
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
    );

    // Create attendance lookup
    const attendanceMap = {};
    if (attendanceResult.rows) {
      attendanceResult.rows.forEach(att => {
        attendanceMap[att.quadrant_id] = att.percentage || 0;
      });
    }

    // Get scores for this student and term
    const scoresResult = await query(
      supabase
        .from('scores')
        .select(`
          obtained_score,
          components:component_id(
            weightage,
            sub_categories:sub_category_id(
              quadrant_id
            )
          )
        `)
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
    );

    // Calculate scores by quadrant
    const quadrantScores = {};
    if (scoresResult.rows) {
      scoresResult.rows.forEach(score => {
        const quadrantId = score.components?.sub_categories?.quadrant_id;
        if (quadrantId) {
          if (!quadrantScores[quadrantId]) {
            quadrantScores[quadrantId] = { totalObtained: 0, totalWeightage: 0 };
          }
          const weightage = score.components?.weightage || 0;
          quadrantScores[quadrantId].totalObtained += (score.obtained_score || 0) * (weightage / 100);
          quadrantScores[quadrantId].totalWeightage += weightage;
        }
      });
    }

    // Process eligibility for each quadrant
    const quadrants = [];
    if (quadrantsResult.rows) {
      quadrantsResult.rows.forEach(q => {
        const attendance = attendanceMap[q.id] || 0;
        const scoreData = quadrantScores[q.id] || { totalObtained: 0, totalWeightage: 0 };

        // Calculate score percentage (simplified)
        const scorePercentage = scoreData.totalWeightage > 0
          ? (scoreData.totalObtained / (q.weightage || 100)) * 100
          : 0;

        // Determine eligibility
        const attendanceEligible = attendance >= (q.minimum_attendance || 80);
        const scoreEligible = scorePercentage >= 40;
        const eligible = attendanceEligible && scoreEligible;

        let reason = null;
        if (!eligible) {
          if (!attendanceEligible) {
            reason = 'Attendance below requirement';
          } else if (!scoreEligible) {
            reason = 'Score below threshold';
          }
        }

        quadrants.push({
          id: q.id,
          name: q.name,
          eligible: eligible,
          status: eligible ? 'Eligible' : 'Not Eligible',
          attendance: parseFloat(attendance),
          attendanceRequired: parseFloat(q.minimum_attendance || 80),
          scorePercentage: parseFloat(scorePercentage.toFixed(2)),
          reason: reason
        });
      });
    }

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
      const termResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );
      if (termResult.rows && termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get components with their quadrant information
    let componentsQuery = supabase
      .from('components')
      .select(`
        id,
        name,
        max_score,
        sub_categories:sub_category_id(
          quadrant_id,
          quadrants:quadrant_id(id, name)
        )
      `)
      .eq('is_active', true);

    const componentsResult = await query(componentsQuery);

    // Get scores for this student and term
    const scoresResult = await query(
      supabase
        .from('scores')
        .select('component_id, obtained_score, percentage')
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
    );

    // Create scores lookup
    const scoresMap = {};
    if (scoresResult.rows) {
      scoresResult.rows.forEach(score => {
        scoresMap[score.component_id] = score;
      });
    }

    // Process improvement areas
    const improvementAreas = [];
    if (componentsResult.rows) {
      componentsResult.rows.forEach(comp => {
        const score = scoresMap[comp.id];
        const percentage = score?.percentage || 0;
        const quadrant = comp.sub_categories?.quadrants;

        // Only include components with low scores or no scores
        if (percentage < 75 || !score) {
          // Filter by quadrant if specified
          if (!quadrantId || quadrant?.id === quadrantId) {
            let priority = 'low';
            if (percentage < 60) priority = 'high';
            else if (percentage < 75) priority = 'medium';

            improvementAreas.push({
              quadrantId: quadrant?.id,
              quadrantName: quadrant?.name,
              componentId: comp.id,
              componentName: comp.name,
              score: score?.obtained_score || 0,
              maxScore: comp.max_score,
              percentage: percentage,
              priority: priority
            });
          }
        }
      });
    }

    // Sort by percentage (lowest first) and priority
    improvementAreas.sort((a, b) => {
      if (a.percentage !== b.percentage) return a.percentage - b.percentage;
      const priorityOrder = { high: 3, medium: 2, low: 1 };
      return priorityOrder[b.priority] - priorityOrder[a.priority];
    });

    // Format improvement areas with recommendations
    const formattedImprovementAreas = improvementAreas.map(comp => ({
      quadrantId: comp.quadrantId,
      quadrantName: comp.quadrantName,
      componentId: comp.componentId,
      componentName: comp.componentName,
      score: comp.score,
      maxScore: comp.maxScore,
      status: comp.score > 0 ?
        (comp.percentage >= 75 ? 'Good' : comp.percentage >= 60 ? 'Progress' : 'Deteriorate') :
        'Not Assessed',
      priority: comp.priority,
      recommendations: {
        shortTerm: [
          `Focus on improving ${comp.componentName}`,
          'Practice regularly with available resources'
        ],
        longTerm: [
          `Develop comprehensive ${comp.componentName} skills`,
          'Seek additional guidance from teachers'
        ],
        resources: [
          'Study materials from library',
          'Online practice resources',
          'Peer study groups'
        ]
      }
    }));

    // Get existing goals count (simplified - check if table exists first)
    let goalsData = { goals_set: 0, goals_achieved: 0 };
    try {
      const goalsResult = await query(
        supabase
          .from('student_improvement_goals')
          .select('id, completed_at')
          .eq('student_id', studentId)
          .eq('term_id', currentTermId)
      );

      if (goalsResult.rows) {
        goalsData.goals_set = goalsResult.rows.length;
        goalsData.goals_achieved = goalsResult.rows.filter(g => g.completed_at).length;
      }
    } catch (error) {
      // Table might not exist, use default values
      console.log('Student improvement goals table not found, using defaults');
    }

    const overallRecommendations = [
      'Focus on components with low scores first',
      'Create specific improvement goals',
      'Regular practice and assessment'
    ];

    res.status(200).json({
      success: true,
      data: {
        improvementAreas: formattedImprovementAreas,
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
    const termResult = await query(
      supabase
        .from('terms')
        .select('id')
        .eq('is_current', true)
        .limit(1)
    );

    if (!termResult.rows || termResult.rows.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'No current term found',
        timestamp: new Date().toISOString()
      });
    }
    const currentTermId = termResult.rows[0].id;

    let goalsCreated = 0;

    // Note: student_improvement_goals table should be created via Supabase migrations
    // For now, we'll attempt to insert goals and handle errors gracefully

    for (const goal of goals) {
      try {
        await query(
          supabase
            .from('student_improvement_goals')
            .upsert({
              student_id: studentId,
              term_id: currentTermId,
              component_id: goal.componentId,
              target_score: goal.targetScore,
              target_date: goal.targetDate,
              actions: goal.actions || [],
              created_at: new Date().toISOString()
            }, { onConflict: 'student_id,term_id,component_id' })
        );
        goalsCreated++;
      } catch (error) {
        console.error('Error creating individual goal:', error);
        // Continue with other goals even if one fails
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
      const termResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );
      if (termResult.rows && termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get quadrants
    let quadrantsQuery = supabase
      .from('quadrants')
      .select('id, name, minimum_attendance')
      .eq('is_active', true);

    if (quadrant) {
      quadrantsQuery = quadrantsQuery.eq('id', quadrant);
    }

    quadrantsQuery = quadrantsQuery.order('display_order', { ascending: true });

    const quadrantsResult = await query(quadrantsQuery);

    // Get attendance summary for these quadrants
    const attendanceResult = await query(
      supabase
        .from('attendance_summary')
        .select('quadrant_id, total_sessions, attended_sessions, percentage')
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
    );

    // Create attendance lookup
    const attendanceMap = {};
    if (attendanceResult.rows) {
      attendanceResult.rows.forEach(att => {
        attendanceMap[att.quadrant_id] = att;
      });
    }

    // Combine quadrant and attendance data
    const attendanceData = [];
    if (quadrantsResult.rows) {
      quadrantsResult.rows.forEach(q => {
        const att = attendanceMap[q.id] || { total_sessions: 0, attended_sessions: 0, percentage: 0 };
        const eligibility = att.percentage >= (q.minimum_attendance || 80) ? 'Eligible' : 'Not Eligible';

        attendanceData.push({
          id: q.id,
          name: q.name,
          required: q.minimum_attendance || 80,
          total_sessions: att.total_sessions,
          attended_sessions: att.attended_sessions,
          percentage: att.percentage,
          eligibility: eligibility
        });
      });
    }

    // Calculate overall attendance
    const totalSessions = attendanceData.reduce((sum, q) => sum + q.total_sessions, 0);
    const totalAttended = attendanceData.reduce((sum, q) => sum + q.attended_sessions, 0);
    const overallPercentage = totalSessions > 0 ? (totalAttended / totalSessions) * 100 : 0;

    // Get attendance history by term (simplified)
    const termsResult = await query(
      supabase
        .from('terms')
        .select('id, name, start_date')
        .lte('start_date', new Date().toISOString())
        .order('start_date', { ascending: true })
    );

    const historyData = [];
    if (termsResult.rows) {
      for (const term of termsResult.rows) {
        const termAttendanceResult = await query(
          supabase
            .from('attendance_summary')
            .select('percentage')
            .eq('student_id', studentId)
            .eq('term_id', term.id)
        );

        let avgPercentage = 0;
        if (termAttendanceResult.rows && termAttendanceResult.rows.length > 0) {
          avgPercentage = termAttendanceResult.rows.reduce((sum, att) => sum + (att.percentage || 0), 0) / termAttendanceResult.rows.length;
        }

        historyData.push({
          term: term.name,
          overall: Math.round(avgPercentage)
        });
      }
    }

    res.status(200).json({
      success: true,
      data: {
        overall: {
          attendance: Math.round(overallPercentage),
          eligibility: overallPercentage >= 80 ? 'Eligible' : 'Not Eligible',
          required: 80
        },
        quadrants: attendanceData.map(q => ({
          id: q.id,
          name: q.name,
          attendance: Math.round(q.percentage),
          eligibility: q.eligibility,
          required: Math.round(q.required),
          totalSessions: q.total_sessions,
          attendedSessions: q.attended_sessions
        })),
        history: historyData
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
      const termResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );
      if (termResult.rows && termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get student basic info
    const studentResult = await query(
      supabase
        .from('students')
        .select('id, name, registration_no')
        .eq('id', studentId)
        .limit(1)
    );

    if (!studentResult.rows || studentResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Student not found',
        timestamp: new Date().toISOString()
      });
    }

    // Get quadrants
    let quadrantsQuery = supabase
      .from('quadrants')
      .select('id, name, weightage, minimum_attendance, display_order')
      .eq('is_active', true);

    if (quadrantId) {
      quadrantsQuery = quadrantsQuery.eq('id', quadrantId);
    }

    const quadrantsResult = await query(quadrantsQuery.order('display_order', { ascending: true }));

    // Get sub-categories
    const subCategoriesResult = await query(
      supabase
        .from('sub_categories')
        .select('id, name, weightage, quadrant_id, display_order')
        .in('quadrant_id', quadrantsResult.rows?.map(q => q.id) || [])
        .order('display_order', { ascending: true })
    );

    // Get components
    const componentsResult = await query(
      supabase
        .from('components')
        .select('id, name, max_score, weightage, sub_category_id, display_order')
        .in('sub_category_id', subCategoriesResult.rows?.map(sc => sc.id) || [])
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    // Get scores
    const scoresResult = await query(
      supabase
        .from('scores')
        .select('component_id, obtained_score, percentage')
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
        .in('component_id', componentsResult.rows?.map(c => c.id) || [])
    );

    // Get attendance
    const attendanceResult = await query(
      supabase
        .from('attendance_summary')
        .select('quadrant_id, percentage')
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
        .in('quadrant_id', quadrantsResult.rows?.map(q => q.id) || [])
    );

    // Create lookup maps
    const subCategoriesMap = {};
    const componentsMap = {};
    const scoresMap = {};
    const attendanceMap = {};

    if (subCategoriesResult.rows) {
      subCategoriesResult.rows.forEach(sc => {
        subCategoriesMap[sc.id] = sc;
      });
    }

    if (componentsResult.rows) {
      componentsResult.rows.forEach(c => {
        componentsMap[c.id] = c;
      });
    }

    if (scoresResult.rows) {
      scoresResult.rows.forEach(s => {
        scoresMap[s.component_id] = s;
      });
    }

    if (attendanceResult.rows) {
      attendanceResult.rows.forEach(a => {
        attendanceMap[a.quadrant_id] = a;
      });
    }

    // Process the results into nested structure
    const scoreBreakdown = {};
    let overallTotal = 0;
    let overallMax = 0;

    // Process each quadrant
    if (quadrantsResult.rows) {
      quadrantsResult.rows.forEach(quadrant => {
        const attendance = attendanceMap[quadrant.id];

        scoreBreakdown[quadrant.id] = {
          name: quadrant.name,
          totalScore: 0,
          maxScore: parseFloat(quadrant.weightage),
          percentage: 0,
          weightage: parseFloat(quadrant.weightage),
          contribution: 0,
          subCategories: [],
          eligibility: {
            status: 'Not Eligible',
            attendance: parseFloat(attendance?.percentage || 0),
            minimumAttendance: parseFloat(quadrant.minimum_attendance || 80),
            attendanceEligible: false
          }
        };

        // Process sub-categories for this quadrant
        const quadrantSubCategories = subCategoriesResult.rows?.filter(sc => sc.quadrant_id === quadrant.id) || [];

        quadrantSubCategories.forEach(subCat => {
          const subCategory = {
            id: subCat.id,
            name: subCat.name,
            score: 0,
            maxScore: 0,
            percentage: 0,
            weightage: parseFloat(subCat.weightage),
            components: []
          };

          // Process components for this sub-category
          const subCatComponents = componentsResult.rows?.filter(c => c.sub_category_id === subCat.id) || [];

          subCatComponents.forEach(component => {
            const score = scoresMap[component.id];
            const componentScore = score?.obtained_score || 0;
            const componentMax = parseFloat(component.max_score);
            const componentPercentage = componentMax > 0 ? (componentScore / componentMax) * 100 : 0;

            subCategory.components.push({
              id: component.id,
              name: component.name,
              score: componentScore,
              maxScore: componentMax,
              percentage: componentPercentage,
              weightage: parseFloat(component.weightage),
              status: componentPercentage >= 80 ? 'Good' : componentPercentage >= 60 ? 'Progress' : 'Deteriorate'
            });

            // Update subcategory totals
            subCategory.score += componentScore * (parseFloat(component.weightage) / 100);
            subCategory.maxScore += componentMax * (parseFloat(component.weightage) / 100);
          });

          scoreBreakdown[quadrant.id].subCategories.push(subCategory);
        });
      });
    }

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
      const termResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );
      if (termResult.rows && termResult.rows.length > 0) {
        currentTermId = termResult.rows[0].id;
      }
    }

    // Get behavior and discipline quadrants
    const behaviorQuadrantsResult = await query(
      supabase
        .from('quadrants')
        .select('id, name, display_order')
        .in('id', ['behavior', 'discipline'])
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    if (!behaviorQuadrantsResult.rows || behaviorQuadrantsResult.rows.length === 0) {
      return res.status(200).json({
        success: true,
        data: {
          ratingScale: {
            5: { label: 'Excellent', description: 'Consistently exceeds expectations' },
            4: { label: 'Good', description: 'Usually meets or exceeds expectations' },
            3: { label: 'Satisfactory', description: 'Generally meets expectations' },
            2: { label: 'Needs Improvement', description: 'Sometimes meets expectations' },
            1: { label: 'Unsatisfactory', description: 'Rarely meets expectations' }
          },
          components: [],
          overallBehaviorScore: { average: 0, status: 'No Data' }
        },
        timestamp: new Date().toISOString()
      });
    }

    // Get components for behavior/discipline quadrants
    const componentsResult = await query(
      supabase
        .from('components')
        .select(`
          id,
          name,
          description,
          max_score,
          sub_categories:sub_category_id(
            quadrant_id,
            quadrants:quadrant_id(name, display_order)
          )
        `)
        .eq('is_active', true)
    );

    // Filter components that belong to behavior/discipline quadrants
    const behaviorComponents = [];
    if (componentsResult.rows) {
      componentsResult.rows.forEach(comp => {
        const quadrantId = comp.sub_categories?.quadrant_id;
        if (quadrantId && ['behavior', 'discipline'].includes(quadrantId)) {
          behaviorComponents.push(comp);
        }
      });
    }

    // Get scores for these components
    const scoresResult = await query(
      supabase
        .from('scores')
        .select('component_id, obtained_score, percentage, assessment_date, notes')
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
        .in('component_id', behaviorComponents.map(c => c.id))
    );

    // Create scores lookup
    const scoresMap = {};
    if (scoresResult.rows) {
      scoresResult.rows.forEach(score => {
        scoresMap[score.component_id] = score;
      });
    }

    const ratingScale = {
      5: { label: 'Excellent', description: 'Consistently exceeds expectations' },
      4: { label: 'Good', description: 'Usually meets or exceeds expectations' },
      3: { label: 'Satisfactory', description: 'Generally meets expectations' },
      2: { label: 'Needs Improvement', description: 'Sometimes meets expectations' },
      1: { label: 'Unsatisfactory', description: 'Rarely meets expectations' }
    };

    const formattedBehaviorComponents = behaviorComponents.map(comp => {
      const score = scoresMap[comp.id];
      const currentRating = score?.obtained_score || null;

      return {
        id: comp.id,
        name: comp.name,
        description: comp.description,
        quadrant: comp.sub_categories?.quadrants?.name || 'Unknown',
        currentRating: currentRating,
        maxRating: comp.max_score,
        percentage: score?.percentage || null,
        lastAssessed: score?.assessment_date,
        notes: score?.notes,
        ratingDescription: currentRating ? ratingScale[Math.round(currentRating)]?.label : null
      };
    });

    res.status(200).json({
      success: true,
      data: {
        ratingScale,
        components: formattedBehaviorComponents,
        overallBehaviorScore: {
          average: formattedBehaviorComponents.length > 0 ?
            Math.round((formattedBehaviorComponents.reduce((sum, comp) => sum + (comp.currentRating || 0), 0) / formattedBehaviorComponents.length) * 100) / 100 : 0,
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

    // Get student intervention enrollments
    let enrollmentsQuery = supabase
      .from('intervention_enrollments')
      .select(`
        enrollment_date,
        completion_percentage,
        current_score,
        interventions:intervention_id(
          id,
          name,
          description,
          start_date,
          end_date,
          status
        )
      `)
      .eq('student_id', studentId);

    const enrollmentsResult = await query(enrollmentsQuery.order('enrollment_date', { ascending: false }));

    // Filter by status if provided
    let interventions = [];
    if (enrollmentsResult.rows) {
      interventions = enrollmentsResult.rows
        .filter(enrollment => {
          const intervention = enrollment.interventions;
          if (!intervention) return false;
          if (status && intervention.status !== status) return false;
          return true;
        })
        .map(enrollment => ({
          id: enrollment.interventions.id,
          name: enrollment.interventions.name,
          description: enrollment.interventions.description,
          start_date: enrollment.interventions.start_date,
          end_date: enrollment.interventions.end_date,
          status: enrollment.interventions.status,
          enrollment_date: enrollment.enrollment_date,
          progress_percentage: enrollment.completion_percentage,
          current_score: enrollment.current_score,
          max_score: enrollment.current_score, // Simplified
          last_activity: enrollment.enrollment_date,
          total_tasks: 0, // Simplified - would need tasks table
          completed_tasks: 0 // Simplified - would need task_submissions table
        }));
    }

    // Filter by quadrant if provided (simplified - would need intervention_quadrants table)
    if (quadrant) {
      // For now, return empty array if quadrant filter is applied
      // In a full implementation, you'd query intervention_quadrants table
      interventions = [];
    }

    // Format interventions for response (simplified)
    const formattedInterventions = interventions.map(intervention => ({
      id: intervention.id,
      name: intervention.name,
      description: intervention.description,
      startDate: intervention.start_date,
      endDate: intervention.end_date,
      status: intervention.status,
      enrollmentDate: intervention.enrollment_date,
      progressPercentage: Math.round(intervention.progress_percentage || 0),
      currentScore: intervention.current_score || 0,
      maxScore: intervention.max_score || 100,
      lastActivity: intervention.last_activity,
      tasks: {
        total: intervention.total_tasks,
        completed: intervention.completed_tasks,
        remaining: intervention.total_tasks - intervention.completed_tasks
      },
      quadrants: [] // Simplified - would need intervention_quadrants table
    }));
    // Note: Original complex intervention logic simplified for Supabase conversion
    // Full implementation would require intervention_quadrants and tasks tables

    // Calculate summary
    const totalInterventions = formattedInterventions.length;
    const activeInterventions = formattedInterventions.filter(i => i.status === 'Active').length;
    const completedInterventions = formattedInterventions.filter(i => i.status === 'Completed').length;
    const overallProgress = formattedInterventions.length > 0 ?
      formattedInterventions.reduce((sum, i) => sum + i.progressPercentage, 0) / formattedInterventions.length : 0;

    res.status(200).json({
      success: true,
      data: {
        interventions: formattedInterventions,
        summary: {
          totalInterventions,
          activeInterventions,
          completedInterventions,
          overallProgress: Math.round(overallProgress),
          averageScore: formattedInterventions.length > 0 ?
            Math.round(formattedInterventions.reduce((sum, i) => sum + i.currentScore, 0) / formattedInterventions.length) : 0,
          pendingTasks: formattedInterventions.reduce((sum, i) => sum + i.tasks.remaining, 0)
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
    const existingResult = await query(
      supabase
        .from('task_submissions')
        .select('id')
        .eq('task_id', taskId)
        .eq('student_id', studentId)
        .limit(1)
    );

    if (existingResult.rows.length > 0) {
      return res.status(400).json({
        success: false,
        message: 'Task already submitted',
        timestamp: new Date().toISOString()
      });
    }

    // Create task submission
    const submissionResult = await query(
      supabase
        .from('task_submissions')
        .insert({
          task_id: taskId,
          student_id: studentId,
          submitted_at: new Date().toISOString(),
          submission_text: notes || '',
          is_late: isLate
        })
        .select('id, submitted_at')
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
      const termResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );
      if (termResult.rows && termResult.rows.length > 0) {
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
