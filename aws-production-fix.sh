#!/bin/bash

echo "🚀 PEP Score Nexus - AWS Production Fix Script"
echo "=============================================="

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
NC='\033[0m' # No Color

PROJECT_DIR="/home/ubuntu/pep-score-nexus"
BACKEND_DIR="$PROJECT_DIR/backend"

echo -e "${BLUE}📍 Working directory: $PROJECT_DIR${NC}"

# Check if we're running as ubuntu user
if [ "$USER" != "ubuntu" ]; then
    echo -e "${RED}❌ Please run this script as ubuntu user: sudo -u ubuntu $0${NC}"
    exit 1
fi

# Step 1: Fix File Permissions
echo -e "\n${YELLOW}🔧 Step 1: Fixing File Permissions${NC}"
echo "=================================="

cd "$PROJECT_DIR" || exit 1

# Create directories if they don't exist
mkdir -p "$BACKEND_DIR/uploads"
mkdir -p "$BACKEND_DIR/logs"

# Fix ownership
echo "Fixing ownership..."
sudo chown -R ubuntu:ubuntu "$BACKEND_DIR/uploads/"
sudo chown -R ubuntu:ubuntu "$BACKEND_DIR/logs/" 2>/dev/null || true

# Set permissions
echo "Setting permissions..."
find "$BACKEND_DIR/uploads" -type d -exec chmod 755 {} \;
find "$BACKEND_DIR/uploads" -type f -exec chmod 644 {} \; 2>/dev/null || true
chmod 755 "$BACKEND_DIR/"
chmod 755 "$BACKEND_DIR/uploads/"

# Test write permission
if touch "$BACKEND_DIR/uploads/permission-test.txt" 2>/dev/null; then
    echo -e "${GREEN}✅ Upload directory write test: PASSED${NC}"
    rm "$BACKEND_DIR/uploads/permission-test.txt"
else
    echo -e "${RED}❌ Upload directory write test: FAILED${NC}"
    ls -la "$BACKEND_DIR/" | grep uploads
fi

# Step 2: Check Environment Variables
echo -e "\n${YELLOW}🔧 Step 2: Checking Environment Variables${NC}"
echo "=========================================="

ENV_FILE="$BACKEND_DIR/.env"
if [ -f "$ENV_FILE" ]; then
    echo -e "${GREEN}✅ .env file exists${NC}"
    
    # Check critical variables (don't expose secrets)
    if grep -q "SUPABASE_URL=" "$ENV_FILE"; then
        echo -e "${GREEN}✅ SUPABASE_URL found${NC}"
    else
        echo -e "${RED}❌ SUPABASE_URL missing${NC}"
    fi
    
    if grep -q "SUPABASE_ANON_KEY=" "$ENV_FILE" || grep -q "SUPABASE_SERVICE_ROLE_KEY=" "$ENV_FILE"; then
        echo -e "${GREEN}✅ Supabase API key found${NC}"
    else
        echo -e "${RED}❌ Supabase API key missing${NC}"
    fi
else
    echo -e "${RED}❌ .env file not found at $ENV_FILE${NC}"
    echo "Creating sample .env file..."
    
    cat > "$ENV_FILE" << 'EOF'
# Production Environment Variables
SUPABASE_URL=https://hxxjdvecnhvqkgkscnmv.supabase.co
SUPABASE_ANON_KEY=your-anon-key-here
SUPABASE_SERVICE_ROLE_KEY=your-service-role-key-here

# Application Configuration
PORT=3001
NODE_ENV=production
JWT_SECRET=your-jwt-secret-here-make-it-long-and-random
JWT_EXPIRES_IN=7d

# Production URLs
FRONTEND_URL=https://uat.pep.vijaybhoomi.edu.in
CORS_ORIGIN=https://uat.pep.vijaybhoomi.edu.in
EOF
    
    echo -e "${YELLOW}⚠️  Please edit $ENV_FILE with your actual values${NC}"
fi

# Step 3: Network Connectivity Tests
echo -e "\n${YELLOW}🔧 Step 3: Testing Network Connectivity${NC}"
echo "========================================"

SUPABASE_HOST="hxxjdvecnhvqkgkscnmv.supabase.co"

# Test DNS resolution
echo "Testing DNS resolution..."
if nslookup "$SUPABASE_HOST" >/dev/null 2>&1; then
    echo -e "${GREEN}✅ DNS resolution: PASSED${NC}"
else
    echo -e "${RED}❌ DNS resolution: FAILED${NC}"
    echo "Trying alternative DNS servers..."
    echo "nameserver 8.8.8.8" | sudo tee /etc/resolv.conf.backup > /dev/null
    echo "nameserver 1.1.1.1" | sudo tee -a /etc/resolv.conf.backup > /dev/null
