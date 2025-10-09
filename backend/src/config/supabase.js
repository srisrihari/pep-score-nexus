const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

// Supabase configuration
// IMPORTANT: Never hardcode Supabase credentials. Use environment variables.
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing Supabase configuration. Please set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY (or SUPABASE_ANON_KEY) in your environment.');
}

// Create Supabase client (will throw if undefined)
const supabase = (supabaseUrl && supabaseKey)
  ? createClient(supabaseUrl, supabaseKey)
  : null;

// Helper function to execute queries using Supabase REST API
const query = async (queryObject) => {
  try {
    if (!supabase) {
      throw new Error('Supabase client is not initialized. Check SUPABASE_URL and keys.');
    }
    const { data, error, count } = await queryObject;
    
    if (error) {
      console.error('❌ Supabase query error:', error);
      throw error;
    }

    // Mimic pg response format for compatibility
    return {
      rows: data || [],
      rowCount: data ? data.length : 0,
      totalCount: count
    };
  } catch (error) {
    console.error('❌ Supabase query execution error:', error);
    throw error;
  }
};

// Helper function for raw SQL queries (when needed)
const rawQuery = async (sql, params = []) => {
  try {
    // For complex queries, we'll use Supabase RPC functions
    // This is a placeholder - you can implement custom RPC functions in Supabase
    console.warn('⚠️  Raw SQL queries not directly supported via REST API');
    console.log('SQL:', sql, 'Params:', params);
    throw new Error('Raw SQL queries require RPC functions in Supabase');
  } catch (error) {
    console.error('❌ Raw query error:', error);
    throw error;
  }
};

// Test Supabase connection
const testConnection = async () => {
  try {
    if (!supabase) {
      console.error('❌ Supabase not configured. Skipping connection test.');
      return false;
    }

    // simple ping by selecting minimal row
    const result = await query(
      supabase
        .from('quadrants')
        .select('id')
        .limit(1)
    );
    
    console.log('🎯 Supabase connection test successful:', {
      quadrants: result.rowCount,
      time: new Date().toISOString()
    });
    return true;
  } catch (error) {
    console.error('❌ Supabase connection test failed:', error.message);
    return false;
  }
};

module.exports = {
  supabase,
  query,
  rawQuery,
  testConnection
}; 