const express = require('express');
const router = express.Router();
const { supabase, query } = require('../config/supabase');
const { authenticateToken, requireRole } = require('../middleware/auth');

// Apply authentication and admin role to all routes
router.use(authenticateToken);
router.use(requireRole('admin'));

/**
 * @route GET /api/v1/admin/course-management/courses
 * @desc Get all courses with pagination and filtering
 * @access Admin only
 */
router.get('/courses', async (req, res) => {
  try {
    const { page = 1, limit = 20, search = '', sortBy = 'name', sortOrder = 'asc' } = req.query;
    const offset = (page - 1) * limit;

    let courseQuery = supabase
      .from('courses')
      .select(`
        id,
        name,
        code,
        description,
        duration_years,
        total_terms,
        is_active,
        created_at,
        updated_at,
        _count:batches(count)
      `, { count: 'exact' });

    // Apply search filter
    if (search) {
      courseQuery = courseQuery.or(`name.ilike.%${search}%,code.ilike.%${search}%`);
    }

    // Apply sorting
    courseQuery = courseQuery.order(sortBy, { ascending: sortOrder === 'asc' });

    // Apply pagination
    courseQuery = courseQuery.range(offset, offset + limit - 1);

    const result = await query(courseQuery);

    res.json({
      success: true,
      data: result.rows,
      pagination: {
        page: parseInt(page),
        limit: parseInt(limit),
        total: result.totalCount,
        pages: Math.ceil(result.totalCount / limit)
      },
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Get courses error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to get courses',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

/**
 * @route POST /api/v1/admin/course-management/courses
 * @desc Create a new course
 * @access Admin only
 */
router.post('/courses', async (req, res) => {
  try {
    const {
      name,
      code,
      description,
      duration_years = 4,
      total_terms = 8
    } = req.body;

    // Validate required fields
    if (!name) {
      return res.status(400).json({
        success: false,
        error: 'Missing required fields',
        message: 'Name is required',
        timestamp: new Date().toISOString()
      });
    }

    // Check if course name already exists
    const existingByName = await query(
      supabase
        .from('courses')
        .select('id')
        .eq('name', name)
        .limit(1)
    );

    if (existingByName.rows.length > 0) {
      return res.status(400).json({
        success: false,
        error: 'Course already exists',
        message: `A course named "${name}" already exists`,
        timestamp: new Date().toISOString()
      });
    }

    // Check if course code already exists (if provided)
    if (code) {
      const existingByCode = await query(
        supabase
          .from('courses')
          .select('id')
          .eq('code', code)
          .limit(1)
      );

      if (existingByCode.rows.length > 0) {
        return res.status(400).json({
          success: false,
          error: 'Course code already exists',
          message: `A course with code "${code}" already exists`,
          timestamp: new Date().toISOString()
        });
      }
    }

    // Create the course
    const result = await query(
      supabase
        .from('courses')
        .insert({
          name,
          code: code || null,
          description: description || null,
          duration_years: parseInt(duration_years),
          total_terms: parseInt(total_terms),
          is_active: true
        })
        .select(`
          id,
          name,
          code,
          description,
          duration_years,
          total_terms,
          is_active,
          created_at
        `)
        .single()
    );

    res.status(201).json({
      success: true,
      message: 'Course created successfully',
      data: result.rows,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Create course error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to create course',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

/**
 * @route PUT /api/v1/admin/course-management/courses/:id
 * @desc Update a course
 * @access Admin only
 */
router.put('/courses/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const {
      name,
      code,
      description,
      duration_years,
      total_terms,
      is_active
    } = req.body;

    // Check if course exists
    const existingCourse = await query(
      supabase
        .from('courses')
        .select('id, name, code')
        .eq('id', id)
        .limit(1)
    );

    if (existingCourse.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'Course not found',
        timestamp: new Date().toISOString()
      });
    }

    // If name is being changed, check for duplicates
    if (name && name !== existingCourse.rows[0].name) {
      const duplicateCheck = await query(
        supabase
          .from('courses')
          .select('id')
          .eq('name', name)
          .neq('id', id)
          .limit(1)
      );

      if (duplicateCheck.rows.length > 0) {
        return res.status(400).json({
          success: false,
          error: 'Course name conflict',
          message: `A course named "${name}" already exists`,
          timestamp: new Date().toISOString()
        });
      }
    }

    // If code is being changed, check for duplicates
    if (code && code !== existingCourse.rows[0].code) {
      const duplicateCheck = await query(
        supabase
          .from('courses')
          .select('id')
          .eq('code', code)
          .neq('id', id)
          .limit(1)
      );

      if (duplicateCheck.rows.length > 0) {
        return res.status(400).json({
          success: false,
          error: 'Course code conflict',
          message: `A course with code "${code}" already exists`,
          timestamp: new Date().toISOString()
        });
      }
    }

    // Update the course
    const updateData = {};
    if (name !== undefined) updateData.name = name;
    if (code !== undefined) updateData.code = code || null;
    if (description !== undefined) updateData.description = description || null;
    if (duration_years !== undefined) updateData.duration_years = parseInt(duration_years);
    if (total_terms !== undefined) updateData.total_terms = parseInt(total_terms);
    if (is_active !== undefined) updateData.is_active = is_active;

    const result = await query(
      supabase
        .from('courses')
        .update(updateData)
        .eq('id', id)
        .select(`
          id,
          name,
          code,
          description,
          duration_years,
          total_terms,
          is_active,
          updated_at
        `)
        .single()
    );

    res.json({
      success: true,
      message: 'Course updated successfully',
      data: result.rows,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Update course error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to update course',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

/**
 * @route DELETE /api/v1/admin/course-management/courses/:id
 * @desc Delete a course
 * @access Admin only
 */
router.delete('/courses/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { force = false } = req.query;

    // Check if course exists
    const existingCourse = await query(
      supabase
        .from('courses')
        .select('id, name')
        .eq('id', id)
        .limit(1)
    );

    if (existingCourse.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'Course not found',
        timestamp: new Date().toISOString()
      });
    }

    // Check if course has batches
    const batchesInCourse = await query(
      supabase
        .from('batches')
        .select('id', { count: 'exact' })
        .eq('course_id', id)
        .eq('is_active', true)
    );

    // Check if course has students
    const studentsInCourse = await query(
      supabase
        .from('students')
        .select('id', { count: 'exact' })
        .eq('course_id', id)
        .neq('status', 'Dropped')
    );

    const totalDependents = batchesInCourse.totalCount + studentsInCourse.totalCount;

    if (totalDependents > 0 && force !== 'true') {
      return res.status(400).json({
        success: false,
        error: 'Course has dependencies',
        message: `Cannot delete course with ${batchesInCourse.totalCount} active batches and ${studentsInCourse.totalCount} active students. Use force=true to proceed with soft delete.`,
        batchCount: batchesInCourse.totalCount,
        studentCount: studentsInCourse.totalCount,
        timestamp: new Date().toISOString()
      });
    }

    if (force === 'true') {
      // Soft delete - mark as inactive
      await query(
        supabase
          .from('courses')
          .update({ is_active: false })
          .eq('id', id)
      );

      res.json({
        success: true,
        message: 'Course deactivated successfully (soft delete)',
        timestamp: new Date().toISOString()
      });
    } else {
      // Hard delete (only if no dependencies)
      await query(
        supabase
          .from('courses')
          .delete()
          .eq('id', id)
      );

      res.json({
        success: true,
        message: 'Course deleted successfully',
        timestamp: new Date().toISOString()
      });
    }

  } catch (error) {
    console.error('❌ Delete course error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to delete course',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

module.exports = router;


