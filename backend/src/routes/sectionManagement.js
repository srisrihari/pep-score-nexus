const express = require('express');
const router = express.Router();
const { supabase, query } = require('../config/supabase');
const { authenticateToken, requireRole } = require('../middleware/auth');

// Apply authentication and admin role to all routes
router.use(authenticateToken);
router.use(requireRole('admin'));

/**
 * @route GET /api/v1/admin/section-management/sections
 * @desc Get all sections with pagination and filtering
 * @access Admin only
 */
router.get('/sections', async (req, res) => {
  try {
    const { page = 1, limit = 20, search = '', batch_id = '', sortBy = 'name', sortOrder = 'asc' } = req.query;
    const offset = (page - 1) * limit;

    let sectionQuery = supabase
      .from('sections')
      .select(`
        id,
        name,
        capacity,
        is_active,
        created_at,
        batches:batch_id(id, name, year),
        _count:students(count)
      `, { count: 'exact' });

    // Apply search filter
    if (search) {
      sectionQuery = sectionQuery.ilike('name', `%${search}%`);
    }

    // Apply batch filter
    if (batch_id) {
      sectionQuery = sectionQuery.eq('batch_id', batch_id);
    }

    // Apply sorting
    sectionQuery = sectionQuery.order(sortBy, { ascending: sortOrder === 'asc' });

    // Apply pagination
    sectionQuery = sectionQuery.range(offset, offset + limit - 1);

    const result = await query(sectionQuery);

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
    console.error('❌ Get sections error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to get sections',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

/**
 * @route POST /api/v1/admin/section-management/sections
 * @desc Create a new section
 * @access Admin only
 */
router.post('/sections', async (req, res) => {
  try {
    const {
      name,
      batch_id,
      capacity = 60
    } = req.body;

    // Validate required fields
    if (!name || !batch_id) {
      return res.status(400).json({
        success: false,
        error: 'Missing required fields',
        message: 'Name and batch_id are required',
        timestamp: new Date().toISOString()
      });
    }

    // Verify batch exists
    const batchExists = await query(
      supabase
        .from('batches')
        .select('id, name')
        .eq('id', batch_id)
        .eq('is_active', true)
        .limit(1)
    );

    if (batchExists.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'Batch not found',
        message: 'The specified batch does not exist or is inactive',
        timestamp: new Date().toISOString()
      });
    }

    // Check if section name already exists for the same batch
    const existingSection = await query(
      supabase
        .from('sections')
        .select('id')
        .eq('name', name)
        .eq('batch_id', batch_id)
        .limit(1)
    );

    if (existingSection.rows.length > 0) {
      return res.status(400).json({
        success: false,
        error: 'Section already exists',
        message: `A section named "${name}" already exists for this batch`,
        timestamp: new Date().toISOString()
      });
    }

    // Create the section
    const result = await query(
      supabase
        .from('sections')
        .insert({
          name,
          batch_id,
          capacity: parseInt(capacity),
          is_active: true
        })
        .select(`
          id,
          name,
          capacity,
          is_active,
          created_at,
          batches:batch_id(id, name, year)
        `)
        .single()
    );

    res.status(201).json({
      success: true,
      message: 'Section created successfully',
      data: result.rows,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Create section error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to create section',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

/**
 * @route PUT /api/v1/admin/section-management/sections/:id
 * @desc Update a section
 * @access Admin only
 */
router.put('/sections/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const {
      name,
      batch_id,
      capacity,
      is_active
    } = req.body;

    // Check if section exists
    const existingSection = await query(
      supabase
        .from('sections')
        .select('id, name, batch_id')
        .eq('id', id)
        .limit(1)
    );

    if (existingSection.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'Section not found',
        timestamp: new Date().toISOString()
      });
    }

    // If batch_id is being changed, verify the new batch exists
    if (batch_id && batch_id !== existingSection.rows[0].batch_id) {
      const batchExists = await query(
        supabase
          .from('batches')
          .select('id')
          .eq('id', batch_id)
          .eq('is_active', true)
          .limit(1)
      );

      if (batchExists.rows.length === 0) {
        return res.status(404).json({
          success: false,
          error: 'Batch not found',
          message: 'The specified batch does not exist or is inactive',
          timestamp: new Date().toISOString()
        });
      }
    }

    // If name is being changed, check for duplicates in the batch
    if (name && name !== existingSection.rows[0].name) {
      const targetBatchId = batch_id || existingSection.rows[0].batch_id;
      const duplicateCheck = await query(
        supabase
          .from('sections')
          .select('id')
          .eq('name', name)
          .eq('batch_id', targetBatchId)
          .neq('id', id)
          .limit(1)
      );

      if (duplicateCheck.rows.length > 0) {
        return res.status(400).json({
          success: false,
          error: 'Section name conflict',
          message: `A section named "${name}" already exists in this batch`,
          timestamp: new Date().toISOString()
        });
      }
    }

    // Update the section
    const updateData = {};
    if (name !== undefined) updateData.name = name;
    if (batch_id !== undefined) updateData.batch_id = batch_id;
    if (capacity !== undefined) updateData.capacity = parseInt(capacity);
    if (is_active !== undefined) updateData.is_active = is_active;

    const result = await query(
      supabase
        .from('sections')
        .update(updateData)
        .eq('id', id)
        .select(`
          id,
          name,
          capacity,
          is_active,
          created_at,
          batches:batch_id(id, name, year)
        `)
        .single()
    );

    res.json({
      success: true,
      message: 'Section updated successfully',
      data: result.rows,
      timestamp: new Date().toISOString()
    });

  } catch (error) {
    console.error('❌ Update section error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to update section',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

/**
 * @route DELETE /api/v1/admin/section-management/sections/:id
 * @desc Delete a section
 * @access Admin only
 */
router.delete('/sections/:id', async (req, res) => {
  try {
    const { id } = req.params;
    const { force = false } = req.query;

    // Check if section exists
    const existingSection = await query(
      supabase
        .from('sections')
        .select('id, name')
        .eq('id', id)
        .limit(1)
    );

    if (existingSection.rows.length === 0) {
      return res.status(404).json({
        success: false,
        error: 'Section not found',
        timestamp: new Date().toISOString()
      });
    }

    // Check if section has students
    const studentsInSection = await query(
      supabase
        .from('students')
        .select('id', { count: 'exact' })
        .eq('section_id', id)
        .neq('status', 'Dropped')
    );

    if (studentsInSection.totalCount > 0 && force !== 'true') {
      return res.status(400).json({
        success: false,
        error: 'Section has active students',
        message: `Cannot delete section with ${studentsInSection.totalCount} active students. Use force=true to proceed with soft delete.`,
        studentCount: studentsInSection.totalCount,
        timestamp: new Date().toISOString()
      });
    }

    if (force === 'true') {
      // Soft delete - mark as inactive
      await query(
        supabase
          .from('sections')
          .update({ is_active: false })
          .eq('id', id)
      );

      res.json({
        success: true,
        message: 'Section deactivated successfully (soft delete)',
        timestamp: new Date().toISOString()
      });
    } else {
      // Hard delete (only if no students)
      await query(
        supabase
          .from('sections')
          .delete()
          .eq('id', id)
      );

      res.json({
        success: true,
        message: 'Section deleted successfully',
        timestamp: new Date().toISOString()
      });
    }

  } catch (error) {
    console.error('❌ Delete section error:', error);
    res.status(500).json({
      success: false,
      error: 'Failed to delete section',
      message: error.message,
      timestamp: new Date().toISOString()
    });
  }
});

module.exports = router;





