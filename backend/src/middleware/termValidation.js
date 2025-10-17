/**
 * Middleware to validate and handle term ID requirements
 */
const { supabase, query } = require('../config/supabase');

const validateTermId = async (req, res, next) => {
  try {
    // Check if termId is provided in query params
    let termId = req.query.termId;

    // If no termId provided, try to get current term
    if (!termId) {
      const currentTermResult = await query(
        supabase
          .from('terms')
          .select('id')
          .eq('is_current', true)
          .limit(1)
      );

      if (!currentTermResult.rows || currentTermResult.rows.length === 0) {
        return res.status(400).json({
          success: false,
          message: 'No current term is set. Please specify a termId parameter.',
          timestamp: new Date().toISOString()
        });
      }

      // Add current term ID to query params
      req.query.termId = currentTermResult.rows[0].id;
    }

    // Validate that the term exists
    const termResult = await query(
      supabase
        .from('terms')
        .select('id, name, is_active')
        .eq('id', req.query.termId)
        .limit(1)
    );

    if (!termResult.rows || termResult.rows.length === 0) {
      return res.status(400).json({
        success: false,
        message: 'Invalid term ID provided.',
        timestamp: new Date().toISOString()
      });
    }

    // Add term info to request for use in controllers
    req.term = termResult.rows[0];
    next();
  } catch (error) {
    console.error('❌ Term validation error:', error);
    res.status(500).json({
      success: false,
      message: 'Failed to validate term',
      error: error.message,
      timestamp: new Date().toISOString()
    });
  }
};

module.exports = { validateTermId };
