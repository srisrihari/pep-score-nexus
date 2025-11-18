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
 * Import detailed Wellness microcompetency scores from Wellness sheet
 */
async function importWellnessDetailedScores() {
  try {
    console.log('\n📊 Importing Detailed Wellness Scores from Wellness Sheet\n');
    console.log('='.repeat(80));
    
    // Read Wellness sheet
    const excelPath = path.join(__dirname, '../../test_data_2/HPS - Jagsom PEP Grade Updated.xlsx');
    const workbook = XLSX.readFile(excelPath);
    const ws = workbook.Sheets['Wellness'];
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    // Find term sections (row 1 has term names)
    const termRow = data[1] || [];
    const headerRow = data[3] || [];
    const microcompRow = data[3] || []; // Row 3 has microcompetency names
    
    console.log('Term row:', termRow.slice(0, 30));
    console.log('Header row:', headerRow.slice(0, 30));
    
    // Find registration number column (should be column 1 based on structure)
    let regNoCol = headerRow.findIndex(h => h && h.toString().toLowerCase().includes('rn'));
    if (regNoCol === -1) {
      // Fallback: check row 2 (Sr #, RN, Student name)
      const row2 = data[2] || [];
      regNoCol = row2.findIndex(h => h && h.toString().toLowerCase().includes('rn'));
      if (regNoCol === -1) {
        regNoCol = 1; // Default to column 1
      }
    }
    
    // Find microcompetency columns for Level 0 (first section starts at column 4)
    const microcompNames = ['Push Ups', 'Sit Ups', 'Sit & reach', 'Beep test', '3KM Run', 'BCA'];
    const microcompCols = {};
    
    // Level 0 microcompetencies are in columns 4-9
    // Map by position: Push Ups=4, Sit Ups=5, Sit & reach=6, Beep test=7, 3KM Run=8, BCA=9
    const level0StartCol = 4;
    microcompNames.forEach((name, idx) => {
      microcompCols[name] = level0StartCol + idx;
    });
    
    console.log('\nMicrocompetency columns (Level 0):', microcompCols);
    
    // Verify by checking row 3
    console.log('\nVerifying columns:');
    microcompNames.forEach(name => {
      const colIdx = microcompCols[name];
      const headerVal = headerRow[colIdx];
      console.log(`  ${name}: col ${colIdx} = ${headerVal}`);
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
    
    // Get Level 0 term
    const termResult = await query(
      supabase
        .from('terms')
        .select('id, name')
        .eq('name', 'Level 0')
        .eq('is_active', true)
        .limit(1)
    );
    
    if (!termResult.rows || termResult.rows.length === 0) {
      throw new Error('Level 0 term not found');
    }
    
    const level0Term = termResult.rows[0];
    
    // Get Level 0 Wellness intervention
    const wellnessInterventionResult = await query(
      supabase
        .from('interventions')
        .select('id, name')
        .eq('term_id', level0Term.id)
        .ilike('name', '%wellness%level 0%')
        .limit(1)
    );
    
    if (!wellnessInterventionResult.rows || wellnessInterventionResult.rows.length === 0) {
      throw new Error('Level 0 Wellness intervention not found');
    }
    
    const wellnessInterventionId = wellnessInterventionResult.rows[0].id;
    
    // Get Wellness microcompetencies
    const wellnessMicrocompsResult = await query(
      supabase
        .from('microcompetencies')
        .select('id, name')
        .in('name', microcompNames)
    );
    
    const microcompMap = {};
    wellnessMicrocompsResult.rows.forEach(mc => {
      microcompMap[mc.name] = mc.id;
    });
    
    console.log(`\n📚 Found ${studentsResult.rows.length} students`);
    console.log(`📚 Found ${wellnessMicrocompsResult.rows.length} Wellness microcompetencies`);
    
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
    
    // Import scores (starting from row 4, which is first student)
    const allScores = [];
    
    for (let rowIdx = 4; rowIdx < data.length; rowIdx++) {
      const row = data[rowIdx];
      if (!row || !row[regNoCol]) continue;
      
      const regNo = row[regNoCol] ? row[regNoCol].toString().trim() : null;
      if (!regNo) continue;
      
      const student = studentsMap[regNo];
      
      if (!student) {
        continue; // Skip students not in our database
      }
      
      // Import Level 0 Wellness scores
      Object.entries(microcompCols).forEach(([mcName, colIdx]) => {
        const score = row[colIdx];
        const mcId = microcompMap[mcName];
        
        if (mcId && score !== undefined && score !== null) {
          // Handle different score formats
          let scoreValue = null;
          
          if (typeof score === 'number') {
            scoreValue = score;
          } else if (typeof score === 'string') {
            // Handle letter grades or special values
            const scoreStr = score.trim().toUpperCase();
            if (scoreStr === 'M' || scoreStr === 'NC') {
              scoreValue = 0; // Not cleared or missing
            } else {
              const parsed = parseFloat(scoreStr);
              if (!isNaN(parsed)) {
                scoreValue = parsed;
              }
            }
          }
          
          // Only add if we have a valid score (including 0)
          // Note: Raw values need to be normalized to 0-5 scale
          // For now, we'll use the Fitness Test percentage from HPS sheet
          // But first, let's try to normalize raw values
          if (scoreValue !== null && scoreValue >= 0) {
            // Normalize to 0-5 scale
            // For most fitness tests, assume max values and normalize
            let normalizedScore = scoreValue;
            
            // Handle special cases
            if (mcName === 'BCA' && scoreValue > 5) {
              // BCA is typically 0-100, normalize to 0-5
              normalizedScore = (scoreValue / 100) * 5;
            } else if (mcName === 'Beep test' && typeof score === 'string') {
              // M means not cleared
              normalizedScore = 0;
            } else if (scoreValue > 5) {
              // For other tests, assume they're already normalized or use a reasonable max
              // Push Ups, Sit Ups, Sit & reach, 3KM Run might have different scales
              // For now, cap at 5 if it exceeds
              normalizedScore = Math.min(scoreValue, 5);
            }
            
            // Ensure score is within 0-5 range
            normalizedScore = Math.max(0, Math.min(5, normalizedScore));
            
            allScores.push({
              student_id: student.id,
              intervention_id: wellnessInterventionId,
              microcompetency_id: mcId,
              obtained_score: normalizedScore,
              max_score: 5,
              scored_by: teacherId,
              scored_at: new Date().toISOString(),
              feedback: normalizedScore === 0 ? 'Not cleared' : '',
              status: 'Submitted', // All scores from Excel are submitted
              term_id: level0Term.id
            });
          }
        }
      });
    }
    
    console.log(`\n📝 Importing ${allScores.length} Wellness scores...\n`);
    
    // Import scores in batches
    const batchSize = 100;
    let importedCount = 0;
    
    for (let i = 0; i < allScores.length; i += batchSize) {
      const batch = allScores.slice(i, i + batchSize);
      
      const { error: scoreError } = await supabase
        .from('microcompetency_scores')
        .upsert(batch, { 
          onConflict: 'student_id,intervention_id,microcompetency_id'
        });
      
      if (scoreError) {
        console.error(`❌ Error inserting batch ${Math.floor(i / batchSize) + 1}:`, scoreError.message);
      } else {
        importedCount += batch.length;
        console.log(`  ✅ Inserted batch ${Math.floor(i / batchSize) + 1} (${batch.length} scores)`);
      }
    }
    
    console.log(`\n✅ Successfully imported ${importedCount} Wellness scores!`);
    
    return { importedCount };
    
  } catch (error) {
    console.error('❌ Error importing Wellness detailed scores:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  importWellnessDetailedScores()
    .then(() => {
      console.log('\n✅ Wellness detailed score import completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Wellness detailed score import failed:', error);
      process.exit(1);
    });
}

module.exports = { importWellnessDetailedScores };

