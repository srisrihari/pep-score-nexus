#!/usr/bin/env node

/**
 * Test HPS API Script
 *
 * This script tests the HPS calculation API endpoints
 */

const axios = require('axios');
require('dotenv').config();

const baseURL = process.env.VITE_API_BASE_URL || 'http://localhost:3001';
const apiBase = `${baseURL}/api/v1`;

async function testHPSAPI() {
  try {
    console.log('🚀 Testing HPS API endpoints...');

    // Get current term
    const { data: currentTerm, error: termError } = await axios.get(`${apiBase}/terms/current`);
    if (termError || !currentTerm.success) {
      throw new Error(`Failed to get current term: ${termError?.message || 'No current term'}`);
    }

    const termId = currentTerm.data.id;
    console.log(`📅 Current term: ${currentTerm.data.name} (${termId})`);

    // Get students
    const { data: studentsResponse, error: studentsError } = await axios.get(`${apiBase}/students?limit=3`);
    if (studentsError || !studentsResponse.success) {
      throw new Error(`Failed to get students: ${studentsError?.message || 'No students'}`);
    }

    const students = studentsResponse.data.students || [];
    console.log(`👥 Found ${students.length} students`);

    // Test HPS calculation for each student
    for (const student of students) {
      try {
        console.log(`\n🔄 Calculating HPS for ${student.name} (${student.registration_no})...`);

        const { data: hpsResponse, error: hpsError } = await axios.post(`${apiBase}/unified-scores/students/${student.id}/hps`, {
          termId: termId
        });

        if (hpsError || !hpsResponse.success) {
          console.error(`❌ HPS calculation failed for ${student.name}:`, hpsError?.message || hpsResponse.message);
          continue;
        }

        const hpsData = hpsResponse.data.hps;
        console.log(`✅ HPS calculated for ${student.name}: ${hpsData.totalHPS}% (${hpsData.grade})`);

        // Check if student's overall_score was updated
        const { data: updatedStudentResponse, error: studentError } = await axios.get(`${apiBase}/students/${student.id}`);
        if (!studentError && updatedStudentResponse.success) {
          const updatedStudent = updatedStudentResponse.data;
          console.log(`📊 Student record updated: ${updatedStudent.overall_score}% (${updatedStudent.grade})`);
        }

      } catch (error) {
        console.error(`❌ Error calculating HPS for ${student.name}:`, error.response?.data?.message || error.message);
      }
    }

    console.log('\n✅ HPS API test completed');

  } catch (error) {
    console.error('❌ API test failed:', error.message);
    process.exit(1);
  }
}

// Run the test
testHPSAPI().catch(error => {
  console.error('❌ Test failed:', error);
  process.exit(1);
});