fi

# Test ping connectivity
echo "Testing ping connectivity..."
if ping -c 3 "$SUPABASE_HOST" >/dev/null 2>&1; then
    echo -e "${GREEN}✅ Ping connectivity: PASSED${NC}"
else
    echo -e "${RED}❌ Ping connectivity: FAILED${NC}"
fi

# Test HTTPS connectivity
echo "Testing HTTPS connectivity..."
if curl -I -s --connect-timeout 10 "https://$SUPABASE_HOST/rest/v1/" | head -1 | grep -q "HTTP"; then
    echo -e "${GREEN}✅ HTTPS connectivity: PASSED${NC}"
else
    echo -e "${RED}❌ HTTPS connectivity: FAILED${NC}"
    echo "Testing with verbose output..."
    curl -I -v --connect-timeout 10 "https://$SUPABASE_HOST/rest/v1/" 2>&1 | head -10
fi

# Step 4: Check AWS Security Groups
echo -e "\n${YELLOW}🔧 Step 4: Checking Outbound Connectivity${NC}"
echo "=========================================="

# Test outbound HTTPS on port 443
if timeout 10 bash -c "</dev/tcp/$SUPABASE_HOST/443"; then
    echo -e "${GREEN}✅ Port 443 (HTTPS) outbound: OPEN${NC}"
else
    echo -e "${RED}❌ Port 443 (HTTPS) outbound: BLOCKED${NC}"
    echo -e "${YELLOW}⚠️  Check AWS Security Groups - ensure outbound HTTPS (port 443) is allowed${NC}"
fi

# Step 5: PM2 Configuration
echo -e "\n${YELLOW}🔧 Step 5: Fixing PM2 Configuration${NC}"
echo "===================================="

# Create PM2 ecosystem file with proper user settings
cat > "$BACKEND_DIR/ecosystem.config.js" << 'EOF'
module.exports = {
  apps: [{
    name: 'pep-backend',
    script: 'src/server.js',
    cwd: '/home/ubuntu/pep-score-nexus/backend',
    user: 'ubuntu',
    uid: 'ubuntu',
    gid: 'ubuntu',
    env: {
      NODE_ENV: 'production',
      PORT: 3001
    },
    env_production: {
      NODE_ENV: 'production',
      PORT: 3001
    },
    instances: 1,
    autorestart: true,
    watch: false,
    max_memory_restart: '1G',
    error_file: '/home/ubuntu/pep-score-nexus/backend/logs/pm2-error.log',
    out_file: '/home/ubuntu/pep-score-nexus/backend/logs/pm2-out.log',
    log_file: '/home/ubuntu/pep-score-nexus/backend/logs/pm2-combined.log',
    time: true
  }]
};
EOF

echo -e "${GREEN}✅ PM2 ecosystem.config.js created${NC}"

# Step 6: Enhanced Node.js Configuration for AWS
echo -e "\n${YELLOW}🔧 Step 6: Creating AWS-Optimized Supabase Config${NC}"
echo "=================================================="

# Create an AWS-optimized version of the Supabase config
cat > "$BACKEND_DIR/src/config/supabase-aws.js" << 'EOF'
const { createClient } = require('@supabase/supabase-js');
const https = require('https');
require('dotenv').config();

// AWS-specific configuration for better connectivity
const supabaseUrl = process.env.SUPABASE_URL;
const supabaseKey = process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY;

if (!supabaseUrl || !supabaseKey) {
  console.error('❌ Missing Supabase configuration. Please set SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY (or SUPABASE_ANON_KEY) in your environment.');
}

// Custom HTTPS agent for AWS networking
const httpsAgent = new https.Agent({
  keepAlive: true,
  keepAliveMsecs: 30000,
  maxSockets: 50,
  timeout: 30000,
  freeSocketTimeout: 15000
});

// Connection health tracking
let connectionHealth = {
  failureCount: 0,
  lastFailure: null,
  circuitOpen: false
};

// Create Supabase client with AWS-optimized configuration
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
          'Connection': 'keep-alive',
          'User-Agent': 'PEP-Score-Nexus/1.0 (AWS)'
        },
        fetch: (url, options = {}) => {
          // Use custom timeout and agent for AWS
          return fetch(url, {
            ...options,
            timeout: 30000,
            agent: url.startsWith('https:') ? httpsAgent : undefined
          });
        }
      },
      db: {
        schema: 'public'
      }
    })
  : null;

// Add jitter to delays (prevents thundering herd)
const addJitter = (delay) => {
  const jitter = Math.random() * 0.3 * delay;
  return delay + jitter;
};

