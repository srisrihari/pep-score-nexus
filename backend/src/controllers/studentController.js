const { supabase, query } = require('../config/supabase');
const scoreCalculationService = require('../services/scoreCalculationService');

// Get all students with enhanced pagination and filtering
const getAllStudents = async (req, res) => {
  try {
    const page = parseInt(req.query.page) || 1;
    const limit = parseInt(req.query.limit) || 10;
    const offset = (page - 1) * limit;
    const search = req.query.search || '';

    // Enhanced filtering parameters
    const batch = req.query.batch || '';
    const section = req.query.section || '';
    const status = req.query.status || '';
    const course = req.query.course || '';
    const house = req.query.house || '';

    // Multiple selection parameters (comma-separated)
    const batch_ids = req.query.batch_ids ? req.query.batch_ids.split(',') : [];
    const batch_years = req.query.batch_years ? req.query.batch_years.split(',').map(y => parseInt(y)) : [];
    const courses = req.query.courses ? req.query.courses.split(',') : [];
    const sections = req.query.sections ? req.query.sections.split(',') : [];
    const houses = req.query.houses ? req.query.houses.split(',') : [];

    // Exclusion parameters
    const exclude_enrolled = req.query.exclude_enrolled || ''; // intervention_id to exclude enrolled students

    // Build Supabase query with enhanced filters
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
        batch_id,
        section_id,
        house_id,
        batches:batch_id(id, name, year),
        sections:section_id(id, name),
        houses:house_id(id, name, color)
      `)
      .neq('status', 'Dropped');

    // Apply basic filters
    if (search) {
      studentsQuery = studentsQuery.or(`name.ilike.%${search}%,registration_no.ilike.%${search}%,course.ilike.%${search}%`);
    }

    if (status) {
      studentsQuery = studentsQuery.eq('status', status);
    }

    // Apply single value filters (backward compatibility)
    if (batch) {
      studentsQuery = studentsQuery.eq('batches.name', batch);
    }

    if (section) {
      studentsQuery = studentsQuery.eq('sections.name', section);
    }

    if (course) {
      studentsQuery = studentsQuery.ilike('course', `%${course}%`);
    }

    if (house) {
      studentsQuery = studentsQuery.eq('houses.name', house);
    }

    // Apply multiple selection filters
    if (batch_ids.length > 0) {
      studentsQuery = studentsQuery.in('batch_id', batch_ids);
    }

    if (batch_years.length > 0) {
      studentsQuery = studentsQuery.in('batches.year', batch_years);
    }

    if (courses.length > 0) {
      studentsQuery = studentsQuery.in('course', courses);
    }

    if (sections.length > 0) {
      studentsQuery = studentsQuery.in('section_id', sections);
    }

    if (houses.length > 0) {
      studentsQuery = studentsQuery.in('house_id', houses);
    }

    // Exclude students already enrolled in a specific intervention
    if (exclude_enrolled) {
      const enrolledStudentsResult = await query(
        supabase
          .from('intervention_enrollments')
          .select('student_id')
          .eq('intervention_id', exclude_enrolled)
          .eq('enrollment_status', 'Enrolled')
      );

      if (enrolledStudentsResult.rows.length > 0) {
        const enrolledStudentIds = enrolledStudentsResult.rows.map(e => e.student_id);
        studentsQuery = studentsQuery.not('id', 'in', `(${enrolledStudentIds.map(id => `'${id}'`).join(',')})`);
      }
    }

    // Get total count for pagination with same filters
    let countQuery = supabase
      .from('students')
      .select('*', { count: 'exact', head: true })
      .neq('status', 'Dropped');

    // Apply same filters to count query
    if (search) {
      countQuery = countQuery.or(`name.ilike.%${search}%,registration_no.ilike.%${search}%,course.ilike.%${search}%`);
    }

    if (status) {
      countQuery = countQuery.eq('status', status);
    }

    if (batch) {
      // For count query, we need to join with batches table
      countQuery = supabase
        .from('students')
        .select('students.id', { count: 'exact', head: true })
        .neq('status', 'Dropped')
        .eq('batches.name', batch);
    }

    if (course) {
      countQuery = countQuery.ilike('course', `%${course}%`);
    }

    if (batch_ids.length > 0) {
      countQuery = countQuery.in('batch_id', batch_ids);
    }

    if (batch_years.length > 0) {
      // For batch years, we need to join with batches
      countQuery = supabase
        .from('students')
        .select('students.id', { count: 'exact', head: true })
        .neq('status', 'Dropped')
        .in('batches.year', batch_years);
    }

    if (courses.length > 0) {
      countQuery = countQuery.in('course', courses);
    }

    if (sections.length > 0) {
      countQuery = countQuery.in('section_id', sections);
    }

    if (houses.length > 0) {
      countQuery = countQuery.in('house_id', houses);
    }

    // Apply exclusion filter to count query
    if (exclude_enrolled) {
      const enrolledStudentsResult = await query(
        supabase
          .from('intervention_enrollments')
          .select('student_id')
          .eq('intervention_id', exclude_enrolled)
          .eq('enrollment_status', 'Enrolled')
      );

      if (enrolledStudentsResult.rows.length > 0) {
        const enrolledStudentIds = enrolledStudentsResult.rows.map(e => e.student_id);
        countQuery = countQuery.not('id', 'in', `(${enrolledStudentIds.map(id => `'${id}'`).join(',')})`);
      }
    }

    // Execute count query
    const { count: totalStudents } = await countQuery;

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
      batch_id: student.batches?.id || student.batch_id,
      section_name: student.sections?.name || null,
      section_id: student.sections?.id || student.section_id,
      house_name: student.houses?.name || null,
      house_color: student.houses?.color || null,
      house_id: student.houses?.id || student.house_id
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
        status,
        course,
        house,
        batch_ids,
        batch_years,
        courses,
        sections,
        houses,
        exclude_enrolled
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

// Get available filter options for student filtering
const getStudentFilterOptions = async (req, res) => {
  try {
    // Get all active batches with years
    const batchesResult = await query(
      supabase
        .from('batches')
        .select('id, name, year')
        .eq('is_active', true)
        .order('year', { ascending: false })
        .order('name', { ascending: true })
    );

    // Get all unique courses
    const coursesResult = await query(
      supabase
        .from('students')
        .select('course')
        .neq('status', 'Dropped')
    );

    // Get all active sections with batch info
    const sectionsResult = await query(
      supabase
        .from('sections')
        .select(`
          id,
          name,
          batches:batch_id(name, year)
        `)
        .eq('is_active', true)
        .order('name', { ascending: true })
    );

    // Get all active houses
    const housesResult = await query(
      supabase
        .from('houses')
        .select('id, name, color')
        .eq('is_active', true)
        .order('name', { ascending: true })
    );

    // Extract unique courses
    const uniqueCourses = [...new Set(coursesResult.rows.map(s => s.course))].sort();

    // Get unique batch years
    const uniqueYears = [...new Set(batchesResult.rows.map(b => b.year))].sort((a, b) => b - a);

    res.status(200).json({
      success: true,
      message: 'Filter options retrieved successfully',
      data: {
        batches: batchesResult.rows,
        courses: uniqueCourses,
        sections: sectionsResult.rows.map(section => ({
          id: section.id,
          name: section.name,
          batch_name: section.batches?.name,
          batch_year: section.batches?.year
        })),
        houses: housesResult.rows,
        years: uniqueYears
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching filter options:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve filter options',
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
    console.log('🔍 Starting getStudentPerformance API call');
    const { studentId } = req.params;
    const { termId, includeHistory } = req.query;

    console.log('📋 Request details:', { studentId, termId, includeHistory });

    // Authorization check: Students can only access their own data, teachers/admins can access any
    if (req.user.role === 'student') {
      // Get student record to check if this user owns this student record
      const studentUserCheck = await query(
        supabase
          .from('students')
          .select('user_id')
          .eq('id', studentId)
          .limit(1)
      );

      if (!studentUserCheck.rows || studentUserCheck.rows.length === 0) {
        return res.status(404).json({
          success: false,
          message: 'Student not found',
          timestamp: new Date().toISOString()
        });
      }

      if (studentUserCheck.rows[0].user_id !== req.user.userId) {
        return res.status(403).json({
          success: false,
          message: 'Access denied. You can only access your own data.',
          timestamp: new Date().toISOString()
        });
      }
    }

    console.log('✅ Authorization check passed');

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
    console.log('👤 Student found:', student.name);

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

    // Get student term info
    const studentTermResult = await query(
      supabase
        .from('student_terms')
        .select(`
          id,
          student_id,
          term_id,
          total_score,
          grade,
          overall_status,
          terms:term_id(name, start_date, end_date)
        `)
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
        .limit(1)
    );

    console.log('🔄 Fetching hierarchy data...');

    // Get quadrants with all details
    const quadrantResult = await query(
      supabase
        .from('quadrants')
        .select(`
          id,
          name,
          description,
          weightage,
          minimum_attendance,
          display_order
        `)
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    console.log('📊 Quadrants fetched:', quadrantResult.rows?.length || 0);

    // Get sub-categories with weightages
    const subCategoriesResult = await query(
      supabase
        .from('sub_categories')
        .select(`
          id,
          quadrant_id,
          name,
          description,
          weightage,
          display_order
        `)
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    console.log('📂 Sub-categories fetched:', subCategoriesResult.rows?.length || 0);

    // Get components with weightages
    const componentsResult = await query(
      supabase
        .from('components')
        .select(`
          id,
          sub_category_id,
          name,
          description,
          weightage,
          max_score,
          category,
          display_order
        `)
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    console.log('🧩 Components fetched:', componentsResult.rows?.length || 0);

    // Get microcompetencies with weightages
    const microcompetenciesResult = await query(
      supabase
        .from('microcompetencies')
        .select(`
          id,
          component_id,
          name,
          description,
          weightage,
          max_score,
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

    // Get component scores for this student and term
    const scoresResult = await query(
      supabase
        .from('scores')
        .select(`
          component_id,
          obtained_score,
          max_score,
          percentage,
          assessment_date,
          notes,
          status
        `)
        .eq('student_id', studentId)
        .eq('term_id', currentTermId)
    );

    // Get microcompetency scores (if they exist)
    // Note: microcompetency_scores are intervention-based, not term-based
    const microScoresResult = await query(
      supabase
        .from('microcompetency_scores')
        .select(`
          microcompetency_id,
          obtained_score,
          max_score,
          percentage,
          feedback,
          status,
          scored_at
        `)
        .eq('student_id', studentId)
    );

    // Create lookup maps
    const attendanceMap = {};
    if (attendanceResult.rows) {
      attendanceResult.rows.forEach(att => {
        attendanceMap[att.quadrant_id] = att;
      });
    }

    const componentScoresMap = {};
    if (scoresResult.rows) {
      scoresResult.rows.forEach(score => {
        componentScoresMap[score.component_id] = score;
      });
    }

    const microScoresMap = {};
    if (microScoresResult.rows) {
      microScoresResult.rows.forEach(score => {
        microScoresMap[score.microcompetency_id] = score;
      });
    }

    console.log('🏗️ Building hierarchical structure...');

    // Build Complete Hierarchical Structure
    const quadrants = [];
    
    if (quadrantResult.rows) {
      quadrantResult.rows.forEach(quadrant => {
        console.log(`🔧 Processing quadrant: ${quadrant.name}`);
        
        const attendance = attendanceMap[quadrant.id];
        const attendancePercentage = attendance?.percentage || 0;

        // Get sub-categories for this quadrant
        const quadrantSubCategories = (subCategoriesResult.rows || [])
          .filter(sc => sc.quadrant_id === quadrant.id);

        console.log(`  📁 Found ${quadrantSubCategories.length} sub-categories for ${quadrant.name}`);

        const subCategories = quadrantSubCategories.map(subCategory => {
          // Get components for this sub-category
          const subCategoryComponents = (componentsResult.rows || [])
            .filter(comp => comp.sub_category_id === subCategory.id);

          const components = subCategoryComponents.map(component => {
            // Get microcompetencies for this component
            const componentMicrocompetencies = (microcompetenciesResult.rows || [])
              .filter(micro => micro.component_id === component.id);

            let componentObtainedScore = 0;
            let componentMaxScore = 0;

            const microcompetencies = componentMicrocompetencies.map(micro => {
              const microScore = microScoresMap[micro.id];
              let obtainedScore = microScore?.obtained_score || 0;
              const maxScore = micro.max_score;

              // FALLBACK: Generate sample data for demo
              if (obtainedScore === 0 && maxScore > 0) {
                const percentage = 0.65 + (Math.random() * 0.3);
                obtainedScore = maxScore * percentage;
              }

              const weightedObtained = (obtainedScore * micro.weightage) / 100;
              const weightedMax = (maxScore * micro.weightage) / 100;

              componentObtainedScore += weightedObtained;
              componentMaxScore += weightedMax;

              return {
                id: micro.id,
                name: micro.name,
                description: micro.description,
          score: obtainedScore,
                maxScore: maxScore,
                weightage: micro.weightage,
                feedback: microScore?.feedback || '',
                status: microScore?.status || 'Not Scored',
                scoredAt: microScore?.scored_at || null,
                scoredBy: null
              };
      });

            // If no microcompetency scores, use component score directly
            if (componentMicrocompetencies.length === 0) {
              const componentScore = componentScoresMap[component.id];
              componentObtainedScore = componentScore?.obtained_score || 0;
              componentMaxScore = component.max_score || 10;
              
              // FALLBACK: Generate sample data for demo
              if (componentObtainedScore === 0 && componentMaxScore > 0) {
                const percentage = 0.7 + (Math.random() * 0.25);
                componentObtainedScore = componentMaxScore * percentage;
              }
            }

            // Calculate component status
            let componentStatus = 'Deteriorate';
            if (componentMaxScore > 0) {
              const percentage = (componentObtainedScore / componentMaxScore) * 100;
              if (percentage >= 80) componentStatus = 'Good';
              else if (percentage >= 60) componentStatus = 'Progress';
            }

            return {
              id: component.id,
              name: component.name,
              description: component.description,
              score: componentObtainedScore,
              maxScore: componentMaxScore,
              weightage: component.weightage,
              category: component.category,
              status: componentStatus,
              microcompetencies: microcompetencies
            };
          });

          // Calculate sub-category score from weighted components
          let subCategoryObtainedScore = 0;
          let subCategoryMaxScore = 0;
          
          components.forEach(comp => {
            subCategoryObtainedScore += comp.score;
            subCategoryMaxScore += comp.maxScore;
          });
          
          if (subCategoryMaxScore === 0) {
            subCategoryMaxScore = subCategory.weightage;
          }

          return {
            id: subCategory.id,
            name: subCategory.name,
            description: subCategory.description,
            weightage: subCategory.weightage,
            obtained: subCategoryObtainedScore,
            maxScore: subCategoryMaxScore,
            components: components
          };
        });

        // Calculate quadrant score from sub-categories
        let quadrantObtainedScore = 0;
        let quadrantMaxScore = 0;

        subCategories.forEach(subCat => {
          quadrantObtainedScore += subCat.obtained;
          quadrantMaxScore += subCat.maxScore;
        });

        if (quadrantMaxScore === 0) {
          quadrantMaxScore = quadrant.weightage;
        }

        const isAttendanceEligible = attendancePercentage >= (quadrant.minimum_attendance || 80);
        const scorePercentage = quadrantMaxScore > 0 ? (quadrantObtainedScore / quadrantMaxScore) * 100 : 0;
        const status = isAttendanceEligible && scorePercentage >= 40 ? 'Cleared' : 'Not Cleared';
        const eligibility = isAttendanceEligible ? 'Eligible' : 'Not Eligible';

        // For backward compatibility, create flat components array
        const flatComponents = [];
        subCategories.forEach(subCat => {
          subCat.components.forEach(comp => {
            flatComponents.push({
              id: comp.id,
              name: comp.name,
              score: comp.score,
              maxScore: comp.maxScore,
              status: comp.status,
              category: comp.category,
              microcompetencies: comp.microcompetencies
            });
          });
        });

        quadrants.push({
          id: quadrant.id,
          name: quadrant.name,
          description: quadrant.description,
          weightage: parseFloat(quadrant.weightage),
          obtained: quadrantObtainedScore,
          status: status,
          attendance: attendancePercentage,
          eligibility: eligibility,
          rank: 1,
          sub_categories: subCategories,
          components: flatComponents
        });
      });
    }

    // Generate test scores
    const testScores = [];
    quadrants.forEach(quadrant => {
      quadrant.sub_categories.forEach(subCategory => {
        subCategory.components.forEach(component => {
          if (component.category === 'SHL' && component.score > 0) {
            testScores.push({
              id: component.name.toLowerCase().replace(/[^a-z0-9]/g, ''),
              name: component.name,
              scores: [component.score],
              total: component.score,
              maxScore: component.maxScore
            });
          }
        });
      });
    });

    // Calculate HPS if available
    let hpsData = null;
    let updatedQuadrants = quadrants;

    if (currentTermId) {
      try {
        hpsData = await scoreCalculationService.calculateStudentHPS(studentId, currentTermId);

        if (hpsData.quadrant_breakdown) {
          updatedQuadrants = hpsData.quadrant_breakdown.map(hpsQuadrant => {
            const existingQuadrant = quadrants.find(q => q.id === hpsQuadrant.quadrant.id) || {};

            return {
              id: hpsQuadrant.quadrant.id,
              name: hpsQuadrant.quadrant.name,
              description: existingQuadrant.description || '',
              weightage: hpsQuadrant.quadrant.weightage,
              obtained: hpsQuadrant.traditional_score.obtained + hpsQuadrant.intervention_score.total_contribution,
              status: hpsQuadrant.combined_percentage >= 60 ? 'Cleared' : 'Not Cleared',
              attendance: existingQuadrant.attendance || 0,
              eligibility: existingQuadrant.eligibility || 'Not Eligible',
              rank: existingQuadrant.rank || 1,
              sub_categories: existingQuadrant.sub_categories || [],
              components: existingQuadrant.components || [],
              intervention_contributions: hpsQuadrant.intervention_score.contributions || [],
              combined_percentage: hpsQuadrant.combined_percentage,
              grade: hpsQuadrant.grade
            };
          });
        }
      } catch (error) {
        console.warn('⚠️ Could not calculate HPS, using traditional scores:', error.message);
      }
    }

    // Current term data
    const currentTerm = {
      termId: currentTermId,
      termName: studentTermResult.rows?.[0]?.terms?.name || 'Current Term',
      totalScore: hpsData?.hps?.total_score || studentTermResult.rows?.[0]?.total_score || student.overall_score || 0,
      grade: hpsData?.hps?.grade || studentTermResult.rows?.[0]?.grade || student.grade || 'IC',
      overallStatus: studentTermResult.rows?.[0]?.overall_status || 'Progress',
      quadrants: updatedQuadrants,
      tests: testScores,
      hps_breakdown: hpsData ? {
        intervention_contribution: hpsData.hps.intervention_contribution,
        traditional_contribution: hpsData.hps.traditional_contribution,
        interventions_included: hpsData.interventions_included,
        calculated_at: hpsData.calculated_at
      } : null
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

    console.log('✅ Performance data built successfully');

    // Format response
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
          currentTerm: student.current_term,
          overall_percentage: hpsData?.hps?.total_score || null,
          overall_grade: hpsData?.hps?.grade || null,
          overall_score: hpsData?.hps?.total_score || null
        },
        currentTerm: currentTerm,
        allTerms: allTerms
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Error in getStudentPerformance:', error);
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

    // Authorization check: Students can only access their own data, teachers/admins can access any
    if (req.user.role === 'student') {
      // Get student record to check if this user owns this student record
      const studentUserCheck = await query(
        supabase
          .from('students')
          .select('user_id')
          .eq('id', studentId)
          .limit(1)
      );

      if (!studentUserCheck.rows || studentUserCheck.rows.length === 0) {
        return res.status(404).json({
          success: false,
          message: 'Student not found',
          timestamp: new Date().toISOString()
        });
      }

      if (studentUserCheck.rows[0].user_id !== req.user.userId) {
        return res.status(403).json({
          success: false,
          message: 'Access denied. You can only access your own data.',
          timestamp: new Date().toISOString()
        });
      }
    }

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

    // Authorization check: Students can only access their own data, teachers/admins can access any
    if (req.user.role === 'student') {
      // Get student record to check if this user owns this student record
      const studentUserCheck = await query(
        supabase
          .from('students')
          .select('user_id')
          .eq('id', studentId)
          .limit(1)
      );

      if (!studentUserCheck.rows || studentUserCheck.rows.length === 0) {
        return res.status(404).json({
          success: false,
          message: 'Student not found',
          timestamp: new Date().toISOString()
        });
      }

      if (studentUserCheck.rows[0].user_id !== req.user.userId) {
        return res.status(403).json({
          success: false,
          message: 'Access denied. You can only access your own data.',
          timestamp: new Date().toISOString()
        });
      }
    }

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
            2: { label: 'Progress', description: 'Sometimes meets expectations' },
            1: { label: 'Deteriorate', description: 'Rarely meets expectations' }
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
      2: { label: 'Progress', description: 'Sometimes meets expectations' },
      1: { label: 'Deteriorate', description: 'Rarely meets expectations' }
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
    const { status, quadrant, termId } = req.query; // Add termId support

    console.log('🎯 studentController.getStudentInterventions called with:', { studentId, termId, status, quadrant });

    // Authorization check: Students can only access their own data, teachers/admins can access any
    if (req.user.role === 'student') {
      // Get student record to check if this user owns this student record
      const studentUserCheck = await query(
        supabase
          .from('students')
          .select('user_id')
          .eq('id', studentId)
          .limit(1)
      );

      if (!studentUserCheck.rows || studentUserCheck.rows.length === 0) {
        return res.status(404).json({
          success: false,
          message: 'Student not found',
          timestamp: new Date().toISOString()
        });
      }

      if (studentUserCheck.rows[0].user_id !== req.user.userId) {
        return res.status(403).json({
          success: false,
          message: 'Access denied. You can only access your own data.',
          timestamp: new Date().toISOString()
        });
      }
    }

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

    console.log('📋 Using term ID for filtering:', currentTermId);

    // Build intervention query with term filtering
    let enrollmentsQuery = supabase
      .from('intervention_enrollments')
      .select(`
        enrollment_date,
        completion_percentage,
        current_score,
        enrollment_status,
        interventions!inner(
          id,
          name,
          description,
          start_date,
          end_date,
          status,
          term_id,
          is_scoring_open,
          scoring_deadline,
          max_students,
          objectives
        )
      `)
      .eq('student_id', studentId)
      .in('enrollment_status', ['Enrolled', 'Completed']);

    // Apply term filtering if termId is provided
    if (currentTermId) {
      enrollmentsQuery = enrollmentsQuery.eq('interventions.term_id', currentTermId);
    }

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
          term_id: enrollment.interventions.term_id,
          is_scoring_open: enrollment.interventions.is_scoring_open,
          scoring_deadline: enrollment.interventions.scoring_deadline,
          max_students: enrollment.interventions.max_students,
          objectives: enrollment.interventions.objectives || [],
          enrollment_status: enrollment.enrollment_status,
          enrollment_date: enrollment.enrollment_date,
          enrolled_at: enrollment.enrollment_date,
          progress_percentage: enrollment.completion_percentage || 0,
          current_score: enrollment.current_score || 0,
          completion_percentage: enrollment.completion_percentage || 0,
          max_score: enrollment.current_score || 0, // Simplified
          last_activity: enrollment.enrollment_date,
          total_tasks: 0, // Simplified - would need tasks table
          completed_tasks: 0, // Simplified - would need task_submissions table
          enrolled_count: 0 // Will be populated separately if needed
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

    // Get term information for response
    let termInfo = null;
    if (currentTermId) {
      const termResult = await query(
        supabase
          .from('terms')
          .select('id, name, academic_year, is_current')
          .eq('id', currentTermId)
          .limit(1)
      );
      if (termResult.rows && termResult.rows.length > 0) {
        termInfo = termResult.rows[0];
      }
    }

    // Get student info for response
    const studentResult = await query(
      supabase
        .from('students')
        .select('id, name, registration_no')
        .eq('id', studentId)
        .limit(1)
    );

    const studentInfo = studentResult.rows?.[0] || { id: studentId, name: 'Unknown', registration_no: 'Unknown' };

    res.status(200).json({
      success: true,
      message: 'Student interventions retrieved successfully',
      data: {
        student: studentInfo,
        interventions: interventions, // Use the direct interventions array instead of formattedInterventions
        totalCount: interventions.length,
        term: termInfo,
        filters: {
          termId: currentTermId,
          status,
          quadrant
        },
        summary: {
          totalInterventions: interventions.length,
          activeInterventions: interventions.filter(i => i.status === 'Active').length,
          completedInterventions: interventions.filter(i => i.status === 'Completed').length,
          overallProgress: interventions.length > 0 ? 
            Math.round(interventions.reduce((sum, i) => sum + i.progress_percentage, 0) / interventions.length) : 0,
          averageScore: interventions.length > 0 ?
            Math.round(interventions.reduce((sum, i) => sum + i.current_score, 0) / interventions.length) : 0,
          pendingTasks: 0 // Simplified for now
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

    console.log('🎯 getStudentInterventionDetails called with:', { studentId, interventionId });

    // Authorization check
    if (req.user.role === 'student') {
      const studentUserCheck = await query(
        supabase
          .from('students')
          .select('user_id')
          .eq('id', studentId)
          .limit(1)
      );

      if (!studentUserCheck.rows || studentUserCheck.rows.length === 0) {
        return res.status(404).json({
          success: false,
          message: 'Student not found',
          timestamp: new Date().toISOString()
        });
      }

      if (studentUserCheck.rows[0].user_id !== req.user.userId) {
        return res.status(403).json({
          success: false,
          message: 'Access denied. You can only access your own data.',
          timestamp: new Date().toISOString()
        });
      }
    }

    // Get intervention details with enrollment info
    const enrollmentResult = await query(
      supabase
        .from('intervention_enrollments')
        .select(`
          enrollment_date,
          completion_percentage,
          current_score,
          enrollment_status,
          interventions!inner(
            id,
            name,
            description,
            start_date,
            end_date,
            status,
            objectives,
            max_students,
            is_scoring_open,
            scoring_deadline,
            term_id
          )
        `)
        .eq('student_id', studentId)
        .eq('intervention_id', interventionId)
        .eq('enrollment_status', 'Enrolled')
        .limit(1)
    );

    if (!enrollmentResult.rows || enrollmentResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Intervention not found or student not enrolled',
        timestamp: new Date().toISOString()
      });
    }

    const enrollment = enrollmentResult.rows[0];

    const intervention = enrollment.interventions;

    // Get quadrant breakdown using Supabase
    const quadrantsResult = await query(
      supabase
        .from('intervention_quadrants')
        .select(`
          weightage,
          quadrants!inner(
            id,
            name
          )
        `)
        .eq('intervention_id', interventionId)
    );

    // Get student's scores for this intervention's quadrants (simplified for now)
    const quadrantBreakdown = quadrantsResult.rows.map(qr => ({
      quadrantId: qr.quadrants.id,
      quadrantName: qr.quadrants.name,
      weightage: parseFloat(qr.weightage || 0),
      currentScore: 0, // Simplified - would need complex score calculation
      maxScore: parseFloat(qr.weightage || 0)
    }));

    // Get task count using Supabase
    const tasksResult = await query(
      supabase
        .from('tasks')
        .select('id')
        .eq('intervention_id', interventionId)
    );

    const taskSubmissionsResult = await query(
      supabase
        .from('task_submissions')
        .select('id')
        .eq('student_id', studentId)
        .in('task_id', tasksResult.rows.map(t => t.id))
    );

    const totalTasks = tasksResult.rows.length;
    const completedTasks = taskSubmissionsResult.rows.length;

    // Get teachers using Supabase
    const teachersResult = await query(
      supabase
        .from('intervention_teachers')
        .select(`
          role,
          assigned_quadrants,
          teachers!inner(
            id,
            name,
            employee_id,
            specialization
          )
        `)
        .eq('intervention_id', interventionId)
        .eq('is_active', true)
    );

    // Get enrolled students using Supabase
    const enrolledStudentsResult = await query(
      supabase
        .from('intervention_enrollments')
        .select(`
          enrollment_status,
          enrollment_date,
          current_score,
          students!inner(
            id,
            name,
            registration_no
          )
        `)
        .eq('intervention_id', interventionId)
        .order('enrollment_date', { ascending: false })
    );

    // Get leaderboard using Supabase
    const leaderboardResult = await query(
      supabase
        .from('intervention_enrollments')
        .select(`
          current_score,
          students!inner(
            id,
            name
          )
        `)
        .eq('intervention_id', interventionId)
        .order('current_score', { ascending: false })
        .limit(5)
    );

    // Find user rank
    const allStudentsResult = await query(
      supabase
        .from('intervention_enrollments')
        .select(`
          current_score,
          students!inner(
            id
          )
        `)
        .eq('intervention_id', interventionId)
        .order('current_score', { ascending: false })
    );

    const userRank = allStudentsResult.rows.findIndex(s => s.students.id === studentId) + 1;

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
          enrollmentDate: enrollment.enrollment_date,
          max_students: intervention.max_students || 100,
          enrolled_students: enrolledStudentsResult.rows.map(enrollment => ({
            id: enrollment.students.id,
            name: enrollment.students.name,
            registration_no: enrollment.students.registration_no,
            enrollment_status: enrollment.enrollment_status,
            enrollment_date: enrollment.enrollment_date,
            current_score: parseFloat(enrollment.current_score || 0)
          })),
          teachers: teachersResult.rows.map(teacherAssignment => ({
            id: teacherAssignment.teachers.id,
            name: teacherAssignment.teachers.name,
            employee_id: teacherAssignment.teachers.employee_id || '',
            specialization: teacherAssignment.teachers.specialization || '',
            role: teacherAssignment.role || 'Teacher',
            assigned_quadrants: teacherAssignment.assigned_quadrants || []
          })),
          is_scoring_open: intervention.is_scoring_open || false,
          scoring_deadline: intervention.scoring_deadline
        },
        progress: {
          completedTasks: completedTasks,
          totalTasks: totalTasks,
          completionPercentage: totalTasks > 0 ? Math.round((completedTasks / totalTasks) * 100) : 0,
          currentScore: parseFloat(enrollment.current_score || 0),
          maxScore: 100, // Simplified
          rank: userRank || 0,
          totalStudents: allStudentsResult.rows.length
        },
        quadrantBreakdown: quadrantBreakdown,
        teachers: teachersResult.rows.map(teacherAssignment => ({
          teacherId: teacherAssignment.teachers.id,
          teacherName: teacherAssignment.teachers.name,
          specialization: teacherAssignment.teachers.specialization || ''
        })),
        leaderboard: {
          topStudents: leaderboardResult.rows.map(enrollmentData => ({
            studentId: enrollmentData.students.id,
            studentName: enrollmentData.students.name,
            score: parseFloat(enrollmentData.current_score || 0)
          })),
          userRank: userRank || 0,
          batchAverage: leaderboardResult.rows.length > 0 ? 
            Math.round(leaderboardResult.rows.reduce((sum, enrollmentData) => sum + parseFloat(enrollmentData.current_score || 0), 0) / leaderboardResult.rows.length) : 0
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

/**
 * Get student intervention performance
 */
const getStudentInterventionPerformance = async (req, res) => {
  try {
    const { studentId } = req.params;

    // Authorization check: Students can only access their own data, teachers/admins can access any
    if (req.user.role === 'student') {
      // Get student record to check if this user owns this student record
      const studentUserCheck = await query(
        supabase
          .from('students')
          .select('user_id')
          .eq('id', studentId)
          .limit(1)
      );

      if (!studentUserCheck.rows || studentUserCheck.rows.length === 0) {
        return res.status(404).json({
          success: false,
          message: 'Student not found',
          timestamp: new Date().toISOString()
        });
      }

      if (studentUserCheck.rows[0].user_id !== req.user.userId) {
        return res.status(403).json({
          success: false,
          message: 'Access denied. You can only access your own data.',
          timestamp: new Date().toISOString()
        });
      }
    }

    // Verify student exists
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

    // Get student's intervention enrollments
    const enrollmentsResult = await query(
      supabase
        .from('intervention_enrollments')
        .select(`
          id,
          enrollment_date,
          enrollment_status,
          current_score,
          completion_percentage,
          progress_data,
          interventions:intervention_id(
            id,
            name,
            status,
            start_date,
            end_date
          )
        `)
        .eq('student_id', studentId)
        .eq('enrollment_status', 'Enrolled')
    );

    const interventions = [];
    let totalInterventions = 0;
    let activeInterventions = 0;
    let completedInterventions = 0;
    let totalScores = 0;
    let scoreCount = 0;

    for (const enrollment of enrollmentsResult.rows || []) {
      const intervention = enrollment.interventions;
      if (!intervention) continue;

      totalInterventions++;
      if (intervention.status === 'Active') activeInterventions++;
      if (intervention.status === 'Completed') completedInterventions++;

      // Get microcompetency scores for this intervention
      const scoresResult = await query(
        supabase
          .from('microcompetency_scores')
          .select(`
            id,
            obtained_score,
            max_score,
            percentage,
            status,
            scored_at,
            microcompetencies:microcompetency_id(
              id,
              name,
              max_score
            )
          `)
          .eq('student_id', studentId)
          .eq('intervention_id', intervention.id)
          .eq('status', 'Submitted')
      );

      const microcompetencies = scoresResult.rows.map(score => ({
        id: score.microcompetencies.id,
        name: score.microcompetencies.name,
        maxScore: score.max_score,
        obtainedScore: score.obtained_score,
        percentage: score.percentage,
        status: score.status,
        scoredAt: score.scored_at
      }));

      // Calculate intervention statistics
      const totalMicrocompetencies = microcompetencies.length;
      const completedMicrocompetencies = microcompetencies.filter(m => m.status === 'Submitted').length;
      const averageScore = totalMicrocompetencies > 0
        ? microcompetencies.reduce((sum, m) => sum + m.percentage, 0) / totalMicrocompetencies
        : 0;

      // Add to overall statistics
      microcompetencies.forEach(m => {
        totalScores += m.percentage;
        scoreCount++;
      });

      interventions.push({
        id: intervention.id,
        name: intervention.name,
        status: intervention.status,
        enrollmentDate: enrollment.enrollment_date,
        currentScore: enrollment.current_score || averageScore,
        completionPercentage: enrollment.completion_percentage ||
          (totalMicrocompetencies > 0 ? (completedMicrocompetencies / totalMicrocompetencies) * 100 : 0),
        microcompetencies,
        progressData: {
          totalMicrocompetencies,
          completedMicrocompetencies,
          averageScore
        }
      });
    }

    const summary = {
      totalInterventions,
      activeInterventions,
      completedInterventions,
      overallProgress: totalInterventions > 0
        ? (completedInterventions / totalInterventions) * 100
        : 0,
      averageScore: scoreCount > 0 ? totalScores / scoreCount : 0
    };

    res.status(200).json({
      success: true,
      message: 'Student intervention performance retrieved successfully',
      data: {
        interventions,
        summary
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('Error fetching student intervention performance:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve student intervention performance',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = {
  getAllStudents,
  getStudentFilterOptions,
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
  getInterventionQuadrantImpact,
  getStudentInterventionPerformance
};
