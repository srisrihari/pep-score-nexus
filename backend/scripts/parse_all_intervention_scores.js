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
 * Parse scores for all interventions from Excel sheets
 */
async function parseAllInterventionScores() {
  try {
    console.log('\n📊 Parsing All Intervention Scores from Excel\n');
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
    const summary = {};
    
    // Process Level 0 interventions
    console.log('\n📅 Processing Level 0 Interventions');
    await processLevel0Interventions(excelDataPath, studentsMap, termsMap['Level 0'], teacherId, allScores, summary);
    
    // Process Level 1 interventions
    console.log('\n📅 Processing Level 1 Interventions');
    await processLevel1Interventions(excelDataPath, studentsMap, termsMap['Level 1'], teacherId, allScores, summary);
    
    // Process Level 2 interventions
    console.log('\n📅 Processing Level 2 Interventions');
    await processLevel2Interventions(excelDataPath, studentsMap, termsMap['Level 2'], teacherId, allScores, summary);
    
    // Process Level 3 interventions
    console.log('\n📅 Processing Level 3 Interventions');
    await processLevel3Interventions(excelDataPath, studentsMap, termsMap['Level 3'], teacherId, allScores, summary);
    
    console.log(`\n📝 Total scores parsed: ${allScores.length}`);
    console.log('\n📊 Summary by Intervention:');
    Object.entries(summary).forEach(([intervention, count]) => {
      console.log(`  ${intervention}: ${count} scores`);
    });
    
    // Import scores in batches
    if (allScores.length > 0) {
      console.log(`\n📤 Importing ${allScores.length} scores...`);
      
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
      
      console.log(`\n✅ Successfully imported ${importedCount} scores!`);
    }
    
    return { importedCount: allScores.length, summary };
    
  } catch (error) {
    console.error('❌ Error parsing intervention scores:', error);
    throw error;
  }
}

/**
 * Process Level 0 interventions
 */
async function processLevel0Interventions(excelDataPath, studentsMap, term, teacherId, allScores, summary) {
  // Level 0 Capstone
  const capstoneFile = path.join(excelDataPath, 'Level 0 Capstone(1).xlsx');
  if (fs.existsSync(capstoneFile)) {
    const scores = await parseCapstoneScores(capstoneFile, 'Level 0', studentsMap, term, teacherId);
    allScores.push(...scores);
    summary['Capstone (Level 0)'] = scores.length;
    console.log(`  ✅ Capstone (Level 0): ${scores.length} scores`);
  }
  
  // Level 0 Fearless (from Level 0 - Interventions.xlsx)
  const interventionsFile = path.join(excelDataPath, 'Level 0 - Interventions.xlsx');
  if (fs.existsSync(interventionsFile)) {
    const scores = await parseFearlessScores(interventionsFile, studentsMap, term, teacherId);
    allScores.push(...scores);
    summary['Fearless (Level 0)'] = scores.length;
    console.log(`  ✅ Fearless (Level 0): ${scores.length} scores`);
  }
}

/**
 * Process Level 1 interventions
 */
async function processLevel1Interventions(excelDataPath, studentsMap, term, teacherId, allScores, summary) {
  const level1File = path.join(excelDataPath, 'HPS Input Data - Level 1 updated.xlsx');
  if (!fs.existsSync(level1File)) {
    console.log('  ⚠️  Level 1 Excel file not found');
    return;
  }
  
  const workbook = XLSX.readFile(level1File);
  const sheetNames = workbook.SheetNames;
  
  // Get actual intervention names from database
  const dbInterventionsResult = await query(
    supabase
      .from('interventions')
      .select('id, name')
      .eq('term_id', term.id)
  );
  
  const dbInterventionMap = {};
  dbInterventionsResult.rows.forEach(i => {
    dbInterventionMap[i.name.toLowerCase()] = i;
  });
  
  // Map sheet names to intervention names (fuzzy matching)
  const interventionMap = {};
  sheetNames.forEach(sheetName => {
    const sheetLower = sheetName.toLowerCase();
    // Try to find matching intervention
    Object.keys(dbInterventionMap).forEach(dbName => {
      // Check if sheet name matches intervention name
      if (dbName.includes(sheetLower) || sheetLower.includes(dbName) ||
          sheetName.toLowerCase().replace(/\s+/g, '') === dbName.replace(/\s+/g, '')) {
        interventionMap[sheetName] = dbInterventionMap[dbName].name;
      }
    });
    
    // Manual mappings for known cases
    if (sheetName === 'Story Telling' && !interventionMap[sheetName]) {
      interventionMap[sheetName] = 'Storytelling Presentation';
    }
    if (sheetName === 'Inter personal' && !interventionMap[sheetName]) {
      interventionMap[sheetName] = 'Interpersonal Role Play';
    }
  });
  
  console.log(`  📋 Found ${Object.keys(interventionMap).length} matching interventions`);
  Object.entries(interventionMap).forEach(([sheet, intervention]) => {
    console.log(`    ${sheet} → ${intervention}`);
  });
  
  for (const sheetName of sheetNames) {
    // Skip non-intervention sheets
    if (['Interventions', 'Working', 'Sheet5', 'Term Rating Persona'].includes(sheetName)) {
      continue;
    }
    
    const interventionName = interventionMap[sheetName];
    if (!interventionName) {
      console.log(`  ⚠️  No matching intervention found for sheet: ${sheetName}`);
      continue;
    }
    
    try {
      const scores = await parseInterventionSheet(level1File, sheetName, interventionName, studentsMap, term, teacherId);
      if (scores.length > 0) {
        allScores.push(...scores);
        summary[interventionName] = scores.length;
        console.log(`  ✅ ${interventionName}: ${scores.length} scores`);
      } else {
        console.log(`  ⚠️  ${interventionName}: No scores parsed`);
      }
    } catch (error) {
      console.error(`  ❌ Error parsing ${interventionName}:`, error.message);
    }
  }
}

