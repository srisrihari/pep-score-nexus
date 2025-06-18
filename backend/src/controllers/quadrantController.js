const { supabase, query } = require('../config/supabase');

// Get all quadrants
const getAllQuadrants = async (req, res) => {
  try {
    const result = await query(
      supabase
        .from('quadrants')
        .select(`
          id,
          name,
          description,
          weightage,
          minimum_attendance,
          business_rules,
          is_active,
          display_order,
          created_at
        `)
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    res.status(200).json({
      success: true,
      message: 'Quadrants retrieved successfully',
      data: result.rows,
      count: result.rows.length,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching quadrants:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve quadrants',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get quadrant by ID
const getQuadrantById = async (req, res) => {
  try {
    const { id } = req.params;

    // Get quadrant details
    const quadrantResult = await query(
      supabase.from('quadrants')
        .select('*')
        .eq('id', id)
        .eq('is_active', true)
    );

    if (!quadrantResult.rows || quadrantResult.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Quadrant not found',
        timestamp: new Date().toISOString()
      });
    }

    // Get sub-categories for this quadrant
    const subCategoriesResult = await query(
      supabase.from('sub_categories')
        .select('id, name, description, weightage, display_order')
        .eq('quadrant_id', id)
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    const quadrantData = {
      ...quadrantResult.rows[0],
      sub_categories: subCategoriesResult.rows || []
    };

    res.status(200).json({
      success: true,
      message: 'Quadrant retrieved successfully',
      data: quadrantData,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching quadrant:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve quadrant',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Get quadrant statistics
const getQuadrantStats = async (req, res) => {
  try {
    // Get basic quadrant info
    const quadrantsResult = await query(
      supabase.from('quadrants')
        .select('id, name, weightage, display_order')
        .eq('is_active', true)
        .order('display_order', { ascending: true })
    );

    // Simple statistics without complex nested queries
    const stats = quadrantsResult.rows.map(quadrant => ({
      id: quadrant.id,
      name: quadrant.name,
      weightage: quadrant.weightage,
      sub_categories_count: 0, // Will be calculated later if needed
      components_count: 0,     // Will be calculated later if needed
      scores_count: 0,         // Will be calculated later if needed
      average_score: 0         // Will be calculated later if needed
    }));

    res.status(200).json({
      success: true,
      message: 'Quadrant statistics retrieved successfully',
      data: stats,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error fetching quadrant statistics:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to retrieve quadrant statistics',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

// Create new quadrant (Admin only)
const createQuadrant = async (req, res) => {
  try {
    const { id, name, description, weightage, minimum_attendance, business_rules, display_order } = req.body;

    // Validation
    if (!id || !name || !weightage) {
      return res.status(400).json({
        success: false,
        message: 'Missing required fields: id, name, weightage',
        timestamp: new Date().toISOString()
      });
    }

    if (weightage <= 0 || weightage > 100) {
      return res.status(400).json({
        success: false,
        message: 'Weightage must be between 0 and 100',
        timestamp: new Date().toISOString()
      });
    }

    const quadrantData = {
      id,
      name,
      description,
      weightage,
      minimum_attendance: minimum_attendance || 0,
      business_rules: business_rules || {},
      display_order: display_order || 0
    };

    const result = await query(
      supabase.from('quadrants')
        .insert([quadrantData])
        .select()
        .single()
    );

    res.status(201).json({
      success: true,
      message: 'Quadrant created successfully',
      data: result.data,
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error creating quadrant:', error);

    if (error.code === '23505' || error.message?.includes('duplicate')) {
      return res.status(409).json({
        success: false,
        message: 'Quadrant with this ID already exists',
        timestamp: new Date().toISOString()
      });
    }

    res.status(500).json({
      success: false,
      message: 'Failed to create quadrant',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = {
  getAllQuadrants,
  getQuadrantById,
  getQuadrantStats,
  createQuadrant
};
