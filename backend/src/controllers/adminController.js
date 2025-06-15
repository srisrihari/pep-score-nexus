const { supabase, query } = require('../config/supabase');
const { validateStudentData, validateTeacherData } = require('../utils/validators');

// Get admin dashboard overview
const getDashboardOverview = async (req, res) => {
  try {
    // Get total counts
    const [
      studentsCount,
      teachersCount,
      activeInterventions,
      recentScores
    ] = await Promise.all([
      query(supabase.from('students').select('*', { count: 'exact' })),
      query(supabase.from('teachers').select('*', { count: 'exact' })),
      query(supabase.from('interventions').select('*', { count: 'exact' }).eq('status', 'active')),
      query(supabase.from('scores').select('*').order('created_at', { ascending: false }).limit(5))
    ]);

    // Get performance metrics
    const performanceMetrics = await query(
      supabase.from('quadrants')
        .select('name, avg_score')
        .order('avg_score', { ascending: false })
    );

    res.status(200).json({
      success: true,
      data: {
        counts: {
          totalStudents: studentsCount.totalCount || 0,
          totalTeachers: teachersCount.totalCount || 0,
          activeInterventions: activeInterventions.totalCount || 0
        },
        recentScores: recentScores.rows,
        performanceMetrics: performanceMetrics.rows,
        timestamp: new Date().toISOString()
      }
    });
  } catch (error) {
    console.error('❌ Dashboard overview error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch dashboard overview',
      message: error.message
    });
  }
};

// Get all students with pagination and filters
const getAllStudents = async (req, res) => {
  try {
    const {
      page = 1,
      limit = 10,
      batch,
      section,
      status,
      sortBy = 'created_at',
      sortOrder = 'desc'
    } = req.query;

    const offset = (page - 1) * limit;
    
    let query = supabase
      .from('students')
      .select(`
        *,
        user:users(email, username),
        batch:batches(name),
        section:sections(name)
      `, { count: 'exact' });

    // Apply filters
    if (batch) query = query.eq('batch_id', batch);
    if (section) query = query.eq('section_id', section);
    if (status) query = query.eq('status', status);

    // Apply sorting
    query = query.order(sortBy, { ascending: sortOrder === 'asc' });

    // Apply pagination
    query = query.range(offset, offset + limit - 1);

    const { data, error, count } = await query;

    if (error) throw error;

    // Log student IDs for testing
    console.log('Available student IDs:', data.map(s => s.id).join(', '));

    res.status(200).json({
      success: true,
      data: {
        students: data,
        pagination: {
          total: count,
          page: parseInt(page),
          limit: parseInt(limit),
          totalPages: Math.ceil(count / limit)
        }
      }
    });
  } catch (error) {
    console.error('❌ Get all students error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch students',
      message: error.message
    });
  }
};

// Search students
const searchStudents = async (req, res) => {
  try {
    const { query, limit = 10 } = req.query;

    if (!query) {
      return res.status(400).json({
        success: false,
        error: 'Search query is required'
      });
    }

    // First, let's check if there are any students at all
    const { data: allStudents, error: countError } = await supabase
      .from('students')
      .select('*', { count: 'exact' });

    if (countError) throw countError;

    console.log('Total students in database:', allStudents?.length || 0);

    // Now proceed with the search
    const { data, error } = await supabase
      .from('students')
      .select(`
        *,
        user:users(email, username),
        batch:batches(name),
        section:sections(name)
      `)
      .or(`name.ilike.%${query}%,registration_no.ilike.%${query}%,user.email.ilike.%${query}%`.replace(/,/g, '|'))
      .limit(parseInt(limit));

    if (error) throw error;

    res.status(200).json({
      success: true,
      data: {
        students: data,
        totalStudents: allStudents?.length || 0
      }
    });
  } catch (error) {
    console.error('❌ Search students error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to search students',
      message: error.message
    });
  }
};

// Get student details
const getStudentDetails = async (req, res) => {
  try {
    const { studentId } = req.params;

    const { data, error } = await supabase
      .from('students')
      .select(`
        *,
        user:users(*),
        batch:batches(*),
        section:sections(*),
        scores:scores(*),
        attendance:attendance(*)
      `)
      .eq('id', studentId)
      .single();

    if (error) throw error;
    if (!data) {
      return res.status(404).json({
        success: false,
        error: 'Student not found'
      });
    }

    res.status(200).json({
      success: true,
      data
    });
  } catch (error) {
    console.error('❌ Get student details error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch student details',
      message: error.message
    });
  }
};

// Add new student
const addStudent = async (req, res) => {
  try {
    const studentData = req.body;
    
    // Validate student data
    const validationError = validateStudentData(studentData);
    if (validationError) {
      return res.status(400).json({
        success: false,
        error: 'Validation error',
        details: validationError
      });
    }

    // Start a transaction
    const { data, error } = await supabase.rpc('create_student', {
      student_data: studentData
    });

    if (error) throw error;

    res.status(201).json({
      success: true,
      message: 'Student created successfully',
      data
    });
  } catch (error) {
    console.error('❌ Add student error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to create student',
      message: error.message
    });
  }
};

