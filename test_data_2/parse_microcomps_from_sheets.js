const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

const results = {
  level1: {},
  level2: {},
  level3: {}
};

// Parse Level 1 - extract microcompetencies from each intervention sheet
console.log('📊 Parsing Level 1 microcompetencies from score sheets...');
try {
  const level1File = path.join(__dirname, 'HPS Input Data - Level 1 updated.xlsx');
  const workbook = XLSX.readFile(level1File);
  
  const interventionSheets = ['Story Telling', 'Book Review Presentation', 'Inter personal', 
    'Business Proposal Report', 'Email Writing', 'Problem Solving', 'Debating', 'Capstone'];
  
  interventionSheets.forEach(sheetName => {
    if (!workbook.SheetNames.includes(sheetName)) return;
    
    const sheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });
    
    if (data.length < 2) return;
    
    // Row 1 (index 1) contains microcompetency codes
    const microcomps = [];
    const headerRow = data[1] || [];
    headerRow.forEach(cell => {
      if (cell && typeof cell === 'string') {
        const match = cell.trim().match(/^([A-Z]\s*\d+)$/);
        if (match) {
          microcomps.push(match[1].replace(/\s+/g, ''));
        }
      }
    });
    
    const interventionName = sheetName === 'Story Telling' ? 'Storytelling Presentation' :
                            sheetName === 'Problem Solving' ? 'Case Study Analysis' :
                            sheetName === 'Inter personal' ? 'Interpersonal Role Play' :
                            sheetName;
    
    results.level1[interventionName] = microcomps;
    console.log(`  ${interventionName}: ${microcomps.length} microcompetencies`);
  });
} catch (error) {
  console.error('  Error:', error.message);
}

// Parse Level 2
console.log('\n📊 Parsing Level 2 microcompetencies...');
try {
  const level2File = path.join(__dirname, 'HPS Input Data - Level 2 updated.xlsx');
  const workbook = XLSX.readFile(level2File);
  
  const interventionSheets = ['Review 1', 'Review 2', 'Review 3', 'Review 4', 
    'Reflection -1 ', 'Reflection -2', 'Reflection -3', 'Reflection -4', 'Capstone'];
  
  interventionSheets.forEach(sheetName => {
    if (!workbook.SheetNames.includes(sheetName)) return;
    
    const sheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });
    
    if (data.length < 2) return;
    
    const microcomps = [];
    const headerRow = data[1] || [];
    headerRow.forEach(cell => {
      if (cell && typeof cell === 'string') {
        const match = cell.trim().match(/^([A-Z]\s*\d+)$/);
        if (match) {
          microcomps.push(match[1].replace(/\s+/g, ''));
        }
      }
    });
    
    results.level2[sheetName] = microcomps;
    console.log(`  ${sheetName}: ${microcomps.length} microcompetencies`);
  });
} catch (error) {
  console.error('  Error:', error.message);
}

// Parse Level 3
console.log('\n📊 Parsing Level 3 microcompetencies...');
try {
  const level3File = path.join(__dirname, 'HPS Input Data - Level 3 updated.xlsx');
  const workbook = XLSX.readFile(level3File);
  
  const interventionSheets = ['Book Review', 'Debate', 'GD', 'Case study', 'Capstone'];
  
  interventionSheets.forEach(sheetName => {
    if (!workbook.SheetNames.includes(sheetName)) return;
    
    const sheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });
    
    if (data.length < 2) return;
    
    const microcomps = [];
    const headerRow = data[1] || [];
    headerRow.forEach(cell => {
      if (cell && typeof cell === 'string') {
        const match = cell.trim().match(/^([A-Z]\s*\d+)$/);
        if (match) {
          microcomps.push(match[1].replace(/\s+/g, ''));
        }
      }
    });
    
    results.level3[sheetName] = microcomps;
    console.log(`  ${sheetName}: ${microcomps.length} microcompetencies`);
  });
} catch (error) {
  console.error('  Error:', error.message);
}

// Save results
const outputPath = path.join(__dirname, 'microcompetencies_by_level.json');
fs.writeFileSync(outputPath, JSON.stringify(results, null, 2));
console.log(`\n✅ Results saved to: ${outputPath}`);

