#!/usr/bin/env node

/**
 * Test HPS Calculation Script
 *
 * This script manually triggers HPS calculation for students to test the fix
 */

const { createClient } = require('@supabase/supabase-js');
require('dotenv').config();

const supabaseUrl = process.env.SUPABASE_URL;
const supabaseServiceKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !supabaseServiceKey) {
  console.error('❌ Missing required environment variables: SUPABASE_URL and SUPABASE_SERVICE_ROLE_KEY');
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseServiceKey);

async function testHPSCalculation() {
  try {
    console.log('🚀 Starting HPS calculation test...');

    // Get current term
    const { data: currentTerm, error: termError } = await supabase
      .from('terms')
      .select('id, name')
      .eq('is_current', true)
      .single();

    if (termError) {
      throw new Error(`Failed to get current term: ${termError.message}`);
    }

    console.log(`📅 Current term: ${currentTerm.name} (${currentTerm.id})`);

    // Get some students
    const { data: students, error: studentsError } = await supabase
      .from('students')
      .select('id, name, registration_no')
      .limit(5);

    if (studentsError) {
      throw new Error(`Failed to get students: ${studentsError.message}`);
    }

    console.log(`👥 Found ${students.length} students`);

    // Test HPS calculation for each student
    for (const student of students) {
      try {
        console.log(`\n🔄 Calculating HPS for ${student.name} (${student.registration_no})...`);

        // Call the HPS calculation function directly
        const { data: hpsResult, error: hpsError } = await supabase.rpc('calculate_unified_hps', {
          p_student_id: student.id,
          p_term_id: currentTerm.id
        });

        if (hpsError) {
          console.error(`❌ HPS calculation failed for ${student.name}:`, hpsError.message);
          continue;
        }

        if (hpsResult && hpsResult.length > 0) {
          const result = hpsResult[0];
          console.log(`✅ HPS calculated for ${student.name}: ${result.total_hps}% (${result.overall_grade})`);

          // Check if student's overall_score was updated
          const { data: updatedStudent, error: studentError } = await supabase
            .from('students')
            .select('overall_score, grade')
            .eq('id', student.id)
            .single();

          if (!studentError && updatedStudent) {
            console.log(`📊 Student record updated: ${updatedStudent.overall_score}% (${updatedStudent.grade})`);
          }
        } else {
          console.log(`⚠️ No HPS result returned for ${student.name}`);
        }

      } catch (error) {
        console.error(`❌ Error calculating HPS for ${student.name}:`, error.message);
      }
    }

    console.log('\n✅ HPS calculation test completed');

  } catch (error) {
    console.error('❌ Test failed:', error.message);
    process.exit(1);
  }
}

// Run the test
testHPSCalculation().catch(error => {
  console.error('❌ Test failed:', error);
  process.exit(1);
});
