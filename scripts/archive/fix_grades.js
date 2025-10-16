#!/usr/bin/env node

/**
 * Fix Grades Script
 *
 * This script updates invalid grade values in student_score_summary to valid database enum values
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

// Function to map invalid grades to valid enum values
function mapGradeToValidEnum(grade) {
  const gradeMap = {
    'C+': 'C',
    'B+': 'B',
    'A+': 'A+', // This is already valid
    'A': 'A',   // This is already valid
    'B': 'B',   // This is already valid
    'C': 'C',   // This is already valid
    'D': 'D',   // This is already valid
    'E': 'E',   // This is already valid
    'IC': 'IC', // This is already valid
    'F': 'E',   // Map F to E since F is not in enum
  };

  return gradeMap[grade] || 'IC'; // Default to IC for unknown grades
}

async function fixGrades() {
  try {
    console.log('🔄 Fixing invalid grade values in student_score_summary...');

    // Get all records with invalid grades
    const { data: records, error: fetchError } = await supabase
      .from('student_score_summary')
      .select('student_id, overall_grade, total_hps');

    if (fetchError) {
      throw new Error(`Failed to fetch records: ${fetchError.message}`);
    }

    console.log(`📊 Found ${records.length} HPS calculation records`);

    const updates = [];
    let fixedCount = 0;

    for (const record of records) {
      const currentGrade = record.overall_grade;
      const validGrade = mapGradeToValidEnum(currentGrade);

      if (currentGrade !== validGrade) {
        console.log(`🔄 Fixing grade for student ${record.student_id}: ${currentGrade} → ${validGrade}`);
        updates.push({
          student_id: record.student_id,
          old_grade: currentGrade,
          new_grade: validGrade,
          total_hps: record.total_hps
        });
        fixedCount++;
      }
    }

    if (updates.length > 0) {
      // Update the grades in the database
      for (const update of updates) {
        const { error: updateError } = await supabase
          .from('student_score_summary')
          .update({ overall_grade: update.new_grade })
          .eq('student_id', update.student_id);

        if (updateError) {
          console.error(`❌ Failed to update student ${update.student_id}:`, updateError.message);
        }
      }

      console.log(`✅ Fixed ${fixedCount} invalid grade values`);

      // Now update the students table with the corrected grades
      await syncStudentsTable();
    } else {
      console.log('✅ All grades are already valid');
    }

  } catch (error) {
    console.error('❌ Fix failed:', error.message);
    process.exit(1);
  }
}

async function syncStudentsTable() {
  try {
    console.log('🔄 Syncing corrected grades to students table...');

    // Get all HPS calculations with valid grades
    const { data: hpsRecords, error: hpsError } = await supabase
      .from('student_score_summary')
      .select(`
        student_id,
        total_hps,
        overall_grade,
        students!inner(id, overall_score, grade)
      `);

    if (hpsError) {
      throw new Error(`Failed to get HPS records: ${hpsError.message}`);
    }

    let syncedCount = 0;

    // Update each student's overall_score and grade
    for (const record of hpsRecords) {
      const student = record.students;

      if (student.overall_score !== record.total_hps || student.grade !== record.overall_grade) {
        const { error: updateError } = await supabase
          .from('students')
          .update({
            overall_score: record.total_hps,
            grade: record.overall_grade,
            updated_at: new Date().toISOString()
          })
          .eq('id', student.id);

        if (updateError) {
          console.error(`❌ Failed to update student ${student.id}:`, updateError.message);
        } else {
          syncedCount++;
        }
      }
    }

    console.log(`✅ Synced ${syncedCount} students with corrected grades`);

  } catch (error) {
    console.error('❌ Sync failed:', error.message);
  }
}

// Run the fix
fixGrades().catch(error => {
  console.error('❌ Fix failed:', error);
  process.exit(1);
});
