const express = require('express');
const router = express.Router();
const { supabase, query } = require('../config/supabase');
const { authenticateToken, requireRole } = require('../middleware/auth');

// Apply authentication and admin role to all routes
router.use(authenticateToken);
router.use(requireRole('admin'));

/**
 * @route GET /api/v1/admin/batch-management/batches
 * @desc Get all batches with pagination and filtering
 * @access Admin only
 */
router.get('/batches', async (req, res) => {
  try {
    const { page = 1, limit = 20, search = '', sortBy = 'created_at', sortOrder = 'desc' } = req.query;
    const offset = (page - 1) * limit;

    let batchQuery = supabase
      .from('batches')
      .select(`
        id,
        name,
        year,
        start_date,
        end_date,
        is_active,
        current_term_number,
        max_terms,
        batch_status,
        capacity,
        created_at,
        updated_at,
        courses:course_id(id, name, code),
        _count:students(count)
      `, { count: 'exact' });

    // Apply search filter
    if (search) {
      batchQuery = batchQuery.or(`name.ilike.%${search}%,year.eq.${parseInt(search) || 0}`);
    }

    // Apply sorting
    batchQuery = batchQuery.order(sortBy, { ascending: sortOrder === 'asc' });

    // Apply pagination
    batchQuery = batchQuery.range(offset, offset + limit - 1);

    const result = await query(batchQuery);

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
    console.error('❌ Get batches error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to get batches',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

/**
 * @route POST /api/v1/admin/batch-management/batches
 * @desc Create a new batch
 * @access Admin only
 */
router.post('/batches', async (req, res) => {
  try {
    const {
      name,
      course_id,
      year,
      start_date,
      end_date,
      max_terms = 4,
      capacity = 60
    } = req.body;

    // Validate required fields
    if (!name || !course_id || !year || !start_date || !end_date) {
      return res.status(400).json({
        success: false,
        error: 'Missing required fields',
        message: 'Name, course_id, year, start_date, and end_date are required',
        timestamp: new Date().toISOString()
      });
    }

    // Check if batch name already exists for the same year
    const existingBatch = await query(
      supabase
        .from('batches')
        .select('id')
        .eq('name', name)
        .eq('year', year)
        .limit(1)
    );

    if (existingBatch.rows.length > 0) {
      return res.status(400).json({
        success: false,
        error: 'Batch already exists',
        message: `A batch named "${name}" already exists for year ${year}`,
        timestamp: new Date().toISOString()
      });
    }

    // Create the batch
    const result = await query(
      supabase
        .from('batches')
        .insert({
          name,
          course_id,
          year: parseInt(year),
          start_date,
          end_date,
          max_terms: parseInt(max_terms),
          capacity: parseInt(capacity),
          is_active: true,
          current_term_number: 1,
          batch_status: 'active'
        })
        .select(`
          id,
          name,
          year,
          start_date,
          end_date,
          is_active,
          current_term_number,
          max_terms,
          batch_status,
          capacity,
          created_at,
          courses:course_id(id, name, code)
        `)
        .single()
    );

    res.status(201).json({
      success: true,
      message: 'Batch created successfully',
      data: result.rows,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Create batch error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to create batch',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

/**
 * @route PUT /api/v1/admin/batch-management/batches/:id
 * @desc Update a batch
 * @access Admin only
 */
router.put('/batches/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const {
      name,
      course_id,
      year,
      start_date,
      end_date,
      max_terms,
      capacity,
      is_active,
      batch_status
    } = req.body;

    // Check if batch exists
    const existingBatch = await query(
      supabase
        .from('batches')
        .select('id, name, year')
        .eq('id', id)
        .limit(1)
    );

    if (existingBatch.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'Batch not found',
        timestamp: new Date().toISOString()
      });
    }

    // If name or year is being changed, check for duplicates
    if (name && year) {
      const duplicateCheck = await query(
        supabase
          .from('batches')
          .select('id')
          .eq('name', name)
          .eq('year', year)
          .neq('id', id)
          .limit(1)
      );

      if (duplicateCheck.rows.length > 0) {
        return res.status(400).json({
          success: false,
          error: 'Batch name conflict',
          message: `A batch named "${name}" already exists for year ${year}`,
          timestamp: new Date().toISOString()
        });
      }
    }

    // Update the batch
    const updateData = {};
    if (name !== undefined) updateData.name = name;
    if (course_id !== undefined) updateData.course_id = course_id;
    if (year !== undefined) updateData.year = parseInt(year);
    if (start_date !== undefined) updateData.start_date = start_date;
    if (end_date !== undefined) updateData.end_date = end_date;
    if (max_terms !== undefined) updateData.max_terms = parseInt(max_terms);
    if (capacity !== undefined) updateData.capacity = parseInt(capacity);
    if (is_active !== undefined) updateData.is_active = is_active;
    if (batch_status !== undefined) updateData.batch_status = batch_status;

    const result = await query(
      supabase
        .from('batches')
        .update(updateData)
        .eq('id', id)
        .select(`
          id,
          name,
          year,
          start_date,
          end_date,
          is_active,
          current_term_number,
          max_terms,
          batch_status,
          capacity,
          updated_at,
          courses:course_id(id, name, code)
        `)
        .single()
    );

    res.json({
      success: true,
      message: 'Batch updated successfully',
      data: result.rows,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Update batch error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to update batch',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

/**
 * @route DELETE /api/v1/admin/batch-management/batches/:id
 * @desc Delete a batch (soft delete - mark as inactive)
 * @access Admin only
 */
router.delete('/batches/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { force = false } = req.query;

    // Check if batch exists
    const existingBatch = await query(
      supabase
        .from('batches')
        .select('id, name')
        .eq('id', id)
        .limit(1)
    );

    if (existingBatch.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'Batch not found',
        timestamp: new Date().toISOString()
      });
    }

    // Check if batch has students
    const studentsInBatch = await query(
      supabase
        .from('students')
        .select('id', { count: 'exact' })
        .eq('batch_id', id)
        .neq('status', 'Dropped')
    );

    if (studentsInBatch.totalCount > 0 && force !== 'true') {
      return res.status(400).json({
        success: false,
        error: 'Batch has active students',
        message: `Cannot delete batch with ${studentsInBatch.totalCount} active students. Use force=true to proceed with soft delete.`,
        studentCount: studentsInBatch.totalCount,
        timestamp: new Date().toISOString()
      });
    }

    if (force === 'true') {
      // Soft delete - mark as inactive
      await query(
        supabase
          .from('batches')
          .update({ 
            is_active: false, 
            batch_status: 'archived',
            updated_at: new Date().toISOString()
          })
          .eq('id', id)
      );

      res.json({
        success: true,
        message: 'Batch archived successfully (soft delete)',
        timestamp: new Date().toISOString()
      });
    } else {
      // Hard delete (only if no students)
      await query(
        supabase
          .from('batches')
          .delete()
          .eq('id', id)
      );

      res.json({
        success: true,
        message: 'Batch deleted successfully',
        timestamp: new Date().toISOString()
      });
    }

  } catch (error) {
    console.error('❌ Delete batch error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to delete batch',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

module.exports = router;