/**
 * Process Level 2 interventions
 */
async function processLevel2Interventions(excelDataPath, studentsMap, term, teacherId, allScores, summary) {
  const level2File = path.join(excelDataPath, 'HPS Input Data - Level 2 updated.xlsx');
  if (!fs.existsSync(level2File)) {
    console.log('  ⚠️  Level 2 Excel file not found');
    return;
  }
  
  const workbook = XLSX.readFile(level2File);
  const sheetNames = workbook.SheetNames;
  
  // Map sheet names to intervention names
  const interventionMap = {
    'Review 1': 'Review 1',
    'Review 2': 'Review 2',
    'Review 3': 'Review 3',
    'Review 4': 'Review 4',
    'Reflection -1 ': 'Reflection 1',
    'Reflection -2': 'Reflection 2',
    'Reflection -3': 'Reflection 3',
    'Reflection -4': 'Reflection 4',
    'Capstone': 'Capstone'
  };
  
  for (const sheetName of sheetNames) {
    const interventionName = interventionMap[sheetName];
    if (!interventionName) continue;
    
    try {
      const scores = await parseInterventionSheet(level2File, sheetName, interventionName, studentsMap, term, teacherId);
      if (scores.length > 0) {
        allScores.push(...scores);
        summary[interventionName] = scores.length;
        console.log(`  ✅ ${interventionName}: ${scores.length} scores`);
      }
    } catch (error) {
      console.error(`  ❌ Error parsing ${interventionName}:`, error.message);
    }
  }
}

/**
 * Process Level 3 interventions
 */
async function processLevel3Interventions(excelDataPath, studentsMap, term, teacherId, allScores, summary) {
  const level3File = path.join(excelDataPath, 'HPS Input Data - Level 3 updated.xlsx');
  if (!fs.existsSync(level3File)) {
    console.log('  ⚠️  Level 3 Excel file not found');
    return;
  }
  
  const workbook = XLSX.readFile(level3File);
  const sheetNames = workbook.SheetNames;
  
  // Map sheet names to intervention names
  const interventionMap = {
    'Book Review': 'Book Review',
    'Debate': 'Debate',
    'GD': 'GD',
    'Case study': 'Case study',
    'Capstone': 'Capstone'
  };
  
  for (const sheetName of sheetNames) {
    const interventionName = interventionMap[sheetName];
    if (!interventionName) continue;
    
    try {
      const scores = await parseInterventionSheet(level3File, sheetName, interventionName, studentsMap, term, teacherId);
      if (scores.length > 0) {
        allScores.push(...scores);
        summary[interventionName] = scores.length;
        console.log(`  ✅ ${interventionName}: ${scores.length} scores`);
      }
    } catch (error) {
      console.error(`  ❌ Error parsing ${interventionName}:`, error.message);
    }
  }
}

/**
 * Parse Capstone scores
 */
