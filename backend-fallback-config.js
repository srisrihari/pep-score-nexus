// Fallback Supabase configuration for AWS networking issues
// Replace your existing src/config/supabase.js with this if the standard version fails

const { createClient } = require('@supabase/supabase-js');
const axios = require('axios'); // You might need: npm install axios
require('dotenv').config();

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;

// Custom fetch using axios for better AWS compatibility
const customFetch = async (url, options = {}) => {
  try {
    const axiosConfig = {
      method: options.method || 'GET',
      url: url,
      headers: options.headers || {},
      timeout: 30000,
      data: options.body,
      validateStatus: () => true // Don't throw on HTTP error codes
    };

    const response = await axios(axiosConfig);
    
    // Convert axios response to fetch-like response
    return {
      ok: response.status >= 200 && response.status < 300,
      status: response.status,
      statusText: response.statusText,
      headers: response.headers,
      json: async () => response.data,
      text: async () => typeof response.data === 'string' ? response.data : JSON.stringify(response.data)
    };
  } catch (error) {
    throw new Error(`Network request failed: ${error.message}`);
  }
};

// Create Supabase client with custom fetch
const supabase = createClient(supabaseUrl, supabaseKey, {
  auth: {
    persistSession: false,
    detectSessionInUrl: false
  },
  global: {
    headers: {
      'Accept': 'application/json',
      'Content-Type': 'application/json'
    },
    fetch: customFetch
  }
});

// Simple query wrapper with retry logic
const query = async (queryObject, retries = 3) => {
  for (let attempt = 1; attempt <= retries; attempt++) {
    try {
      const { data, error, count } = await queryObject;
      
      if (error) {
        if (attempt < retries) {
          console.log(`🔄 Query failed (attempt ${attempt}/${retries}), retrying...`);
          await new Promise(resolve => setTimeout(resolve, 1000 * attempt));
          continue;
        }
        throw error;
      }

      return {
        rows: data || [],
        rowCount: data ? data.length : 0,
        totalCount: count
      };
    } catch (error) {
      if (attempt < retries) {
        console.log(`🔄 Query exception (attempt ${attempt}/${retries}), retrying...`);
        await new Promise(resolve => setTimeout(resolve, 1000 * attempt));
        continue;
      }
      throw error;
    }
  }
};

const testConnection = async () => {
  try {
    const result = await query(
      supabase.from('quadrants').select('id').limit(1)
    );
    console.log('🎯 Connection test successful');
    return true;
  } catch (error) {
    console.error('❌ Connection test failed:', error.message);
    return false;
  }
};

module.exports = {
  supabase,
  query,
  testConnection,
  getConnectionHealth: () => ({ status: 'unknown' }),
  resetCircuitBreaker: () => console.log('Circuit breaker reset')
};
