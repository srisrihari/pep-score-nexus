const { supabase } = require('../config/supabase');
const { query } = require('../utils/query');

// ==========================================
// ADMIN INTERVENTION MANAGEMENT ENDPOINTS
// ==========================================

// Create new intervention
const createIntervention = async (req, res) => {
  try {
    const {
      name,
      description,
      startDate,
      endDate,
      quadrantWeightages,
      prerequisites = [],
      maxStudents = 50,
      objectives = []
    } = req.body;

    // Validate required fields
    if (!name || !startDate || !endDate || !quadrantWeightages) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: name, startDate, endDate, quadrantWeightages',
        timestamp: new Date().toISOString()
      });
    }

    // Validate dates
    if (new Date(endDate) <= new Date(startDate)) {
      return res.status(400).json({
        success: false,
        message: 'End date must be after start date',
        timestamp: new Date().toISOString()
      });
    }

    // Create intervention
    const interventionResult = await query(
      supabase
        .from('interventions')
        .insert({
          name,
          description,
          start_date: startDate,
          end_date: endDate,
          status: 'Draft',
          quadrant_weightages: quadrantWeightages,
          prerequisites,
          max_students: maxStudents,
          objectives,
          created_by: req.user.userId
        })
        .select('*')
    );

    if (!interventionResult.rows || interventionResult.rows.length === 0) {
      throw new Error('Failed to create intervention');
    }

    const intervention = interventionResult.rows[0];

    // Create intervention_quadrants entries
    const quadrantEntries = Object.entries(quadrantWeightages).map(([quadrantId, weightage]) => ({
      intervention_id: intervention.id,
      quadrant_id: quadrantId,
      weightage: weightage,
      components: [] // Will be populated later when tasks are created
    }));

    if (quadrantEntries.length > 0) {
      await query(
        supabase
          .from('intervention_quadrants')
          .insert(quadrantEntries)
      );
    }

    res.status(201).json({
      success: true,
      message: 'Intervention created successfully',
      data: intervention,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error creating intervention:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create intervention',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get all interventions with filtering and pagination
const getAllInterventions = async (req, res) => {
  try {
    const {
      status,
      page = 1,
      limit = 10,
      search,
      sortBy = 'created_at',
      sortOrder = 'desc'
    } = req.query;

    let query_builder = supabase
      .from('interventions')
      .select(`
        *,
        created_by_user:users!interventions_created_by_fkey(username, email),
        intervention_quadrants(
          quadrant_id,
          weightage,
          quadrants(name)
        ),
        intervention_enrollments(count),
        intervention_teachers(count)
      `);

    // Apply filters
    if (status) {
      query_builder = query_builder.eq('status', status);
    }

    if (search) {
      query_builder = query_builder.or(`name.ilike.%${search}%,description.ilike.%${search}%`);
    }

    // Apply sorting
    query_builder = query_builder.order(sortBy, { ascending: sortOrder === 'asc' });

    // Apply pagination
    const offset = (page - 1) * limit;
    query_builder = query_builder.range(offset, offset + limit - 1);

    const result = await query(query_builder);

    // Get total count for pagination
    const countResult = await query(
      supabase
        .from('interventions')
        .select('*', { count: 'exact', head: true })
    );

    res.status(200).json({
      success: true,
      message: 'Interventions retrieved successfully',
      data: {
        interventions: result.rows || [],
        pagination: {
          page: parseInt(page),
          limit: parseInt(limit),
          total: countResult.count || 0,
          totalPages: Math.ceil((countResult.count || 0) / limit)
        }
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching interventions:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve interventions',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get intervention details by ID
const getInterventionById = async (req, res) => {
  try {
    const { id } = req.params;

    const result = await query(
      supabase
        .from('interventions')
        .select(`
          *,
          created_by_user:users!interventions_created_by_fkey(username, email),
          intervention_quadrants(
            id,
            quadrant_id,
            weightage,
            components,
            quadrants(name, description)
          ),
          intervention_teachers(
            id,
            teacher_id,
            assigned_quadrants,
            role,
            permissions,
            assigned_at,
            is_active,
            teachers(name, employee_id)
          ),
          intervention_enrollments(
            id,
            student_id,
            enrollment_date,
            enrollment_status,
            enrollment_type,
            current_score,
            completion_percentage,
            students(name, registration_no)
          ),
          tasks(
            id,
            name,
            description,
            quadrant_id,
            max_score,
            due_date,
            status,
            created_at
          )
        `)
        .eq('id', id)
        .single()
    );

    if (!result.rows || result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Intervention not found',
        timestamp: new Date().toISOString()
      });
    }

    res.status(200).json({
      success: true,
      message: 'Intervention details retrieved successfully',
      data: result.rows[0],
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching intervention details:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve intervention details',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Update intervention
const updateIntervention = async (req, res) => {
  try {
    const { id } = req.params;
    const {
      name,
      description,
      startDate,
      endDate,
      quadrantWeightages,
      prerequisites,
      maxStudents,
      objectives
    } = req.body;

    // Build update object
    const updateData = {};
    if (name !== undefined) updateData.name = name;
    if (description !== undefined) updateData.description = description;
    if (startDate !== undefined) updateData.start_date = startDate;
    if (endDate !== undefined) updateData.end_date = endDate;
    if (quadrantWeightages !== undefined) updateData.quadrant_weightages = quadrantWeightages;
    if (prerequisites !== undefined) updateData.prerequisites = prerequisites;
    if (maxStudents !== undefined) updateData.max_students = maxStudents;
    if (objectives !== undefined) updateData.objectives = objectives;

    // Validate dates if both are provided
    if (updateData.start_date && updateData.end_date) {
      if (new Date(updateData.end_date) <= new Date(updateData.start_date)) {
        return res.status(400).json({
          success: false,
          message: 'End date must be after start date',
          timestamp: new Date().toISOString()
        });
      }
    }

    const result = await query(
      supabase
        .from('interventions')
        .update(updateData)
        .eq('id', id)
        .select('*')
    );

    if (!result.rows || result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Intervention not found',
        timestamp: new Date().toISOString()
      });
    }

    // Update quadrant weightages if provided
    if (quadrantWeightages) {
      // Delete existing quadrant entries
      await query(
        supabase
          .from('intervention_quadrants')
          .delete()
          .eq('intervention_id', id)
      );

      // Insert new quadrant entries
      const quadrantEntries = Object.entries(quadrantWeightages).map(([quadrantId, weightage]) => ({
        intervention_id: id,
        quadrant_id: quadrantId,
        weightage: weightage,
        components: []
      }));

      if (quadrantEntries.length > 0) {
        await query(
          supabase
            .from('intervention_quadrants')
            .insert(quadrantEntries)
        );
      }
    }

    res.status(200).json({
      success: true,
      message: 'Intervention updated successfully',
      data: result.rows[0],
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error updating intervention:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update intervention',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Assign teachers to intervention
const assignTeachers = async (req, res) => {
  try {
    const { id } = req.params;
    const { teachers } = req.body;

    // Validate input
    if (!teachers || !Array.isArray(teachers) || teachers.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Teachers array is required and must not be empty',
        timestamp: new Date().toISOString()
      });
    }

    // Verify intervention exists
    const interventionResult = await query(
      supabase
        .from('interventions')
        .select('id, name')
        .eq('id', id)
        .single()
    );

    if (!interventionResult.rows || interventionResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Intervention not found',
        timestamp: new Date().toISOString()
      });
    }

    // Prepare teacher assignments
    const teacherAssignments = teachers.map(teacher => ({
      intervention_id: id,
      teacher_id: teacher.teacherId,
      assigned_quadrants: teacher.assignedQuadrants || [],
      role: teacher.role || 'Assistant',
      permissions: teacher.permissions || [],
      assigned_by: req.user.userId,
      is_active: true
    }));

    // Remove existing assignments for this intervention
    await query(
      supabase
        .from('intervention_teachers')
        .delete()
        .eq('intervention_id', id)
    );

    // Insert new assignments
    const result = await query(
      supabase
        .from('intervention_teachers')
        .insert(teacherAssignments)
        .select(`
          *,
          teachers(name, employee_id)
        `)
    );

    res.status(200).json({
      success: true,
      message: 'Teachers assigned successfully',
      data: {
        intervention_id: id,
        assigned_teachers: result.rows || []
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error assigning teachers:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to assign teachers',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Enroll students in intervention
const enrollStudents = async (req, res) => {
  try {
    const { id } = req.params;
    const { students, enrollmentType = 'Optional' } = req.body;

    // Validate input
    if (!students || !Array.isArray(students) || students.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Students array is required and must not be empty',
        timestamp: new Date().toISOString()
      });
    }

    // Verify intervention exists and get max students
    const interventionResult = await query(
      supabase
        .from('interventions')
        .select('id, name, max_students, status')
        .eq('id', id)
        .limit(1)
    );

    if (!interventionResult.rows || interventionResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Intervention not found',
        timestamp: new Date().toISOString()
      });
    }

    const intervention = interventionResult.rows[0];

    // Check if intervention is in valid status for enrollment
    if (intervention.status === 'Completed' || intervention.status === 'Archived') {
      return res.status(400).json({
        success: false,
        message: 'Cannot enroll students in completed or archived intervention',
        timestamp: new Date().toISOString()
      });
    }

    // Get current enrollment count
    const currentEnrollmentResult = await query(
      supabase
        .from('intervention_enrollments')
        .select('id', { count: 'exact' })
        .eq('intervention_id', id)
        .eq('enrollment_status', 'Enrolled')
    );

    const currentCount = currentEnrollmentResult.count || 0;

    // Check capacity
    if (currentCount + students.length > intervention.max_students) {
      return res.status(400).json({
        success: false,
        message: `Enrollment would exceed maximum capacity. Current: ${currentCount}, Max: ${intervention.max_students}`,
        timestamp: new Date().toISOString()
      });
    }

    // Prepare student enrollments
    const studentEnrollments = students.map(studentId => ({
      intervention_id: id,
      student_id: studentId,
      enrollment_date: new Date().toISOString().split('T')[0],
      enrollment_status: 'Enrolled',
      enrollment_type: enrollmentType,
      progress_data: {},
      current_score: 0.00,
      completion_percentage: 0.00,
      enrolled_by: req.user.userId
    }));

    // Insert enrollments (ignore conflicts for already enrolled students)
    const result = await query(
      supabase
        .from('intervention_enrollments')
        .upsert(studentEnrollments, {
          onConflict: 'intervention_id,student_id',
          ignoreDuplicates: false
        })
        .select(`
          *,
          students(name, registration_no)
        `)
    );

    res.status(200).json({
      success: true,
      message: 'Students enrolled successfully',
      data: {
        intervention_id: id,
        enrolled_students: result.rows || [],
        total_enrolled: (currentCount + (result.rows?.length || 0))
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error enrolling students:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to enroll students',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get intervention analytics
const getInterventionAnalytics = async (req, res) => {
  try {
    const { id } = req.params;

    // Verify intervention exists
    const interventionResult = await query(
      supabase
        .from('interventions')
        .select('id, name, status, start_date, end_date, max_students')
        .eq('id', id)
        .limit(1)
    );

    if (!interventionResult.rows || interventionResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Intervention not found',
        timestamp: new Date().toISOString()
      });
    }

    const intervention = interventionResult.rows[0];

    // Get enrollment statistics
    const enrollmentStats = await query(
      supabase
        .from('intervention_enrollments')
        .select('enrollment_status, current_score, completion_percentage')
        .eq('intervention_id', id)
    );

    // Get task statistics
    const taskStats = await query(
      supabase
        .from('tasks')
        .select('status, quadrant_id')
        .eq('intervention_id', id)
    );

    // Get submission statistics
    const submissionStats = await query(
      supabase
        .from('task_submissions')
        .select(`
          status,
          score,
          is_late,
          tasks!inner(intervention_id)
        `)
        .eq('tasks.intervention_id', id)
    );

    // Calculate analytics
    const enrollments = enrollmentStats.rows || [];
    const tasks = taskStats.rows || [];
    const submissions = submissionStats.rows || [];

    const analytics = {
      intervention: {
        id: intervention.id,
        name: intervention.name,
        status: intervention.status,
        duration_days: Math.ceil((new Date(intervention.end_date) - new Date(intervention.start_date)) / (1000 * 60 * 60 * 24))
      },
      enrollment: {
        total_enrolled: enrollments.length,
        max_capacity: intervention.max_students,
        capacity_utilization: ((enrollments.length / intervention.max_students) * 100).toFixed(2),
        by_status: enrollments.reduce((acc, enrollment) => {
          acc[enrollment.enrollment_status] = (acc[enrollment.enrollment_status] || 0) + 1;
          return acc;
        }, {}),
        average_completion: enrollments.length > 0
          ? (enrollments.reduce((sum, e) => sum + (e.completion_percentage || 0), 0) / enrollments.length).toFixed(2)
          : 0,
        average_score: enrollments.length > 0
          ? (enrollments.reduce((sum, e) => sum + (e.current_score || 0), 0) / enrollments.length).toFixed(2)
          : 0
      },
      tasks: {
        total_tasks: tasks.length,
        by_status: tasks.reduce((acc, task) => {
          acc[task.status] = (acc[task.status] || 0) + 1;
          return acc;
        }, {}),
        by_quadrant: tasks.reduce((acc, task) => {
          acc[task.quadrant_id] = (acc[task.quadrant_id] || 0) + 1;
          return acc;
        }, {})
      },
      submissions: {
        total_submissions: submissions.length,
        by_status: submissions.reduce((acc, submission) => {
          acc[submission.status] = (acc[submission.status] || 0) + 1;
          return acc;
        }, {}),
        late_submissions: submissions.filter(s => s.is_late).length,
        average_score: submissions.filter(s => s.score !== null).length > 0
          ? (submissions.filter(s => s.score !== null).reduce((sum, s) => sum + s.score, 0) / submissions.filter(s => s.score !== null).length).toFixed(2)
          : 0
      }
    };

    res.status(200).json({
      success: true,
      message: 'Intervention analytics retrieved successfully',
      data: analytics,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching intervention analytics:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve intervention analytics',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Update intervention status
const updateInterventionStatus = async (req, res) => {
  try {
    const { id } = req.params;
    const { status } = req.body;

    // Validate status
    const validStatuses = ['Draft', 'Active', 'Completed', 'Archived', 'Cancelled'];
    if (!status || !validStatuses.includes(status)) {
      return res.status(400).json({
        success: false,
        message: `Invalid status. Must be one of: ${validStatuses.join(', ')}`,
        timestamp: new Date().toISOString()
      });
    }

    // Update intervention status
    const result = await query(
      supabase
        .from('interventions')
        .update({ status })
        .eq('id', id)
        .select('*')
    );

    if (!result.rows || result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Intervention not found',
        timestamp: new Date().toISOString()
      });
    }

    // If status is being set to 'Completed', update enrollment statuses
    if (status === 'Completed') {
      await query(
        supabase
          .from('intervention_enrollments')
          .update({ enrollment_status: 'Completed' })
          .eq('intervention_id', id)
          .eq('enrollment_status', 'Enrolled')
      );
    }

    res.status(200).json({
      success: true,
      message: 'Intervention status updated successfully',
      data: result.rows[0],
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error updating intervention status:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to update intervention status',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Create task for intervention (Admin only)
const createTask = async (req, res) => {
  try {
    const { interventionId } = req.params;
    const {
      name,
      description,
      quadrantId,
      componentId,
      maxScore = 10,
      dueDate,
      instructions,
      rubric = [],
      submissionType = 'Document',
      allowLateSubmission = true,
      latePenalty = 0
    } = req.body;

    // Validate required fields
    if (!name || !quadrantId || !dueDate) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: name, quadrantId, dueDate',
        timestamp: new Date().toISOString()
      });
    }

    // If no componentId provided, get or create a component for the quadrant
    let finalComponentId = componentId;
    if (!finalComponentId) {
      // First, get sub-categories for this quadrant
      const subCategoryResult = await query(
        supabase
          .from('sub_categories')
          .select('id')
          .eq('quadrant_id', quadrantId)
          .eq('is_active', true)
          .limit(1)
      );

      let subCategoryId;
      if (!subCategoryResult.rows || subCategoryResult.rows.length === 0) {
        // Create a default sub-category for this quadrant
        const newSubCategoryResult = await query(
          supabase
            .from('sub_categories')
            .insert({
              quadrant_id: quadrantId,
              name: 'General Assessment',
              description: 'General assessment components for intervention tasks',
              weightage: 100.00,
              display_order: 1,
              is_active: true
            })
            .select('id')
        );
        subCategoryId = newSubCategoryResult.rows[0].id;
      } else {
        subCategoryId = subCategoryResult.rows[0].id;
      }

      // Now get or create a component
      const componentResult = await query(
        supabase
          .from('components')
          .select('id')
          .eq('sub_category_id', subCategoryId)
          .eq('is_active', true)
          .limit(1)
      );

      if (!componentResult.rows || componentResult.rows.length === 0) {
        // Create a default component
        const newComponentResult = await query(
          supabase
            .from('components')
            .insert({
              sub_category_id: subCategoryId,
              name: 'Intervention Task',
              description: 'Default component for intervention tasks',
              weightage: 100.00,
              max_score: 10.00,
              minimum_score: 0.00,
              category: 'Professional',
              display_order: 1,
              is_active: true
            })
            .select('id')
        );
        finalComponentId = newComponentResult.rows[0].id;
      } else {
        finalComponentId = componentResult.rows[0].id;
      }
    }

    // Verify intervention exists and is active
    const interventionResult = await query(
      supabase
        .from('interventions')
        .select('id, name, status')
        .eq('id', interventionId)
        .limit(1)
    );

    if (!interventionResult.rows || interventionResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Intervention not found',
        timestamp: new Date().toISOString()
      });
    }

    // Verify quadrant is part of this intervention
    const quadrantResult = await query(
      supabase
        .from('intervention_quadrants')
        .select('quadrant_id')
        .eq('intervention_id', interventionId)
        .eq('quadrant_id', quadrantId)
        .limit(1)
    );

    if (!quadrantResult.rows || quadrantResult.rows.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Quadrant not associated with this intervention',
        timestamp: new Date().toISOString()
      });
    }

    // Create task
    const taskResult = await query(
      supabase
        .from('tasks')
        .insert({
          intervention_id: interventionId,
          name,
          description,
          quadrant_id: quadrantId,
          component_id: finalComponentId,
          max_score: maxScore,
          due_date: dueDate,
          instructions,
          rubric,
          submission_type: submissionType,
          allow_late_submission: allowLateSubmission,
          late_penalty: latePenalty,
          status: 'Active',
          created_by: req.user.userId
        })
        .select(`
          *,
          quadrants!inner(name),
          components!inner(name)
        `)
    );

    res.status(201).json({
      success: true,
      message: 'Task created successfully',
      data: taskResult.rows[0],
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error creating task:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to create task',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// ==========================================
// TEACHER INTERVENTION ENDPOINTS
// ==========================================

// Get teacher's assigned interventions
const getTeacherInterventions = async (req, res) => {
  try {
    const { teacherId } = req.params;

    // Verify teacher exists
    const teacherResult = await query(
      supabase
        .from('teachers')
        .select('id, name, employee_id')
        .eq('id', teacherId)
        .limit(1)
    );

    if (!teacherResult.rows || teacherResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Teacher not found',
        timestamp: new Date().toISOString()
      });
    }

    // Get teacher's intervention assignments
    const interventionsResult = await query(
      supabase
        .from('intervention_teachers')
        .select(`
          id,
          assigned_quadrants,
          role,
          permissions,
          assigned_at,
          is_active,
          interventions!inner(
            id,
            name,
            description,
            start_date,
            end_date,
            status,
            max_students
          )
        `)
        .eq('teacher_id', teacherId)
        .eq('is_active', true)
        .eq('interventions.status', 'Active')
    );

    res.status(200).json({
      success: true,
      message: 'Teacher interventions retrieved successfully',
      data: {
        teacher: teacherResult.rows[0],
        interventions: interventionsResult.rows || []
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching teacher interventions:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve teacher interventions',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get specific intervention details for teacher
const getTeacherInterventionDetails = async (req, res) => {
  try {
    const { teacherId, interventionId } = req.params;

    // Verify teacher is assigned to this intervention
    const assignmentResult = await query(
      supabase
        .from('intervention_teachers')
        .select(`
          id,
          assigned_quadrants,
          role,
          permissions,
          interventions!inner(
            id,
            name,
            description,
            start_date,
            end_date,
            status,
            max_students,
            objectives
          )
        `)
        .eq('teacher_id', teacherId)
        .eq('intervention_id', interventionId)
        .eq('is_active', true)
        .limit(1)
    );

    if (!assignmentResult.rows || assignmentResult.rows.length === 0) {
      return res.status(403).json({
        success: false,
        message: 'Teacher not assigned to this intervention',
        timestamp: new Date().toISOString()
      });
    }

    const assignment = assignmentResult.rows[0];

    // Get tasks for teacher's assigned quadrants
    const tasksResult = await query(
      supabase
        .from('tasks')
        .select(`
          id,
          name,
          description,
          quadrant_id,
          max_score,
          due_date,
          instructions,
          submission_type,
          status,
          created_at,
          components!inner(name)
        `)
        .eq('intervention_id', interventionId)
        .in('quadrant_id', assignment.assigned_quadrants)
        .order('due_date', { ascending: true })
    );

    // Get enrollment count
    const enrollmentResult = await query(
      supabase
        .from('intervention_enrollments')
        .select('id', { count: 'exact' })
        .eq('intervention_id', interventionId)
        .eq('enrollment_status', 'Enrolled')
    );

    res.status(200).json({
      success: true,
      message: 'Intervention details retrieved successfully',
      data: {
        intervention: assignment.interventions,
        assignment: {
          role: assignment.role,
          assigned_quadrants: assignment.assigned_quadrants,
          permissions: assignment.permissions
        },
        tasks: tasksResult.rows || [],
        enrolled_students: enrollmentResult.count || 0
      },
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching teacher intervention details:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve intervention details',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get task submissions for teacher review
const getTeacherSubmissions = async (req, res) => {
  try {
    const { teacherId, interventionId } = req.params;
    const { taskId, status } = req.query;

    // Verify teacher is assigned to this intervention
    const assignmentResult = await query(
      supabase
        .from('intervention_teachers')
        .select('assigned_quadrants')
        .eq('teacher_id', teacherId)
        .eq('intervention_id', interventionId)
        .eq('is_active', true)
        .limit(1)
    );

    if (!assignmentResult.rows || assignmentResult.rows.length === 0) {
      return res.status(403).json({
        success: false,
        message: 'Teacher not assigned to this intervention',
        timestamp: new Date().toISOString()
      });
    }

    const assignedQuadrants = assignmentResult.rows[0].assigned_quadrants;

    // Build query for submissions
    let submissionsQuery = supabase
      .from('task_submissions')
      .select(`
        id,
        submitted_at,
        status,
        is_late,
        submission_text,
        score,
        feedback,
        graded_at,
        tasks!inner(
          id,
          name,
          quadrant_id,
          max_score,
          due_date
        ),
        students!inner(
          id,
          name,
          registration_no
        )
      `)
      .eq('tasks.intervention_id', interventionId)
      .in('tasks.quadrant_id', assignedQuadrants);

    // Apply filters
    if (taskId) {
      submissionsQuery = submissionsQuery.eq('task_id', taskId);
    }
    if (status) {
      submissionsQuery = submissionsQuery.eq('status', status);
    }

    submissionsQuery = submissionsQuery.order('submitted_at', { ascending: false });

    const submissionsResult = await query(submissionsQuery);

    res.status(200).json({
      success: true,
      message: 'Submissions retrieved successfully',
      data: submissionsResult.rows || [],
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching teacher submissions:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve submissions',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Grade a task submission
const gradeSubmission = async (req, res) => {
  try {
    const { teacherId, interventionId, submissionId } = req.params;
    const { score, feedback, privateNotes } = req.body;

    // Verify teacher is assigned to this intervention
    const assignmentResult = await query(
      supabase
        .from('intervention_teachers')
        .select('assigned_quadrants')
        .eq('teacher_id', teacherId)
        .eq('intervention_id', interventionId)
        .eq('is_active', true)
        .limit(1)
    );

    if (!assignmentResult.rows || assignmentResult.rows.length === 0) {
      return res.status(403).json({
        success: false,
        message: 'Teacher not assigned to this intervention',
        timestamp: new Date().toISOString()
      });
    }

    // Get submission details to verify teacher can grade it
    const submissionResult = await query(
      supabase
        .from('task_submissions')
        .select(`
          id,
          task_id,
          student_id,
          tasks!inner(
            quadrant_id,
            max_score
          )
        `)
        .eq('id', submissionId)
        .limit(1)
    );

    if (!submissionResult.rows || submissionResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Submission not found',
        timestamp: new Date().toISOString()
      });
    }

    const submission = submissionResult.rows[0];
    const assignedQuadrants = assignmentResult.rows[0].assigned_quadrants;

    // Check if teacher is assigned to this quadrant
    if (!assignedQuadrants.includes(submission.tasks.quadrant_id)) {
      return res.status(403).json({
        success: false,
        message: 'Teacher not authorized to grade this submission',
        timestamp: new Date().toISOString()
      });
    }

    // Validate score
    if (score !== undefined && (score < 0 || score > submission.tasks.max_score)) {
      return res.status(400).json({
        success: false,
        message: `Score must be between 0 and ${submission.tasks.max_score}`,
        timestamp: new Date().toISOString()
      });
    }

    // Update submission with grade
    const updateData = {
      status: 'Graded',
      graded_by: req.user.userId,
      graded_at: new Date().toISOString()
    };

    if (score !== undefined) updateData.score = score;
    if (feedback !== undefined) updateData.feedback = feedback;
    if (privateNotes !== undefined) updateData.private_notes = privateNotes;

    const result = await query(
      supabase
        .from('task_submissions')
        .update(updateData)
        .eq('id', submissionId)
        .select(`
          *,
          tasks!inner(name, max_score),
          students!inner(name, registration_no)
        `)
    );

    res.status(200).json({
      success: true,
      message: 'Submission graded successfully',
      data: result.rows[0],
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error grading submission:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to grade submission',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = {
  createIntervention,
  getAllInterventions,
  getInterventionById,
  updateIntervention,
  assignTeachers,
  enrollStudents,
  getInterventionAnalytics,
  updateInterventionStatus,
  createTask,
  getTeacherInterventions,
  getTeacherInterventionDetails,
  getTeacherSubmissions,
  gradeSubmission
};