async function parseCapstoneScores(excelFile, levelName, studentsMap, term, teacherId) {
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
        .ilike('name', `%capstone%${levelName}%`)
        .limit(1)
    );
    
    if (!interventionResult.rows || interventionResult.rows.length === 0) {
      return scores;
    }
    
    const interventionId = interventionResult.rows[0].id;
    
    // Find registration number column
    const headerRow = data[0] || [];
    let regNoCol = headerRow.findIndex(h => h && h.toString().toLowerCase().includes('rn'));
    if (regNoCol === -1) {
      regNoCol = headerRow.findIndex(h => h && h.toString().toLowerCase().includes('registration'));
    }
    if (regNoCol === -1) {
      regNoCol = headerRow.findIndex(h => h && h.toString().toLowerCase().includes('roll'));
    }
    
    if (regNoCol === -1) {
      console.log('    ⚠️  Registration number column not found');
      return scores;
    }
    
    // Get microcompetencies for this intervention
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
    
    // Find microcompetency columns
    // Handle format like "A4 Score", "C2 Score" or "A 1", "A 2"
    const microcompCols = {};
    headerRow.forEach((h, idx) => {
      if (h) {
        const hStr = h.toString().trim();
        // Remove "Score" suffix and normalize
        const normalizedHeader = hStr.replace(/\s*score\s*/i, '').trim();
        
        Object.keys(microcompMap).forEach(mcName => {
          // Try exact match first
          if (normalizedHeader === mcName || hStr === mcName) {
            microcompCols[mcName] = idx;
          }
          // Try partial match (handle "A4" vs "A4 Score")
          else {
            const mcNameNormalized = mcName.replace(/\s+/g, '');
            const headerNormalized = normalizedHeader.replace(/\s+/g, '');
            if (mcNameNormalized === headerNormalized || 
                headerNormalized.includes(mcNameNormalized) ||
                mcNameNormalized.includes(headerNormalized)) {
              microcompCols[mcName] = idx;
            }
          }
        });
      }
    });
    
    console.log(`    Found ${Object.keys(microcompCols).length} microcompetency columns:`, Object.keys(microcompCols));
    
    // Parse scores (start from row 1)
    for (let rowIdx = 1; rowIdx < data.length; rowIdx++) {
      const row = data[rowIdx];
      if (!row || !row[regNoCol]) continue;
      
      const regNo = row[regNoCol].toString().trim();
      const student = studentsMap[regNo];
      
      if (!student) continue;
      
      Object.entries(microcompCols).forEach(([mcName, colIdx]) => {
        let score = row[colIdx];
        
        // Handle string scores with spaces
        if (typeof score === 'string') {
          score = score.trim();
        }
        
        // Parse score
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
    console.error(`Error parsing Capstone scores: ${error.message}`);
  }
  
  return scores;
}

/**
 * Parse Fearless scores
 */
async function parseFearlessScores(excelFile, studentsMap, term, teacherId) {
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
    
    // Similar parsing logic as Capstone
    // Implementation depends on Excel structure
    
  } catch (error) {
    console.error(`Error parsing Fearless scores: ${error.message}`);
  }
  
  return scores;
}

/**
 * Parse intervention sheet (generic parser for Level 1, 2, 3 interventions)
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
    // Check row 0 first, then row 1
    let headerRow = data[0] || [];
    let subHeaderRow = data[1] || [];
    
    // If row 0 has "Sr#", "Roll Number", etc., use row 1 for microcompetencies
    if (headerRow[0] && (headerRow[0].toString().toLowerCase().includes('sr') || 
                         headerRow[0].toString().toLowerCase().includes('roll'))) {
      // Row 0 is main header, row 1 has microcompetency codes
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
      regNoCol = 1; // Usually column 1
    }
    
    // Find microcompetency columns
    // Check subHeaderRow first (row 1 usually has codes like "A 1", "A 2")
    const microcompCols = {};
    
    // Try both headerRow and subHeaderRow
    [subHeaderRow, headerRow].forEach((searchRow, rowIdx) => {
      if (searchRow.length === 0) return;
      
      searchRow.forEach((h, idx) => {
        if (h && !microcompCols[h]) { // Don't overwrite if already found
          const hStr = h.toString().trim();
          // Remove "Score" suffix if present
          const normalizedHeader = hStr.replace(/\s*score\s*/i, '').trim();
          
          Object.keys(microcompMap).forEach(mcName => {
            // Normalize both for comparison
            const mcNameNormalized = mcName.replace(/\s+/g, '').toUpperCase();
            const headerNormalized = normalizedHeader.replace(/\s+/g, '').toUpperCase();
            
            // Try exact match
            if (mcNameNormalized === headerNormalized) {
              microcompCols[mcName] = idx;
            }
            // Try partial match (handle "A1" vs "A 1", "A 1" vs "A1")
            else {
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
    });
    
    console.log(`    Found ${Object.keys(microcompCols).length} microcompetency columns:`, Object.keys(microcompCols).slice(0, 10));
    
    // Parse scores (start from row 2 if we have subheaders, else row 1)
    const startRow = subHeaderRow.length > 0 ? 2 : 1;
    
    for (let rowIdx = startRow; rowIdx < data.length; rowIdx++) {
      const row = data[rowIdx];
      if (!row || !row[regNoCol]) continue;
      
      const regNo = row[regNoCol].toString().trim();
      const student = studentsMap[regNo];
      
      if (!student) continue;
      
      Object.entries(microcompCols).forEach(([mcName, colIdx]) => {
        let score = row[colIdx];
        
        // Handle string scores with spaces
        if (typeof score === 'string') {
          score = score.trim();
        }
        
        // Parse score
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
  parseAllInterventionScores()
    .then(() => {
      console.log('\n✅ Intervention score parsing completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Intervention score parsing failed:', error);
      process.exit(1);
    });
}

module.exports = { parseAllInterventionScores };

