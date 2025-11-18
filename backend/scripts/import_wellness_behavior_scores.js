// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');
const { query } = require('../src/config/supabase');
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY
);

/**
 * Import Wellness and Behavior scores from Excel
 */
async function importWellnessBehaviorScores() {
  try {
    console.log('\n📊 Importing Wellness and Behavior Scores from Excel\n');
    console.log('='.repeat(80));
    
    // Read Excel file
    const excelPath = path.join(__dirname, '../../test_data_2/HPS - Jagsom PEP Grade Updated.xlsx');
    const workbook = XLSX.readFile(excelPath);
    const ws = workbook.Sheets['HPS'];
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    const headers = data[1];
    const subHeaders = data[2];
    
    // Find column indices
    const regNoColIndex = headers.findIndex(col => 
      col && col.toString().toLowerCase().includes('rn')
    );
    const nameColIndex = headers.findIndex(col => 
      col && col.toString().toLowerCase().includes('student name')
    );
    
    // Find level positions
    const levelRow = data[0] || [];
    const levelPositions = {};
    levelRow.forEach((col, idx) => {
      if (col) {
        const colStr = col.toString().toLowerCase().trim();
        if (colStr.includes('level 0')) levelPositions['Level 0'] = idx;
        else if (colStr.includes('level 1')) levelPositions['Level 1'] = idx;
        else if (colStr.includes('level 2')) levelPositions['Level 2'] = idx;
        else if (colStr.includes('level 3')) levelPositions['Level 3'] = idx;
      }
    });
    
    // Get all students
    const studentsResult = await query(
      supabase
        .from('students')
        .select('id, registration_no, name')
        .eq('status', 'Active')
        .order('registration_no')
    );
    
    const studentsMap = {};
    studentsResult.rows.forEach(s => {
      studentsMap[s.registration_no] = s;
    });
    
    // Get all terms
    const termsResult = await query(
      supabase
        .from('terms')
        .select('id, name')
        .in('name', ['Level 0', 'Level 1', 'Level 2', 'Level 3'])
        .eq('is_active', true)
    );
    
    const termsMap = {};
    termsResult.rows.forEach(t => {
      termsMap[t.name] = t;
    });
    
    // Get Wellness interventions
    const wellnessInterventionsResult = await query(
      supabase
        .from('interventions')
        .select('id, name, term_id')
        .ilike('name', '%wellness%')
    );
    
    const wellnessInterventionsMap = {};
    wellnessInterventionsResult.rows.forEach(i => {
      const termName = termsResult.rows.find(t => t.id === i.term_id)?.name;
      if (termName) {
        wellnessInterventionsMap[termName] = i.id;
      }
    });
    
    // Get Behavior interventions
    const behaviorInterventionsResult = await query(
      supabase
        .from('interventions')
        .select('id, name, term_id')
        .ilike('name', '%behavior%')
    );
    
    const behaviorInterventionsMap = {};
    behaviorInterventionsResult.rows.forEach(i => {
      const termName = termsResult.rows.find(t => t.id === i.term_id)?.name;
      if (termName) {
        behaviorInterventionsMap[termName] = i.id;
      }
    });
    
    // Get Wellness microcompetencies
    const wellnessMicrocompsResult = await query(
      supabase
        .from('microcompetencies')
        .select('id, name')
        .in('name', ['3KM Run', 'BCA', 'Beep test', 'Push Ups', 'Sit & reach', 'Sit Ups'])
    );
    
    // Get Behavior microcompetency
    const behaviorMicrocompResult = await query(
      supabase
        .from('microcompetencies')
        .select('id, name')
        .eq('name', 'Behavior Score')
        .limit(1)
    );
    
    if (!behaviorMicrocompResult.rows || behaviorMicrocompResult.rows.length === 0) {
      throw new Error('Behavior Score microcompetency not found');
    }
    
    const behaviorMicrocompId = behaviorMicrocompResult.rows[0].id;
    
    // Get teacher ID
    const teacherResult = await query(
      supabase
        .from('teachers')
        .select('id')
        .ilike('name', '%raj%')
        .limit(1)
    );
    
    if (!teacherResult.rows || teacherResult.rows.length === 0) {
      throw new Error('Teacher Raj not found');
    }
    
    const teacherId = teacherResult.rows[0].id;
    
    console.log(`\n📚 Found ${studentsResult.rows.length} students`);
    console.log(`📚 Found ${termsResult.rows.length} terms`);
    console.log(`📚 Found ${wellnessInterventionsResult.rows.length} Wellness interventions`);
    console.log(`📚 Found ${behaviorInterventionsResult.rows.length} Behavior interventions\n`);
    
    // Parse Excel and import scores
    const allScores = [];
    
    // Process each student row (starting from row 3, index 2)
    for (let rowIdx = 2; rowIdx < data.length; rowIdx++) {
      const row = data[rowIdx];
      if (!row || !row[regNoColIndex]) continue;
      
      const regNo = row[regNoColIndex].toString().trim();
      const student = studentsMap[regNo];
      
      if (!student) {
        console.warn(`⚠️  Student not found: ${regNo}`);
        continue;
      }
      
      // Process each level
      Object.entries(levelPositions).forEach(([levelName, levelStart]) => {
        const term = termsMap[levelName];
        if (!term) return;
        
        // Find Wellness Fitness Test column and Behavior Score column
        // Based on Excel structure:
        // Level 0: Wellness Fitness Test is at levelStart + 6, Behavior Score is at levelStart + 9
        let wellnessFitnessTestCol = null;
        let behaviorScoreCol = null;
        
        // Search for Wellness Fitness Test (subheader contains 'Fitnesss Test' or 'Fitness Test')
        for (let i = levelStart; i < levelStart + 15 && i < headers.length; i++) {
          const h = (headers[i] || '').toString().toLowerCase();
          const sh = (subHeaders[i] || '').toString().toLowerCase();
          if ((h.includes('wellness') || h === '') && (sh.includes('fitness') || sh.includes('fitnesss'))) {
            wellnessFitnessTestCol = i;
            break;
          }
        }
        
        // Search for Behavior Score (subheader contains 'Score' and header contains 'Behavior')
        for (let i = levelStart; i < levelStart + 15 && i < headers.length; i++) {
          const h = (headers[i] || '').toString().toLowerCase();
          const sh = (subHeaders[i] || '').toString().toLowerCase();
          if (h.includes('behavior') && sh.includes('score')) {
            behaviorScoreCol = i;
            break;
          }
        }
        
        // Fallback: Use fixed offsets if not found
        if (wellnessFitnessTestCol === null) {
          wellnessFitnessTestCol = levelStart + 6; // Approximate position
        }
        if (behaviorScoreCol === null) {
          behaviorScoreCol = levelStart + 9; // Approximate position
        }
        
        // Import Wellness scores
        if (wellnessFitnessTestCol !== null && wellnessInterventionsMap[levelName]) {
          const fitnessTestValue = row[wellnessFitnessTestCol];
          
          // For Wellness, we need to distribute the Fitness Test score across all 6 microcompetencies
          // Excel shows a single Fitness Test score, so we'll use it as an average
          if (fitnessTestValue !== undefined && fitnessTestValue !== null && !isNaN(fitnessTestValue) && fitnessTestValue > 0) {
            // Convert percentage to score out of 5
            const scoreOutOf5 = (fitnessTestValue / 100) * 5;
            
            wellnessMicrocompsResult.rows.forEach(mc => {
              allScores.push({
                student_id: student.id,
                intervention_id: wellnessInterventionsMap[levelName],
                microcompetency_id: mc.id,
                obtained_score: scoreOutOf5,
                max_score: 5,
                scored_by: teacherId,
                scored_at: new Date().toISOString(),
                feedback: '',
                status: 'Submitted',
                term_id: term.id
              });
            });
          }
        }
        
        // Import Behavior scores
        if (behaviorScoreCol !== null && behaviorInterventionsMap[levelName]) {
          const behaviorScoreValue = row[behaviorScoreCol];
          
          if (behaviorScoreValue !== undefined && behaviorScoreValue !== null && !isNaN(behaviorScoreValue) && behaviorScoreValue > 0) {
            // Behavior score is already out of 5 (Excel shows 3)
            const scoreOutOf5 = behaviorScoreValue;
            
            allScores.push({
              student_id: student.id,
              intervention_id: behaviorInterventionsMap[levelName],
              microcompetency_id: behaviorMicrocompId,
              obtained_score: scoreOutOf5,
              max_score: 5,
              scored_by: teacherId,
              scored_at: new Date().toISOString(),
              feedback: '',
              status: 'Submitted',
              term_id: term.id
            });
          }
        }
      });
    }
    
    console.log(`\n📝 Importing ${allScores.length} scores...\n`);
    
    // Import scores in batches
    const batchSize = 100;
    let importedCount = 0;
    let errorCount = 0;
    
    for (let i = 0; i < allScores.length; i += batchSize) {
      const batch = allScores.slice(i, i + batchSize);
      
      // Use upsert to handle duplicates
      const { error: scoreError } = await supabase
        .from('microcompetency_scores')
        .upsert(batch, { 
          onConflict: 'student_id,intervention_id,microcompetency_id',
          ignoreDuplicates: false
        });
      
      if (scoreError) {
        console.error(`❌ Error inserting batch ${Math.floor(i / batchSize) + 1}:`, scoreError.message);
        errorCount += batch.length;
        
        // Try individual inserts
        for (const score of batch) {
          const { error: individualError } = await supabase
            .from('microcompetency_scores')
            .upsert(score, { 
              onConflict: 'student_id,intervention_id,microcompetency_id'
            });
          
          if (individualError) {
            console.error(`  ❌ Failed: ${score.student_id}, ${score.microcompetency_id}:`, individualError.message);
            errorCount++;
          } else {
            importedCount++;
          }
        }
      } else {
        importedCount += batch.length;
        console.log(`  ✅ Inserted batch ${Math.floor(i / batchSize) + 1} (${batch.length} scores)`);
      }
    }
    
    console.log(`\n✅ Successfully imported ${importedCount} scores!`);
    if (errorCount > 0) {
      console.log(`⚠️  ${errorCount} scores failed to import`);
    }
    
    return { importedCount, errorCount };
    
  } catch (error) {
    console.error('❌ Error importing Wellness/Behavior scores:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  importWellnessBehaviorScores()
    .then(() => {
      console.log('\n✅ Wellness/Behavior score import completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Wellness/Behavior score import failed:', error);
      process.exit(1);
    });
}

module.exports = { importWellnessBehaviorScores };

