const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

// This script will parse all Excel sheets and extract student scores
// Then generate SQL statements for inserting scores

const termMapping = {
  'Level 0': 'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8',
  'Level 1': 'ea9a7617-a53e-421f-bf8b-13a0fb908b55',
  'Level 2': 'b92e022b-078e-45ee-aff3-c1c6761fb17e',
  'Level 3': '4f49e30e-27df-47b8-bede-e0c0c2a988dc'
};

const teacherId = '1a1aa901-d33c-4cf5-adae-c205677c6bc3';
const maxScore = 5;

const allScores = [];

// Parse Level 0 scores
console.log('📊 Parsing Level 0 scores...');
try {
  const level0File = path.join(__dirname, 'Level 0 - Interventions.xlsx');
  const workbook = XLSX.readFile(level0File);
  const sheet = workbook.Sheets[workbook.SheetNames[0]];
  const data = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });
  
  // Find microcompetency codes in header (row 1)
  const headerRow = data[1] || [];
  const microcompColumns = [];
  headerRow.forEach((cell, colIndex) => {
    if (cell && typeof cell === 'string') {
      const match = cell.trim().match(/^([D]\s*\d+)$/);
      if (match) {
        microcompColumns.push({
          colIndex,
          code: match[1].replace(/\s+/g, '')
        });
      }
    }
  });
  
  console.log(`  Found ${microcompColumns.length} microcompetency columns`);
  
  // Parse student scores (starting from row 2)
  for (let rowIndex = 2; rowIndex < data.length; rowIndex++) {
    const row = data[rowIndex];
    if (!row || !row[3]) continue; // Skip empty rows (registration number is in column 3)
    
    const registrationNo = String(row[3] || '').trim();
    if (!registrationNo || !registrationNo.startsWith('2024JULB')) continue;
    
    microcompColumns.forEach(({ colIndex, code }) => {
      const score = row[colIndex];
      if (score !== null && score !== undefined && score !== '') {
        const scoreValue = parseFloat(score);
        if (!isNaN(scoreValue)) {
          allScores.push({
            level: 'Level 0',
            intervention: 'Fearless (Level 0)',
            registrationNo,
            microcompetency: code,
            score: scoreValue
          });
        }
      }
    });
  }
  
  console.log(`  Parsed ${allScores.length} Level 0 scores`);
} catch (error) {
  console.error('  Error parsing Level 0:', error.message);
}

// Parse Level 1 scores (we already have student_scores_final.json for this)
console.log('\n📊 Loading Level 1 scores from existing JSON...');
try {
  const level1Scores = JSON.parse(fs.readFileSync(path.join(__dirname, 'student_scores_final.json'), 'utf8'));
  
  level1Scores.students.forEach(student => {
    student.interventions.forEach(intervention => {
      Object.entries(intervention.microcompetency_scores).forEach(([microcomp, score]) => {
        allScores.push({
          level: 'Level 1',
          intervention: intervention.intervention_name,
          registrationNo: student.registration_no,
          microcompetency: microcomp,
          score: parseFloat(score) || 0
        });
      });
    });
  });
  
  console.log(`  Loaded Level 1 scores: ${allScores.filter(s => s.level === 'Level 1').length} scores`);
} catch (error) {
  console.error('  Error loading Level 1:', error.message);
}

