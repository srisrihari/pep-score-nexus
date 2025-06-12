const { query } = require('../config/database');

// Get all quadrants
const getAllQuadrants = async (req, res) => {
  try {
    const result = await query(`
      SELECT 
        id,
        name,
        description,
        weightage,
        minimum_attendance,
        business_rules,
        is_active,
        display_order,
        created_at
      FROM quadrants 
      WHERE is_active = true 
      ORDER BY display_order ASC
    `);

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
    
    const result = await query(`
      SELECT 
        q.id,
        q.name,
        q.description,
        q.weightage,
        q.minimum_attendance,
        q.business_rules,
        q.is_active,
        q.display_order,
        q.created_at,
        COALESCE(
          json_agg(
            json_build_object(
              'id', sc.id,
              'name', sc.name,
              'description', sc.description,
              'weightage', sc.weightage,
              'display_order', sc.display_order
            ) ORDER BY sc.display_order
          ) FILTER (WHERE sc.id IS NOT NULL), 
          '[]'
        ) as sub_categories
      FROM quadrants q
      LEFT JOIN sub_categories sc ON q.id = sc.quadrant_id AND sc.is_active = true
      WHERE q.id = $1 AND q.is_active = true
      GROUP BY q.id, q.name, q.description, q.weightage, q.minimum_attendance, 
               q.business_rules, q.is_active, q.display_order, q.created_at
    `, [id]);

    if (result.rows.length === 0) {
      return res.status(404).json({
        success: false,
        message: 'Quadrant not found',
        timestamp: new Date().toISOString()
      });
    }

    res.status(200).json({
      success: true,
      message: 'Quadrant retrieved successfully',
      data: result.rows[0],
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
    const result = await query(`
      SELECT 
        q.id,
        q.name,
        q.weightage,
        COUNT(DISTINCT sc.id) as sub_categories_count,
        COUNT(DISTINCT c.id) as components_count,
        COUNT(DISTINCT s.id) as scores_count,
        ROUND(AVG(s.percentage), 2) as average_score
      FROM quadrants q
      LEFT JOIN sub_categories sc ON q.id = sc.quadrant_id AND sc.is_active = true
      LEFT JOIN components c ON sc.id = c.sub_category_id AND c.is_active = true
      LEFT JOIN scores s ON c.id = s.component_id
      WHERE q.is_active = true
      GROUP BY q.id, q.name, q.weightage
      ORDER BY q.display_order ASC
    `);

    res.status(200).json({
      success: true,
      message: 'Quadrant statistics retrieved successfully',
      data: result.rows,
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

    const result = await query(`
      INSERT INTO quadrants (id, name, description, weightage, minimum_attendance, business_rules, display_order)
      VALUES ($1, $2, $3, $4, $5, $6, $7)
      RETURNING *
    `, [id, name, description, weightage, minimum_attendance || 0, JSON.stringify(business_rules || {}), display_order || 0]);

    res.status(201).json({
      success: true,
      message: 'Quadrant created successfully',
      data: result.rows[0],
      timestamp: new Date().toISOString()
    });
  } catch (error) {
    console.error('Error creating quadrant:', error);
    
    if (error.code === '23505') { // Unique violation
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