// Circuit breaker logic
const checkCircuitBreaker = () => {
  const now = Date.now();
  
  if (connectionHealth.circuitOpen && connectionHealth.lastFailure && 
      now - connectionHealth.lastFailure > 60000) { // Increased to 60 seconds for AWS
    connectionHealth.circuitOpen = false;
    connectionHealth.failureCount = 0;
    console.log('🔄 Circuit breaker reset - attempting connections again');
  }
  
  return connectionHealth.circuitOpen;
};

// Enhanced query function with AWS-specific optimizations
const query = async (queryObject, retries = 5) => {
  let lastError = null;
  
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
        if ((error.message && error.message.includes('fetch failed')) || 
            (error.code && error.code === 'ECONNRESET') ||
            (error.code && error.code === 'ETIMEDOUT')) {
          
          if (attempt < retries) {
            const delay = addJitter(Math.pow(2, attempt) * 500); // Increased base delay for AWS
            console.log(`🔄 Supabase query failed (attempt ${attempt}/${retries}), retrying in ${Math.round(delay)}ms...`);
            await new Promise(resolve => setTimeout(resolve, delay));
            lastError = error;
            continue;
          }
        }
        
        connectionHealth.failureCount++;
        connectionHealth.lastFailure = Date.now();
        
        if (connectionHealth.failureCount >= 5) { // Reduced threshold for AWS
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

      return {
        rows: data || [],
        rowCount: data ? data.length : 0,
        totalCount: count
      };
    } catch (error) {
      lastError = error;
      
      if ((error.message && error.message.includes('fetch failed')) ||
          (error.code && ['ECONNRESET', 'ETIMEDOUT', 'ENOTFOUND', 'ECONNREFUSED'].includes(error.code))) {
        
        if (attempt < retries) {
          const delay = addJitter(Math.pow(2, attempt) * 500);
          console.log(`🔄 Supabase query exception (attempt ${attempt}/${retries}), retrying in ${Math.round(delay)}ms...`);
          await new Promise(resolve => setTimeout(resolve, delay));
          continue;
        }
      }
      
      connectionHealth.failureCount++;
      connectionHealth.lastFailure = Date.now();
      
      if (connectionHealth.failureCount >= 5) {
        connectionHealth.circuitOpen = true;
        console.log('🚫 Circuit breaker opened due to repeated failures');
      }
      
      console.error('❌ Supabase query execution error:', error);
      throw error;
    }
  }
  
  console.error('❌ Supabase query failed after all retries:', lastError);
  throw lastError;
};

// Test connection with AWS-specific timeouts
const testConnection = async () => {
  try {
    if (!supabase) {
      console.error('❌ Supabase not configured. Skipping connection test.');
      return false;
    }

    const result = await query(
      supabase
        .from('quadrants')
        .select('id')
        .limit(1)
    );
    
    console.log('🎯 Supabase connection test successful:', {
      quadrants: result.rowCount,
      time: new Date().toISOString(),
      environment: 'AWS Production'
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
            connectionHealth.failureCount > 3 ? 'degraded' : 'healthy'
  };
};

// Reset circuit breaker manually
const resetCircuitBreaker = () => {
  connectionHealth.failureCount = 0;
  connectionHealth.lastFailure = null;
  connectionHealth.circuitOpen = false;
  console.log('🔄 Circuit breaker manually reset');
};

module.exports = {
  supabase,
  query,
  testConnection,
  getConnectionHealth,
  resetCircuitBreaker
};
EOF

echo -e "${GREEN}✅ AWS-optimized Supabase config created${NC}"

# Step 7: Restart Services
echo -e "\n${YELLOW}🔧 Step 7: Restarting Services${NC}"
echo "==============================="

cd "$BACKEND_DIR"

# Stop existing PM2 processes
pm2 stop all 2>/dev/null || true
pm2 delete all 2>/dev/null || true

# Start with new configuration
pm2 start ecosystem.config.js --env production

# Show PM2 status
pm2 status

echo -e "\n${GREEN}🎉 Production Fix Complete!${NC}"
echo "=========================="
echo -e "${BLUE}📊 Next Steps:${NC}"
echo "1. Check PM2 logs: pm2 logs pep-backend"
echo "2. Test API health: curl https://api.uat.pep.vijaybhoomi.edu.in/health"
echo "3. Test file upload in the web interface"
echo ""
echo -e "${YELLOW}📝 If issues persist:${NC}"
echo "1. Check AWS Security Groups for outbound HTTPS (port 443)"
echo "2. Verify environment variables in $ENV_FILE"
echo "3. Check nginx configuration for proper proxy settings"
echo ""
echo -e "${BLUE}🔧 Useful Commands:${NC}"
echo "pm2 restart pep-backend    # Restart the backend"
echo "pm2 logs pep-backend       # View logs"
echo "pm2 monit                  # Monitor resources"
EOF
