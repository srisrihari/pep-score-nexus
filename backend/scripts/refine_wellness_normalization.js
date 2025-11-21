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
 * Refine Wellness score normalization using individual raw scores from Excel
 * This will properly normalize each fitness test score individually
 */
async function refineWellnessNormalization() {
  try {
    console.log('\n📊 Refining Wellness Score Normalization\n');
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
    
    const teacherId = teacherResult.rows[0].id;
    
    // Microcompetency column offsets for each term
    const microcompOffsets = {
      'Level 0': 4,
      'Level 1': 11,
      'Level 2': 24,
      'Level 3': 31
    };
    
    const microcompNames = ['Push Ups', 'Sit Ups', 'Sit & reach', 'Beep test', '3KM Run', 'BCA'];
    const regNoCol = 1;
    
    // Read HPS sheet to get Fitness Test percentages for reference
    const hpsWs = workbook.Sheets['HPS'];
    const hpsData = XLSX.utils.sheet_to_json(hpsWs, { header: 1 });
    const hpsHeaders = hpsData[1];
    const hpsSubHeaders = hpsData[2];
    
    // Find level positions
    const levelRow = hpsData[0] || [];
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
    
    // Get Fitness Test percentages
    const fitnessTestPercentages = {};
    const hpsRegNoCol = hpsHeaders.findIndex(h => h && h.toString().toLowerCase().includes('rn'));
    
    for (let rowIdx = 3; rowIdx < hpsData.length; rowIdx++) {
      const row = hpsData[rowIdx];
      if (!row || !row[hpsRegNoCol]) continue;
      
      const regNo = row[hpsRegNoCol].toString().trim();
      
      Object.entries(levelPositions).forEach(([levelName, levelStart]) => {
        let fitnessTestCol = null;
        for (let i = levelStart; i < levelStart + 15 && i < hpsHeaders.length; i++) {
          const h = (hpsHeaders[i] || '').toString().toLowerCase();
          const sh = (hpsSubHeaders[i] || '').toString().toLowerCase();
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
    
    console.log(`📊 Found Fitness Test percentages for ${Object.keys(fitnessTestPercentages).length} students\n`);
    
    // Process each term and normalize scores properly
    const allScores = [];
    
    for (const [termName, term] of Object.entries(termsMap)) {
      console.log(`📅 Processing Term: ${termName}`);
      
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
      
      // Parse scores and normalize individually
      for (let rowIdx = 4; rowIdx < data.length; rowIdx++) {
        const row = data[rowIdx];
        if (!row || !row[regNoCol]) continue;
        
        const regNo = row[regNoCol].toString().trim();
        const student = studentsMap[regNo];
        
        if (!student) continue;
        
        // Get Fitness Test percentage for reference
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
        
        // Normalize each score individually
        Object.entries(rawScores).forEach(([mcName, rawScore]) => {
          const mcId = microcompMap[mcName];
          if (!mcId) return;
          
          let normalizedScore = rawScore;
          
          // BCA: Convert 0-100 to 0-5
          if (mcName === 'BCA' && rawScore > 5) {
            normalizedScore = (rawScore / 100) * 5;
          }
          // For other tests, use a more intelligent normalization
          // Since Excel shows scores out of 5, we need to determine if raw values need scaling
          else if (rawScore > 5) {
            // If we have Fitness Test percentage, use it to scale
            if (fitnessTestPct && fitnessTestPct > 0) {
              // Calculate what the average score should be based on Fitness Test percentage
              const targetAvgScore = (fitnessTestPct / 100) * 5;
              
              // Calculate average of all non-BCA raw scores
              const otherRawScores = Object.entries(rawScores)
                .filter(([name, val]) => name !== 'BCA' && val > 0)
                .map(([name, val]) => val);
              
              if (otherRawScores.length > 0) {
                const avgRawScore = otherRawScores.reduce((a, b) => a + b, 0) / otherRawScores.length;
                
                if (avgRawScore > 0) {
                  // Scale factor: targetAvgScore / avgRawScore
                  const scaleFactor = targetAvgScore / avgRawScore;
                  normalizedScore = rawScore * scaleFactor;
                } else {
                  normalizedScore = targetAvgScore;
                }
              } else {
                normalizedScore = targetAvgScore;
              }
            }
            // Fallback: if score > 5, assume it's already in a different scale
            // For now, cap at 5 or use a reasonable conversion
            else {
              // Try to infer scale - if most scores are > 5, they might be in a 0-10 or 0-100 scale
              // But since Excel shows out of 5, we'll use Fitness Test percentage if available
              normalizedScore = Math.min(rawScore, 5);
            }
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
    
    console.log(`\n✅ Successfully imported ${importedCount} refined Wellness scores!`);
    
    return { importedCount };
    
  } catch (error) {
    console.error('❌ Error refining Wellness normalization:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  refineWellnessNormalization()
    .then(() => {
      console.log('\n✅ Wellness normalization refinement completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Wellness normalization refinement failed:', error);
      process.exit(1);
    });
}

module.exports = { refineWellnessNormalization };