// Parse Level 2 scores
console.log('\n📊 Parsing Level 2 scores...');
try {
  const level2File = path.join(__dirname, 'HPS Input Data - Level 2 updated.xlsx');
  const workbook = XLSX.readFile(level2File);
  
  const interventionSheets = ['Review 1', 'Review 2', 'Review 3', 'Review 4', 
    'Reflection -1 ', 'Reflection -2', 'Reflection -3', 'Reflection -4', 'Capstone'];
  
  interventionSheets.forEach(sheetName => {
    if (!workbook.SheetNames.includes(sheetName)) return;
    
    const sheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });
    
    if (data.length < 3) return;
    
    // Find microcompetency columns
    const headerRow = data[1] || [];
    const microcompColumns = [];
    headerRow.forEach((cell, colIndex) => {
      if (cell && typeof cell === 'string') {
        const match = cell.trim().match(/^([A-Z]\s*\d+)$/);
        if (match) {
          microcompColumns.push({
            colIndex,
            code: match[1].replace(/\s+/g, '')
          });
        }
      }
    });
    
    // Parse student scores
    for (let rowIndex = 2; rowIndex < data.length; rowIndex++) {
      const row = data[rowIndex];
      if (!row || !row[1]) continue;
      
      const registrationNo = String(row[1] || '').trim();
      if (!registrationNo || !registrationNo.startsWith('2024JULB')) continue;
      
      microcompColumns.forEach(({ colIndex, code }) => {
        const score = row[colIndex];
        if (score !== null && score !== undefined && score !== '') {
          const scoreValue = parseFloat(score);
          if (!isNaN(scoreValue)) {
            allScores.push({
              level: 'Level 2',
              intervention: sheetName,
              registrationNo,
              microcompetency: code,
              score: scoreValue
            });
          }
        }
      });
    }
  });
  
  console.log(`  Parsed Level 2 scores: ${allScores.filter(s => s.level === 'Level 2').length} scores`);
} catch (error) {
  console.error('  Error parsing Level 2:', error.message);
}

// Parse Level 3 scores
console.log('\n📊 Parsing Level 3 scores...');
try {
  const level3File = path.join(__dirname, 'HPS Input Data - Level 3 updated.xlsx');
  const workbook = XLSX.readFile(level3File);
  
  const interventionSheets = ['Book Review', 'Debate', 'GD', 'Case study', 'Capstone'];
  
  interventionSheets.forEach(sheetName => {
    if (!workbook.SheetNames.includes(sheetName)) return;
    
    const sheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });
    
    if (data.length < 3) return;
    
    const headerRow = data[1] || [];
    const microcompColumns = [];
    headerRow.forEach((cell, colIndex) => {
      if (cell && typeof cell === 'string') {
        const match = cell.trim().match(/^([A-Z]\s*\d+)$/);
        if (match) {
          microcompColumns.push({
            colIndex,
            code: match[1].replace(/\s+/g, '')
          });
        }
      }
    });
    
    for (let rowIndex = 2; rowIndex < data.length; rowIndex++) {
      const row = data[rowIndex];
      if (!row || !row[1]) continue;
      
      const registrationNo = String(row[1] || '').trim();
      if (!registrationNo || !registrationNo.startsWith('2024JULB')) continue;
      
      microcompColumns.forEach(({ colIndex, code }) => {
        const score = row[colIndex];
        if (score !== null && score !== undefined && score !== '') {
          const scoreValue = parseFloat(score);
          if (!isNaN(scoreValue)) {
            allScores.push({
              level: 'Level 3',
              intervention: sheetName,
              registrationNo,
              microcompetency: code,
              score: scoreValue
            });
          }
        }
      });
    }
  });
  
  console.log(`  Parsed Level 3 scores: ${allScores.filter(s => s.level === 'Level 3').length} scores`);
} catch (error) {
  console.error('  Error parsing Level 3:', error.message);
}

// Save parsed scores
const outputPath = path.join(__dirname, 'all_levels_scores.json');
fs.writeFileSync(outputPath, JSON.stringify(allScores, null, 2));
console.log(`\n✅ All scores parsed and saved to: ${outputPath}`);
console.log(`\n📊 Total scores parsed: ${allScores.length}`);

// Summary by level
const summary = {};
allScores.forEach(score => {
  if (!summary[score.level]) {
    summary[score.level] = {};
  }
  if (!summary[score.level][score.intervention]) {
    summary[score.level][score.intervention] = 0;
  }
  summary[score.level][score.intervention]++;
});

console.log('\n📋 Summary by Level:');
Object.keys(summary).forEach(level => {
  console.log(`\n${level}:`);
  Object.entries(summary[level]).forEach(([intervention, count]) => {
    console.log(`  ${intervention}: ${count} scores`);
  });
});

