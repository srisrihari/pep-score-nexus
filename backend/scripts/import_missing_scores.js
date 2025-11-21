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
 * Import remaining missing scores from Excel
 */
async function importMissingScores() {
  try {
    console.log('\n📊 Importing Missing Scores\n');
    console.log('='.repeat(80));
    
    const excelDataPath = path.join(__dirname, '../../test_data_2');
    
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
    
    // Get teacher ID
    const teacherResult = await query(
      supabase
        .from('teachers')
        .select('id')
        .ilike('name', '%raj%')
        .limit(1)
    );
    
    const teacherId = teacherResult.rows[0].id;
    
    const allScores = [];
    let importedCount = 0;
    
    // Import Fearless (Level 0) scores
    console.log('\n📅 Importing Fearless (Level 0) scores...');
    const fearlessFile = path.join(excelDataPath, 'Level 0 - Interventions.xlsx');
    if (fs.existsSync(fearlessFile)) {
      const scores = await importFearlessScores(fearlessFile, studentsMap, termsMap['Level 0'], teacherId);
      allScores.push(...scores);
      console.log(`  ✅ Imported ${scores.length} Fearless scores`);
    }
    
    // Import Problem Solving (Level 1) scores if intervention exists
    console.log('\n📅 Checking Problem Solving intervention...');
    const problemSolvingIntervention = await query(
      supabase
        .from('interventions')
        .select('id, name')
        .eq('term_id', termsMap['Level 1'].id)
        .ilike('name', '%problem%')
        .limit(1)
    );
    
    if (problemSolvingIntervention.rows && problemSolvingIntervention.rows.length > 0) {
      const level1File = path.join(excelDataPath, 'HPS Input Data - Level 1 updated.xlsx');
      if (fs.existsSync(level1File)) {
        const scores = await parseInterventionSheet(level1File, 'Problem Solving', problemSolvingIntervention.rows[0].name, studentsMap, termsMap['Level 1'], teacherId);
        allScores.push(...scores);
        console.log(`  ✅ Imported ${scores.length} Problem Solving scores`);
      }
    } else {
      console.log('  ⚠️  Problem Solving intervention not found in database');
    }
    
    // Import any remaining missing Wellness scores
    console.log('\n📅 Checking for missing Wellness scores...');
    const missingWellnessScores = await importMissingWellnessScores(excelDataPath, studentsMap, termsMap, teacherId);
    allScores.push(...missingWellnessScores);
    console.log(`  ✅ Imported ${missingWellnessScores.length} missing Wellness scores`);
    
    // Import scores
    if (allScores.length > 0) {
      console.log(`\n📤 Importing ${allScores.length} missing scores...`);
      
      const batchSize = 100;
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
      
      console.log(`\n✅ Successfully imported ${importedCount} missing scores!`);
    } else {
      console.log('\n✅ No missing scores to import!');
    }
    
    return { importedCount };
    
  } catch (error) {
    console.error('❌ Error importing missing scores:', error);
    throw error;
  }
}

/**
 * Import Fearless scores
 */
async function importFearlessScores(excelFile, studentsMap, term, teacherId) {
  const scores = [];
  
  try {
    const workbook = XLSX.readFile(excelFile);
    const ws = workbook.Sheets[workbook.SheetNames[0]];
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    // Get intervention
    const interventionResult = await query(
      supabase
        .from('interventions')
        .select('id, name')
        .eq('term_id', term.id)
        .ilike('name', '%fearless%')
        .limit(1)
    );
    
    if (!interventionResult.rows || interventionResult.rows.length === 0) {
      return scores;
    }
    
    const interventionId = interventionResult.rows[0].id;
    
    // Get microcompetencies
    const microcompsResult = await query(
      supabase
        .from('intervention_microcompetencies')
        .select('microcompetency_id, microcompetencies(id, name)')
        .eq('intervention_id', interventionId)
    );
    
    const microcompMap = {};
    microcompsResult.rows.forEach(im => {
      microcompMap[im.microcompetencies.name] = im.microcompetency_id;
    });
    
    // Parse Excel - structure depends on actual Excel format
    // This is a placeholder - would need to be customized based on actual structure
    
  } catch (error) {
    console.error(`Error importing Fearless scores: ${error.message}`);
  }
  
  return scores;
}

/**
 * Import missing Wellness scores
 */
async function importMissingWellnessScores(excelDataPath, studentsMap, termsMap, teacherId) {
  const scores = [];
  
  try {
    const excelPath = path.join(excelDataPath, 'HPS - Jagsom PEP Grade Updated.xlsx');
    const workbook = XLSX.readFile(excelPath);
    const ws = workbook.Sheets['Wellness'];
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
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
    
    const microcompOffsets = {
      'Level 0': 4,
      'Level 1': 11,
      'Level 2': 24,
      'Level 3': 31
    };
    
    const microcompNames = ['Push Ups', 'Sit Ups', 'Sit & reach', 'Beep test', '3KM Run', 'BCA'];
    const regNoCol = 1;
    
    // Check for missing scores
    for (const [termName, term] of Object.entries(termsMap)) {
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
      
      // Check which students are missing scores
      for (const student of Object.values(studentsMap)) {
        // Check if student has all Wellness scores
        const existingScoresResult = await query(
          supabase
            .from('microcompetency_scores')
            .select('microcompetency_id')
            .eq('student_id', student.id)
            .eq('intervention_id', wellnessInterventionId)
            .eq('status', 'Submitted')
        );
        
        const existingMcIds = new Set((existingScoresResult.rows || []).map(s => s.microcompetency_id));
        const neededMcIds = new Set(wellnessMicrocompsResult.rows.map(mc => mc.id));
        
        // Find missing microcompetencies
        const missingMcIds = [...neededMcIds].filter(id => !existingMcIds.has(id));
        
        if (missingMcIds.length > 0) {
          // Parse from Excel
          for (let rowIdx = 4; rowIdx < data.length; rowIdx++) {
            const row = data[rowIdx];
            if (!row || !row[regNoCol]) continue;
            
            const regNo = row[regNoCol].toString().trim();
            if (regNo !== student.registration_no) continue;
            
            // Extract scores for missing microcompetencies
            microcompNames.forEach((mcName, idx) => {
              const mcId = microcompMap[mcName];
              if (!missingMcIds.includes(mcId)) return;
              
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
                  // Normalize
                  let normalizedScore = scoreValue;
                  if (mcName === 'BCA' && scoreValue > 5) {
                    normalizedScore = (scoreValue / 100) * 5;
                  } else if (scoreValue > 5) {
                    normalizedScore = Math.min(scoreValue, 5);
                  }
                  normalizedScore = Math.max(0, Math.min(5, normalizedScore));
                  
                  scores.push({
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
                }
              }
            });
            
            break; // Found student, move to next
          }
        }
      }
    }
  } catch (error) {
    console.error(`Error importing missing Wellness scores: ${error.message}`);
  }
  
  return scores;
}

