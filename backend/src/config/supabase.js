const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

// Supabase configuration
// IMPORTANT: Never hardcode Supabase credentials. Use environment variables.
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing Supabase configuration. Please set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY (or SUPABASE_ANON_KEY) in your environment.');
}

// Connection pool and circuit breaker state
let connectionHealth = {
  failureCount: 0,
  lastFailure: null,
  circuitOpen: false
};

// Create Supabase client with enhanced configuration for stability
const supabase = (supabaseUrl && supabaseKey)
  ? createClient(supabaseUrl, supabaseKey, {
      auth: {
        persistSession: false,
        detectSessionInUrl: false
      },
      global: {
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Connection': 'keep-alive'
        }
      },
      db: {
        schema: 'public'
      }
    })
  : null;

// Helper function to add jitter to delays (prevents thundering herd)
const addJitter = (delay) => {
  const jitter = Math.random() * 0.3 * delay; // Up to 30% jitter
  return delay + jitter;
};

// Circuit breaker logic
const checkCircuitBreaker = () => {
  const now = Date.now();
  
  // Reset circuit if it's been 30 seconds since last failure
  if (connectionHealth.circuitOpen && connectionHealth.lastFailure && 
      now - connectionHealth.lastFailure > 30000) {
    connectionHealth.circuitOpen = false;
    connectionHealth.failureCount = 0;
    console.log('🔄 Circuit breaker reset - attempting connections again');
  }
  
  return connectionHealth.circuitOpen;
};

// Helper function to execute queries using Supabase REST API with enhanced retry logic
const query = async (queryObject, retries = 5) => {
  let lastError = null;
  
  // Check circuit breaker
  if (checkCircuitBreaker()) {
    throw new Error('Circuit breaker open - too many recent failures');
  }
  
  for (let attempt = 1; attempt <= retries; attempt++) {
    try {
      if (!supabase) {
        throw new Error('Supabase client is not initialized. Check SUPABASE_URL and keys.');
      }
      
      const { data, error, count } = await queryObject;
      
      if (error) {
        // Check if it's a connection error that might benefit from retry
        if (error.message && error.message.includes('fetch failed') && attempt < retries) {
          const delay = addJitter(Math.pow(2, attempt) * 250); // Increased base delay with jitter
          console.log(`🔄 Supabase query failed (attempt ${attempt}/${retries}), retrying in ${Math.round(delay)}ms...`);
          await new Promise(resolve => setTimeout(resolve, delay));
          lastError = error;
          continue;
        }
        
        // Record failure for circuit breaker
        connectionHealth.failureCount++;
        connectionHealth.lastFailure = Date.now();
        
        if (connectionHealth.failureCount >= 10) {
          connectionHealth.circuitOpen = true;
          console.log('🚫 Circuit breaker opened due to repeated failures');
        }
        
        console.error('❌ Supabase query error:', error);
        throw error;
      }

      // Reset failure count on success
      if (connectionHealth.failureCount > 0) {
        connectionHealth.failureCount = Math.max(0, connectionHealth.failureCount - 1);
      }

      // Mimic pg response format for compatibility
      return {
        rows: data || [],
        rowCount: data ? data.length : 0,
        totalCount: count
      };
    } catch (error) {
      lastError = error;
      
      // Check if it's a connection error that might benefit from retry
      if (error.message && error.message.includes('fetch failed') && attempt < retries) {
        const delay = addJitter(Math.pow(2, attempt) * 250); // Increased base delay with jitter
        console.log(`🔄 Supabase query exception (attempt ${attempt}/${retries}), retrying in ${Math.round(delay)}ms...`);
        await new Promise(resolve => setTimeout(resolve, delay));
        continue;
      }
      
      // Record failure for circuit breaker
      connectionHealth.failureCount++;
      connectionHealth.lastFailure = Date.now();
      
      if (connectionHealth.failureCount >= 10) {
        connectionHealth.circuitOpen = true;
        console.log('🚫 Circuit breaker opened due to repeated failures');
      }
      
      console.error('❌ Supabase query execution error:', error);
      throw error;
    }
  }
  
  // If we get here, all retries failed
  console.error('❌ Supabase query failed after all retries:', lastError);
  throw lastError;
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

// Connection health monitoring
const getConnectionHealth = () => {
  return {
    ...connectionHealth,
    status: connectionHealth.circuitOpen ? 'circuit_open' : 
            connectionHealth.failureCount > 5 ? 'degraded' : 'healthy'
  };
};

// Reset circuit breaker manually (for admin use)
const resetCircuitBreaker = () => {
  connectionHealth.failureCount = 0;
  connectionHealth.lastFailure = null;
  connectionHealth.circuitOpen = false;
  console.log('🔄 Circuit breaker manually reset');
};

module.exports = {
  supabase,
  query,
  rawQuery,
  testConnection,
  getConnectionHealth,
  resetCircuitBreaker
}; 