// Update student
const updateStudent = async (req, res) => {
  try {
    const { studentId } = req.params;
    const updateData = req.body;

    // Validate update data
    const validationError = validateStudentData(updateData, true);
    if (validationError) {
      return res.status(400).json({
        success: false,
        error: 'Validation error',
        details: validationError
      });
    }

    const { data, error } = await supabase
      .from('students')
      .update(updateData)
      .eq('id', studentId)
      .select()
      .single();

    if (error) throw error;
    if (!data) {
      return res.status(404).json({
        success: false,
        error: 'Student not found'
      });
    }

    res.status(200).json({
      success: true,
      message: 'Student updated successfully',
      data
    });
  } catch (error) {
    console.error('❌ Update student error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to update student',
      message: error.message
    });
  }
};

// Delete student
const deleteStudent = async (req, res) => {
  try {
    const { studentId } = req.params;

    // First check if student exists
    const { data: student, error: checkError } = await supabase
      .from('students')
      .select('id')
      .eq('id', studentId)
      .single();

    if (checkError) throw checkError;
    if (!student) {
      return res.status(404).json({
        success: false,
        error: 'Student not found'
      });
    }

    // Delete student (this will cascade delete related records)
    const { error } = await supabase
      .from('students')
      .delete()
      .eq('id', studentId);

    if (error) throw error;

    res.status(200).json({
      success: true,
      message: 'Student deleted successfully'
    });
  } catch (error) {
    console.error('❌ Delete student error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to delete student',
      message: error.message
    });
  }
};

// Get all teachers
const getAllTeachers = async (req, res) => {
  try {
    const {
      page = 1,
      limit = 10,
      status,
      sortBy = 'created_at',
      sortOrder = 'desc'
    } = req.query;

    const offset = (page - 1) * limit;
    
    // First, let's check if there are any teachers at all
    const { count: totalTeachers, error: countError } = await supabase
      .from('teachers')
      .select('*', { count: 'exact', head: true });

    if (countError) {
      console.error('❌ Error counting teachers:', countError);
      throw countError;
    }

    console.log('📊 Total teachers in database:', totalTeachers);
    
    let query = supabase
      .from('teachers')
      .select(`
        *,
        user:users(email, username)
      `, { count: 'exact' });

    // Apply filters
    if (status) query = query.eq('status', status);

    // Apply sorting
    query = query.order(sortBy, { ascending: sortOrder === 'asc' });

    // Apply pagination
    query = query.range(offset, offset + limit - 1);

    const { data, error, count } = await query;

    if (error) {
      console.error('❌ Get all teachers error:', error);
      throw error;
    }

    console.log('📝 Retrieved teachers:', data?.length || 0);

    res.status(200).json({
      success: true,
      data: {
        teachers: data,
        pagination: {
          total: count,
          page: parseInt(page),
          limit: parseInt(limit),
          totalPages: Math.ceil(count / limit)
        }
      }
    });
  } catch (error) {
    console.error('❌ Get all teachers error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to fetch teachers',
      message: error.message
    });
  }
};

// Add new teacher
const addTeacher = async (req, res) => {
  try {
    const teacherData = req.body;
    
    // Validate teacher data
    const validationError = validateTeacherData(teacherData);
    if (validationError) {
      return res.status(400).json({
        success: false,
        error: 'Validation error',
        details: validationError
      });
    }

    // Start a transaction
    const { data, error } = await supabase.rpc('create_teacher', {
      teacher_data: teacherData
    });

    if (error) throw error;

    res.status(201).json({
      success: true,
      message: 'Teacher created successfully',
      data
    });
  } catch (error) {
    console.error('❌ Add teacher error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to create teacher',
      message: error.message
    });
  }
};

// Update teacher
const updateTeacher = async (req, res) => {
  try {
    const { teacherId } = req.params;
    const updateData = req.body;

    // Validate update data
    const validationError = validateTeacherData(updateData, true);
    if (validationError) {
      return res.status(400).json({
        success: false,
        error: 'Validation error',
        details: validationError
      });
    }

    const { data, error } = await supabase
      .from('teachers')
      .update(updateData)
      .eq('id', teacherId)
      .select()
      .single();

    if (error) throw error;
    if (!data) {
      return res.status(404).json({
        success: false,
        error: 'Teacher not found'
      });
    }

    res.status(200).json({
      success: true,
      message: 'Teacher updated successfully',
      data
    });
  } catch (error) {
    console.error('❌ Update teacher error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to update teacher',
      message: error.message
    });
  }
};

module.exports = {
  getDashboardOverview,
  getAllStudents,
  searchStudents,
  getStudentDetails,
  addStudent,
  updateStudent,
  deleteStudent,
  getAllTeachers,
  addTeacher,
  updateTeacher
}; 