/**
 * Parse intervention sheet (reuse from parse_all_intervention_scores.js)
 */
async function parseInterventionSheet(excelFile, sheetName, interventionName, studentsMap, term, teacherId) {
  const scores = [];
  
  try {
    const workbook = XLSX.readFile(excelFile);
    const ws = workbook.Sheets[sheetName];
    if (!ws) return scores;
    
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    // Get intervention
    const interventionResult = await query(
      supabase
        .from('interventions')
        .select('id, name')
        .eq('term_id', term.id)
        .ilike('name', `%${interventionName}%`)
        .limit(1)
    );
    
    if (!interventionResult.rows || interventionResult.rows.length === 0) {
      return scores;
    }
    
    const interventionId = interventionResult.rows[0].id;
    
    // Get microcompetencies
    const microcompsResult = await query(
      supabase
        .from('intervention_microcompetencies')
        .select('microcompetency_id, microcompetencies(id, name)')
        .eq('intervention_id', interventionId)
    );
    
    const microcompMap = {};
    microcompsResult.rows.forEach(im => {
      microcompMap[im.microcompetencies.name] = im.microcompetency_id;
    });
    
    // Find registration number column
    let headerRow = data[0] || [];
    let subHeaderRow = data[1] || [];
    
    if (headerRow[0] && (headerRow[0].toString().toLowerCase().includes('sr') || 
                         headerRow[0].toString().toLowerCase().includes('roll'))) {
      subHeaderRow = headerRow;
      headerRow = data[1] || [];
    }
    
    let regNoCol = headerRow.findIndex(h => h && h.toString().toLowerCase().includes('rn'));
    if (regNoCol === -1) {
      regNoCol = headerRow.findIndex(h => h && h.toString().toLowerCase().includes('registration'));
    }
    if (regNoCol === -1) {
      regNoCol = headerRow.findIndex(h => h && h.toString().toLowerCase().includes('roll'));
    }
    if (regNoCol === -1) {
      regNoCol = 1;
    }
    
    // Find microcompetency columns
    const microcompCols = {};
    const searchRow = subHeaderRow.length > 0 ? subHeaderRow : headerRow;
    
    searchRow.forEach((h, idx) => {
      if (h) {
        const hStr = h.toString().trim();
        const normalizedHeader = hStr.replace(/\s*score\s*/i, '').trim();
        
        Object.keys(microcompMap).forEach(mcName => {
          const mcNameNormalized = mcName.replace(/\s+/g, '').toUpperCase();
          const headerNormalized = normalizedHeader.replace(/\s+/g, '').toUpperCase();
          
          if (mcNameNormalized === headerNormalized) {
            microcompCols[mcName] = idx;
          } else {
            const mcClean = mcNameNormalized.replace(/[^A-Z0-9]/g, '');
            const headerClean = headerNormalized.replace(/[^A-Z0-9]/g, '');
            if (mcClean === headerClean || 
                headerClean.includes(mcClean) ||
                mcClean.includes(headerClean)) {
              microcompCols[mcName] = idx;
            }
          }
        });
      }
    });
    
    const startRow = subHeaderRow.length > 0 ? 2 : 1;
    
    for (let rowIdx = startRow; rowIdx < data.length; rowIdx++) {
      const row = data[rowIdx];
      if (!row || !row[regNoCol]) continue;
      
      const regNo = row[regNoCol].toString().trim();
      const student = studentsMap[regNo];
      
      if (!student) continue;
      
      Object.entries(microcompCols).forEach(([mcName, colIdx]) => {
        let score = row[colIdx];
        
        if (typeof score === 'string') {
          score = score.trim();
        }
        
        const scoreNum = typeof score === 'number' ? score : parseFloat(score);
        
        if (score !== undefined && score !== null && !isNaN(scoreNum) && scoreNum >= 0) {
          scores.push({
            student_id: student.id,
            intervention_id: interventionId,
            microcompetency_id: microcompMap[mcName],
            obtained_score: scoreNum,
            max_score: 5,
            scored_by: teacherId,
            scored_at: new Date().toISOString(),
            feedback: '',
            status: 'Submitted',
            term_id: term.id
          });
        }
      });
    }
  } catch (error) {
    console.error(`Error parsing ${interventionName} from ${sheetName}: ${error.message}`);
  }
  
  return scores;
}

// Run if executed directly
if (require.main === module) {
  importMissingScores()
    .then(() => {
      console.log('\n✅ Missing score import completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Missing score import failed:', error);
      process.exit(1);
    });
}

module.exports = { importMissingScores };



