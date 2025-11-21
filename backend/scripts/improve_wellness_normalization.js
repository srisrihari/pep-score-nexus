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
 * Improve Wellness score normalization using Fitness Test percentage from HPS sheet
 */
async function improveWellnessNormalization() {
  try {
    console.log('\n📊 Improving Wellness Score Normalization\n');
    console.log('='.repeat(80));
    
    // Read HPS sheet to get Fitness Test percentages
    const hpsExcelPath = path.join(__dirname, '../../test_data_2/HPS - Jagsom PEP Grade Updated.xlsx');
    const workbook = XLSX.readFile(hpsExcelPath);
    const ws = workbook.Sheets['HPS'];
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    const headers = data[1];
    const subHeaders = data[2];
    
    // Find registration number column
    const regNoCol = headers.findIndex(h => h && h.toString().toLowerCase().includes('rn'));
    
    // Find level positions and Fitness Test columns
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
    
    // Get Fitness Test percentages for each level
    const fitnessTestPercentages = {};
    
    for (let rowIdx = 3; rowIdx < data.length; rowIdx++) {
      const row = data[rowIdx];
      if (!row || !row[regNoCol]) continue;
      
      const regNo = row[regNoCol].toString().trim();
      
      Object.entries(levelPositions).forEach(([levelName, levelStart]) => {
        // Find Fitness Test column (around levelStart + 6)
        let fitnessTestCol = null;
        for (let i = levelStart; i < levelStart + 15 && i < headers.length; i++) {
          const h = (headers[i] || '').toString().toLowerCase();
          const sh = (subHeaders[i] || '').toString().toLowerCase();
          if ((h.includes('wellness') || h === '') && (sh.includes('fitness') || sh.includes('fitnesss'))) {
            fitnessTestCol = i;
            break;
          }
        }
        
        if (fitnessTestCol !== null) {
          const fitnessValue = row[fitnessTestCol];
          if (fitnessValue !== undefined && fitnessValue !== null && !isNaN(fitnessValue) && fitnessValue > 0) {
            if (!fitnessTestPercentages[regNo]) {
              fitnessTestPercentages[regNo] = {};
            }
            fitnessTestPercentages[regNo][levelName] = fitnessValue;
          }
        }
      });
    }
    
    console.log(`📊 Found Fitness Test percentages for ${Object.keys(fitnessTestPercentages).length} students`);
    
    // Read Wellness sheet for individual scores
    const wellnessWs = workbook.Sheets['Wellness'];
    const wellnessData = XLSX.utils.sheet_to_json(wellnessWs, { header: 1 });
    
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
    
    const teacherId = teacherResult.rows[0].id;
    
    // Microcompetency column offsets
    const microcompOffsets = {
      'Level 0': 4,
      'Level 1': 11,
      'Level 2': 24,
      'Level 3': 31
    };
    
    const microcompNames = ['Push Ups', 'Sit Ups', 'Sit & reach', 'Beep test', '3KM Run', 'BCA'];
    const regNoColWellness = 1;
    
    // Process each term and normalize scores
    const allScores = [];
    
    for (const [termName, term] of Object.entries(termsMap)) {
      console.log(`\n📅 Processing Term: ${termName}`);
      
      const wellnessInterventionResult = await query(
        supabase
          .from('interventions')
          .select('id, name')
          .eq('term_id', term.id)
          .ilike('name', `%wellness%${termName}%`)
          .limit(1)
      );
      
      if (!wellnessInterventionResult.rows || wellnessInterventionResult.rows.length === 0) {
        continue;
      }
      
      const wellnessInterventionId = wellnessInterventionResult.rows[0].id;
      const startCol = microcompOffsets[termName];
      
      if (!startCol) continue;
      
      // Parse scores and normalize
      for (let rowIdx = 4; rowIdx < wellnessData.length; rowIdx++) {
        const row = wellnessData[rowIdx];
        if (!row || !row[regNoColWellness]) continue;
        
        const regNo = row[regNoColWellness].toString().trim();
        const student = studentsMap[regNo];
        
        if (!student) continue;
        
        // Get Fitness Test percentage for this student and level
        const fitnessTestPct = fitnessTestPercentages[regNo]?.[termName];
        
        // Extract raw scores
        const rawScores = {};
        microcompNames.forEach((mcName, idx) => {
          const colIdx = startCol + idx;
          const score = row[colIdx];
          
          if (score !== undefined && score !== null) {
            let scoreValue = null;
            
            if (typeof score === 'number') {
              scoreValue = score;
            } else if (typeof score === 'string') {
              const scoreStr = score.trim().toUpperCase();
              if (scoreStr === 'M' || scoreStr === 'NC') {
                scoreValue = 0;
              } else {
                const parsed = parseFloat(scoreStr);
                if (!isNaN(parsed)) {
                  scoreValue = parsed;
                }
              }
            }
            
            if (scoreValue !== null && scoreValue >= 0) {
              rawScores[mcName] = scoreValue;
            }
          }
        });
        
        // Normalize scores
        Object.entries(rawScores).forEach(([mcName, rawScore]) => {
          const mcId = microcompMap[mcName];
          if (!mcId) return;
          
          let normalizedScore = rawScore;
          
          // BCA: Convert 0-100 to 0-5
          if (mcName === 'BCA' && rawScore > 5) {
            normalizedScore = (rawScore / 100) * 5;
          }
          // For other tests, use Fitness Test percentage to scale
          else if (fitnessTestPct && fitnessTestPct > 0) {
            // Convert Fitness Test percentage to score out of 5
            const targetScore = (fitnessTestPct / 100) * 5;
            
            // If we have individual scores, we need to normalize them
            // Calculate average of all raw scores (excluding BCA which is already normalized)
            const otherScores = Object.entries(rawScores)
              .filter(([name, val]) => name !== 'BCA' && val > 0)
              .map(([name, val]) => val);
            
            if (otherScores.length > 0) {
              const avgRawScore = otherScores.reduce((a, b) => a + b, 0) / otherScores.length;
              
              // Scale individual score proportionally
              if (avgRawScore > 0) {
                const scaleFactor = targetScore / avgRawScore;
                normalizedScore = rawScore * scaleFactor;
              } else {
                normalizedScore = targetScore; // Distribute evenly if all zeros
              }
            } else {
              // No other scores, distribute evenly
              normalizedScore = targetScore;
            }
          }
          // Fallback: cap at 5
          else if (normalizedScore > 5) {
            normalizedScore = Math.min(normalizedScore, 5);
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
            status: 'Submitted',
            term_id: term.id
          });
        });
      }
      
      console.log(`  📝 Prepared ${allScores.filter(s => s.term_id === term.id).length} normalized scores`);
    }
    
    console.log(`\n📝 Total normalized scores: ${allScores.length}`);
    
    // Import scores
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
        console.error(`  ❌ Error inserting batch ${Math.floor(i / batchSize) + 1}:`, scoreError.message);
      } else {
        importedCount += batch.length;
        console.log(`  ✅ Inserted batch ${Math.floor(i / batchSize) + 1} (${batch.length} scores)`);
      }
    }
    
    console.log(`\n✅ Successfully imported ${importedCount} normalized Wellness scores!`);
    
    return { importedCount };
    
  } catch (error) {
    console.error('❌ Error improving Wellness normalization:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  improveWellnessNormalization()
    .then(() => {
      console.log('\n✅ Wellness normalization improvement completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Wellness normalization improvement failed:', error);
      process.exit(1);
    });
}

module.exports = { improveWellnessNormalization };



