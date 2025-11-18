const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

const results = {
  level2: {},
  level3: {}
};

// Parse Level 2 - check which microcompetency columns actually have scores
console.log('📊 Parsing Level 2 microcompetencies (checking for actual scores)...');
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
    
    // Row 1 (index 1) contains microcompetency codes
    const headerRow = data[1] || [];
    const microcomps = [];
    
    // Check each column - if it has a microcompetency code AND has scores in student rows
    headerRow.forEach((cell, colIndex) => {
      if (cell && typeof cell === 'string') {
        const match = cell.trim().match(/^([A-Z]\s*\d+)$/);
        if (match) {
          const microcompCode = match[1].replace(/\s+/g, '');
          
          // Check if this column has any non-null scores in student rows (row 2+)
          let hasScores = false;
          for (let rowIndex = 2; rowIndex < Math.min(15, data.length); rowIndex++) {
            const score = data[rowIndex]?.[colIndex];
            if (score !== null && score !== undefined && score !== '') {
              hasScores = true;
              break;
            }
          }
          
          if (hasScores) {
            microcomps.push(microcompCode);
          }
        }
      }
    });
    
    results.level2[sheetName] = microcomps;
    console.log(`  ${sheetName}: ${microcomps.length} microcompetencies with scores`);
  });
} catch (error) {
  console.error('  Error:', error.message);
}

// Parse Level 3
console.log('\n📊 Parsing Level 3 microcompetencies (checking for actual scores)...');
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
    const microcomps = [];
    
    headerRow.forEach((cell, colIndex) => {
      if (cell && typeof cell === 'string') {
        const match = cell.trim().match(/^([A-Z]\s*\d+)$/);
        if (match) {
          const microcompCode = match[1].replace(/\s+/g, '');
          
          let hasScores = false;
          for (let rowIndex = 2; rowIndex < Math.min(15, data.length); rowIndex++) {
            const score = data[rowIndex]?.[colIndex];
            if (score !== null && score !== undefined && score !== '') {
              hasScores = true;
              break;
            }
          }
          
          if (hasScores) {
            microcomps.push(microcompCode);
          }
        }
      }
    });
    
    results.level3[sheetName] = microcomps;
    console.log(`  ${sheetName}: ${microcomps.length} microcompetencies with scores`);
  });
} catch (error) {
  console.error('  Error:', error.message);
}

// Save results
const outputPath = path.join(__dirname, 'microcompetencies_with_scores.json');
fs.writeFileSync(outputPath, JSON.stringify(results, null, 2));
console.log(`\n✅ Results saved to: ${outputPath}`);

