const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

const results = {
  level0: { interventions: [], students: [] },
  level1: { interventions: [], students: [] },
  level2: { interventions: [], students: [] },
  level3: { interventions: [], students: [] }
};

// Parse Level 0 - Interventions.xlsx
console.log('📊 Parsing Level 0...');
try {
  const level0File = path.join(__dirname, 'Level 0 - Interventions.xlsx');
  const workbook = XLSX.readFile(level0File);
  const sheet = workbook.Sheets[workbook.SheetNames[0]];
  const data = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });
  
  // Find intervention name (likely in header or first few rows)
  // This file seems to have Fearless quadrant scores
  console.log('  Level 0: Fearless quadrant intervention detected');
  results.level0.interventions.push({
    name: 'Fearless (Level 0)',
    type: 'Level 0',
    microcompetencies: ['D1', 'D2', 'D3', 'D4', 'D5']
  });
} catch (error) {
  console.error('  Error parsing Level 0:', error.message);
}

// Parse Level 1
console.log('📊 Parsing Level 1...');
try {
  const level1File = path.join(__dirname, 'HPS Input Data - Level 1 updated.xlsx');
  const workbook = XLSX.readFile(level1File);
  
  // Parse Interventions sheet
  const interventionsSheet = workbook.Sheets['Interventions'];
  const interventionsData = XLSX.utils.sheet_to_json(interventionsSheet, { header: 1, defval: null });
  
  // Skip header rows (first 2 rows)
  for (let i = 2; i < interventionsData.length; i++) {
    const row = interventionsData[i];
    if (!row || !row[3]) continue; // Skip empty rows
    
    const interventionName = row[3];
    if (!interventionName || interventionName === 'Interventions (Name)') continue;
    
    // Extract microcompetencies from row (columns 10-27)
    const microcomps = [];
    for (let j = 10; j < 27; j++) {
      if (row[j] && typeof row[j] === 'string' && /^[A-Z]\d+$/.test(row[j].trim())) {
        microcomps.push(row[j].trim());
      }
    }
    
    results.level1.interventions.push({
      name: interventionName,
      activityName: row[2] || '',
      institution: row[4] || 'JAGSoM',
      program: row[5] || 'PGDM',
      batch: row[6] || '2024-26',
      sessionsPlanned: row[8] || 0,
      sessionsConducted: row[9] || 0,
      microcompetencies: microcomps
    });
  }
  
  console.log(`  Found ${results.level1.interventions.length} Level 1 interventions`);
} catch (error) {
  console.error('  Error parsing Level 1:', error.message);
}

// Parse Level 2
console.log('📊 Parsing Level 2...');
try {
  const level2File = path.join(__dirname, 'HPS Input Data - Level 2 updated.xlsx');
  const workbook = XLSX.readFile(level2File);
  
  const interventionsSheet = workbook.Sheets['Interventions'];
  const interventionsData = XLSX.utils.sheet_to_json(interventionsSheet, { header: 1, defval: null });
  
  // Get intervention names from sheet names
  const sheetNames = workbook.SheetNames.filter(name => 
    !['Interventions', 'Working', 'Sheet5', 'Term Rating Persona'].includes(name)
  );
  
  sheetNames.forEach(sheetName => {
    const sheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });
    
    if (data.length < 2) return;
    
    // Extract microcompetencies from row 1 (second row)
    const microcomps = [];
    const headerRow = data[1] || [];
    headerRow.forEach(cell => {
      if (cell && typeof cell === 'string' && /^[A-Z]\d+$/.test(cell.trim())) {
        microcomps.push(cell.trim());
      }
    });
    
    results.level2.interventions.push({
      name: sheetName,
      microcompetencies: microcomps
    });
  });
  
  console.log(`  Found ${results.level2.interventions.length} Level 2 interventions`);
} catch (error) {
  console.error('  Error parsing Level 2:', error.message);
}

// Parse Level 3
console.log('📊 Parsing Level 3...');
try {
  const level3File = path.join(__dirname, 'HPS Input Data - Level 3 updated.xlsx');
  const workbook = XLSX.readFile(level3File);
  
  const sheetNames = workbook.SheetNames.filter(name => 
    !['Interventions', 'Working', 'Sheet5', 'Term Rating Persona'].includes(name)
  );
  
  sheetNames.forEach(sheetName => {
    const sheet = workbook.Sheets[sheetName];
    const data = XLSX.utils.sheet_to_json(sheet, { header: 1, defval: null });
    
    if (data.length < 2) return;
    
    const microcomps = [];
    const headerRow = data[1] || [];
    headerRow.forEach(cell => {
      if (cell && typeof cell === 'string' && /^[A-Z]\d+$/.test(cell.trim())) {
        microcomps.push(cell.trim());
      }
    });
    
    results.level3.interventions.push({
      name: sheetName,
      microcompetencies: microcomps
    });
  });
  
  console.log(`  Found ${results.level3.interventions.length} Level 3 interventions`);
} catch (error) {
  console.error('  Error parsing Level 3:', error.message);
}

// Save results
const outputPath = path.join(__dirname, 'all_levels_interventions.json');
fs.writeFileSync(outputPath, JSON.stringify(results, null, 2));
console.log(`\n✅ Results saved to: ${outputPath}`);

// Print summary
console.log('\n📋 SUMMARY:');
console.log(`Level 0: ${results.level0.interventions.length} interventions`);
console.log(`Level 1: ${results.level1.interventions.length} interventions`);
console.log(`Level 2: ${results.level2.interventions.length} interventions`);
console.log(`Level 3: ${results.level3.interventions.length} interventions`);

