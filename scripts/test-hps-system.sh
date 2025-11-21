#!/bin/bash
# HPS System Testing Script
# Created after comprehensive HPS audit and fixes

echo "🔍 Testing HPS System After Comprehensive Fixes..."

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Test if backend is running
echo -e "${YELLOW}Step 1: Testing backend connectivity...${NC}"
HEALTH=$(wget -q -O- http://localhost:3001/health 2>/dev/null)
if [ $? -eq 0 ]; then
    echo -e "${GREEN}✅ Backend is running${NC}"
else
    echo -e "${RED}❌ Backend not responding - please start: cd backend && npm run dev${NC}"
    exit 1
fi

# Authenticate and get token
echo -e "${YELLOW}Step 2: Authenticating with admin credentials...${NC}"
TOKEN=$(wget -q -O- --post-data='{"username": "admin", "password": "password123"}' --header='Content-Type: application/json' http://localhost:3001/api/v1/auth/login 2>/dev/null | jq -r '.data.token' 2>/dev/null)

if [ "$TOKEN" = "null" ] || [ -z "$TOKEN" ]; then
    echo -e "${RED}❌ Authentication failed - check admin credentials${NC}"
    exit 1
else
    echo -e "${GREEN}✅ Authentication successful${NC}"
fi

# Get sample student and term IDs
echo -e "${YELLOW}Step 3: Getting sample data for testing...${NC}"
# These should be replaced with actual IDs from your database
STUDENT_ID="df8b0e2d-1234-4567-89ab-cdef01234567"
TERM_ID="8aacdbbe-9497-4382-8b29-b591d32fa6f1"

# Test HPS calculation
echo -e "${YELLOW}Step 4: Testing HPS calculation...${NC}"
CALC_RESULT=$(wget -q -O- --post-data="{\"termId\": \"$TERM_ID\"}" --header="Content-Type: application/json" --header="Authorization: Bearer $TOKEN" http://localhost:3001/api/v1/unified-scores/students/$STUDENT_ID/calculate 2>/dev/null)

if echo "$CALC_RESULT" | jq -e '.success' > /dev/null 2>&1; then
    echo -e "${GREEN}✅ HPS calculation successful${NC}"
    echo "$CALC_RESULT" | jq '.data'
else
    echo -e "${RED}❌ HPS calculation failed${NC}"
    echo "$CALC_RESULT"
fi

# Test score breakdown
echo -e "${YELLOW}Step 5: Testing score breakdown...${NC}"
BREAKDOWN_RESULT=$(wget -q -O- --header="Authorization: Bearer $TOKEN" "http://localhost:3001/api/v1/unified-scores/students/$STUDENT_ID/breakdown?termId=$TERM_ID" 2>/dev/null)

if echo "$BREAKDOWN_RESULT" | jq -e '.success' > /dev/null 2>&1; then
    echo -e "${GREEN}✅ Score breakdown retrieval successful${NC}"
    echo "$BREAKDOWN_RESULT" | jq '.data.breakdown'
else
    echo -e "${RED}❌ Score breakdown failed${NC}"
    echo "$BREAKDOWN_RESULT"
fi

echo -e "${GREEN}🎯 HPS System Testing Complete!${NC}"















