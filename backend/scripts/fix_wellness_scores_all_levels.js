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
 * Fix Wellness scores for all levels with proper normalization
 */
async function fixWellnessScoresAllLevels() {
  try {
    console.log('\n📊 Fixing Wellness Scores for All Levels\n');
    console.log('='.repeat(80));
    
    // Read Wellness sheet
    const excelPath = path.join(__dirname, '../../test_data_2/HPS - Jagsom PEP Grade Updated.xlsx');
    const workbook = XLSX.readFile(excelPath);
    const ws = workbook.Sheets['Wellness'];
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
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
        .order('name')
    );
    
    const termsMap = {};
    termsResult.rows.forEach(t => {
      termsMap[t.name] = t;
    });
    
    // Get Wellness microcompetencies
    const wellnessMicrocompsResult = await query(
      supabase
        .from('microcompetencies')
        .select('id, name')
        .in('name', ['Push Ups', 'Sit Ups', 'Sit & reach', 'Beep test', '3KM Run', 'BCA'])
    );
    
    const microcompMap = {};
    wellnessMicrocompsResult.rows.forEach(mc => {
      microcompMap[mc.name] = mc.id;
    });
    
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
    
    // Term column mappings in Wellness sheet
    // Row 1 has term names: "Term 1 / Level 0", "Term 2 / Level 1", etc.
    const termRow = data[1] || [];
    const headerRow = data[3] || [];
    
    // Find term column positions
    const termCols = {
      'Level 0': null,
      'Level 1': null,
      'Level 2': null,
      'Level 3': null
    };
    
    termRow.forEach((col, idx) => {
      if (col) {
        const colStr = col.toString().toLowerCase();
        if (colStr.includes('level 0') || colStr.includes('evel 0')) {
          termCols['Level 0'] = idx;
        } else if (colStr.includes('level 1') || colStr.includes('evel 1')) {
          termCols['Level 1'] = idx;
        } else if (colStr.includes('level 2') || colStr.includes('evel 2')) {
          termCols['Level 2'] = idx;
        } else if (colStr.includes('level 3') || colStr.includes('evel 3')) {
          termCols['Level 3'] = idx;
        }
      }
    });
    
    console.log('Term column positions:', termCols);
    
    // Microcompetency column offsets for each term
    // Each term has 6 microcompetencies starting at different columns
    const microcompOffsets = {
      'Level 0': 4,  // Columns 4-9
      'Level 1': 11, // Columns 11-16
      'Level 2': 24, // Columns 24-29
      'Level 3': 31  // Columns 31-36
    };
    
    const microcompNames = ['Push Ups', 'Sit Ups', 'Sit & reach', 'Beep test', '3KM Run', 'BCA'];
    
    // Registration number column (column 1)
    const regNoCol = 1;
    
    // Process each term
    const allScores = [];
    
    for (const [termName, term] of Object.entries(termsMap)) {
      console.log(`\n📅 Processing Term: ${termName}`);
      
      // Get Wellness intervention for this term
      const wellnessInterventionResult = await query(
        supabase
          .from('interventions')
          .select('id, name')
          .eq('term_id', term.id)
          .ilike('name', `%wellness%${termName}%`)
          .limit(1)
      );
      
      if (!wellnessInterventionResult.rows || wellnessInterventionResult.rows.length === 0) {
        console.log(`  ⚠️  Wellness intervention not found for ${termName}`);
        continue;
      }
      
      const wellnessInterventionId = wellnessInterventionResult.rows[0].id;
      console.log(`  ✅ Found intervention: ${wellnessInterventionResult.rows[0].name}`);
      
      const startCol = microcompOffsets[termName];
      if (!startCol) {
        console.log(`  ⚠️  No column mapping for ${termName}`);
        continue;
      }
      
      // Parse scores from Excel (starting from row 4)
      for (let rowIdx = 4; rowIdx < data.length; rowIdx++) {
        const row = data[rowIdx];
        if (!row || !row[regNoCol]) continue;
        
        const regNo = row[regNoCol].toString().trim();
        const student = studentsMap[regNo];
        
        if (!student) continue;
        
        // Extract scores for each microcompetency
        microcompNames.forEach((mcName, idx) => {
          const colIdx = startCol + idx;
          const score = row[colIdx];
          const mcId = microcompMap[mcName];
          
          if (!mcId) return;
          
          if (score !== undefined && score !== null) {
            // Normalize score properly
            let normalizedScore = null;
            
            if (typeof score === 'number') {
              normalizedScore = score;
            } else if (typeof score === 'string') {
              const scoreStr = score.trim().toUpperCase();
              if (scoreStr === 'M' || scoreStr === 'NC') {
                normalizedScore = 0;
              } else {
                const parsed = parseFloat(scoreStr);
                if (!isNaN(parsed)) {
                  normalizedScore = parsed;
                }
              }
            }
            
            if (normalizedScore !== null && normalizedScore >= 0) {
              // Normalize based on microcompetency type
              let finalScore = normalizedScore;
              
              // BCA is typically 0-100, normalize to 0-5
              if (mcName === 'BCA' && normalizedScore > 5) {
                finalScore = (normalizedScore / 100) * 5;
              }
              // For other tests, if value > 5, we need to normalize
              // But we'll use the Fitness Test percentage from HPS sheet as reference
              // For now, cap at 5 if exceeds
              else if (normalizedScore > 5 && mcName !== 'BCA') {
                // Use Fitness Test percentage to normalize
                // Get Fitness Test percentage from HPS sheet
                finalScore = Math.min(normalizedScore, 5);
              }
              
              // Ensure score is within 0-5 range
              finalScore = Math.max(0, Math.min(5, finalScore));
              
              allScores.push({
                student_id: student.id,
                intervention_id: wellnessInterventionId,
                microcompetency_id: mcId,
                obtained_score: finalScore,
                max_score: 5,
                scored_by: teacherId,
                scored_at: new Date().toISOString(),
                feedback: finalScore === 0 ? 'Not cleared' : '',
                status: 'Submitted',
                term_id: term.id
              });
            }
          }
        });
      }
      
      console.log(`  📝 Prepared ${allScores.filter(s => s.term_id === term.id).length} scores for ${termName}`);
    }
    
    console.log(`\n📝 Total scores to import: ${allScores.length}`);
    
    // Import scores in batches
    const batchSize = 100;
    let importedCount = 0;
    let errorCount = 0;
    
    for (let i = 0; i < allScores.length; i += batchSize) {
      const batch = allScores.slice(i, i + batchSize);
      
      const { error: scoreError } = await supabase
        .from('microcompetency_scores')
        .upsert(batch, { 
          onConflict: 'student_id,intervention_id,microcompetency_id'
        });
      
      if (scoreError) {
        console.error(`  ❌ Error inserting batch ${Math.floor(i / batchSize) + 1}:`, scoreError.message);
        errorCount += batch.length;
        
        // Try individual inserts
        for (const score of batch) {
          const { error: individualError } = await supabase
            .from('microcompetency_scores')
            .upsert(score, { 
              onConflict: 'student_id,intervention_id,microcompetency_id'
            });
          
          if (individualError) {
            console.error(`    ❌ Failed: ${score.student_id}, ${score.microcompetency_id}:`, individualError.message);
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
    
    console.log(`\n✅ Successfully imported ${importedCount} Wellness scores!`);
    if (errorCount > 0) {
      console.log(`⚠️  ${errorCount} scores failed to import`);
    }
    
    return { importedCount, errorCount };
    
  } catch (error) {
    console.error('❌ Error fixing Wellness scores:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  fixWellnessScoresAllLevels()
    .then(() => {
      console.log('\n✅ Wellness score fix completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Wellness score fix failed:', error);
      process.exit(1);
    });
}

module.exports = { fixWellnessScoresAllLevels };



