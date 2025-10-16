#!/usr/bin/env node

/**
 * Sync HPS Scores Script
 *
 * This script syncs existing HPS scores from student_score_summary to the main students table
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

async function syncHPSScores() {
  try {
    console.log('🔄 Syncing HPS scores to students table...');

    // Get all HPS calculations that haven't been synced to students table
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

    console.log(`📊 Found ${hpsRecords.length} HPS calculation records`);

    let syncedCount = 0;
    let skippedCount = 0;

    // Update each student's overall_score and grade
    for (const record of hpsRecords) {
      const student = record.students;

      // Check if student needs updating
      if (student.overall_score !== record.total_hps || student.grade !== record.overall_grade) {
        console.log(`🔄 Updating ${student.id}: ${student.overall_score}% (${student.grade}) → ${record.total_hps}% (${record.overall_grade})`);

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
      } else {
        skippedCount++;
      }
    }

    console.log(`✅ Sync completed: ${syncedCount} students updated, ${skippedCount} already up-to-date`);

    // Verify the sync worked
    const { data: updatedStudents, error: verifyError } = await supabase
      .from('students')
      .select('id, name, overall_score, grade')
      .order('overall_score', { ascending: false })
      .limit(10);

    if (!verifyError) {
      console.log('\n📋 Top 10 students by HPS score:');
      updatedStudents.forEach(student => {
        console.log(`  ${student.name}: ${student.overall_score}% (${student.grade})`);
      });
    }

  } catch (error) {
    console.error('❌ Sync failed:', error.message);
    process.exit(1);
  }
}

// Run the sync
syncHPSScores().catch(error => {
  console.error('❌ Sync failed:', error);
  process.exit(1);
});
