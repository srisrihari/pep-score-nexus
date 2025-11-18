const xlsx = require('xlsx');
const path = require('path');
const fs = require('fs');

// Path to the Excel file
const excelFilePath = path.join(__dirname, '../../test_data_2/HPS Input Data - Level 1 updated.xlsx');

console.log('📊 Reading Excel file:', excelFilePath);
console.log('='.repeat(80));

try {
  // Read the Excel file
  const workbook = xlsx.readFile(excelFilePath);
  
  // Expected student registration numbers
  const expectedStudents = [
    '2024JULB00001', '2024JULB00002', '2024JULB00003', '2024JULB00004', 
    '2024JULB00005', '2024JULB00006', '2024JULB00007', '2024JULB00008', 
    '2024JULB00009', '2024JULB00012'
  ];
  
  // Map sheet names to intervention names
  const sheetToIntervention = {
    'Story Telling': 'Storytelling Presentation',
    'Book Review Presentation': 'Book Review Presentation',
    'Inter personal': 'Interpersonal Role Play',
    'Business Proposal Report': 'Business Proposal Report',
    'Email Writing': 'Email Writing',
    'Problem Solving': 'Case Study Analysis', // Note: Excel has "Problem Solving" but we created "Case Study Analysis"
    'Debating': 'Debating',
    'Capstone': 'Capstone' // This might not be in our interventions list
  };
  
  // Store all scores
  const allScores = {};
  
  // Process sheets that contain student scores
  const scoreSheets = ['Story Telling', 'Book Review Presentation', 'Inter personal', 
                       'Business Proposal Report', 'Email Writing', 'Problem Solving', 
                       'Debating', 'Capstone'];
  
  scoreSheets.forEach((sheetName) => {
    console.log(`\n${'='.repeat(80)}`);
    console.log(`📄 Processing Sheet: ${sheetName}`);
    console.log('='.repeat(80));
    
    const worksheet = workbook.Sheets[sheetName];
    if (!worksheet) {
      console.log('⚠️  Sheet not found');
      return;
    }
    
    // Read as array of arrays to preserve cell positions
    const range = xlsx.utils.decode_range(worksheet['!ref']);
    const data = [];
    
    for (let row = range.s.r; row <= range.e.r; row++) {
      const rowData = [];
      for (let col = range.s.c; col <= range.e.c; col++) {
        const cellAddress = xlsx.utils.encode_cell({ r: row, c: col });
        const cell = worksheet[cellAddress];
        rowData.push(cell ? cell.v : null);
      }
      data.push(rowData);
    }
    
    // Also read as JSON for easier processing
    const jsonData = xlsx.utils.sheet_to_json(worksheet, { defval: null, header: 1 });
    
    console.log(`📊 Sheet dimensions: ${jsonData.length} rows x ${jsonData[0]?.length || 0} columns`);
    
    // Find header row (usually row 0 or 1)
    let headerRow = -1;
    let rollNoCol = -1;
    let nameCol = -1;
    
    for (let i = 0; i < Math.min(5, jsonData.length); i++) {
      const row = jsonData[i];
      if (row && row.length > 0) {
        // Look for "Roll Number" or registration number pattern
        const rollIndex = row.findIndex(cell => 
          cell && String(cell).toLowerCase().includes('roll')
        );
        const nameIndex = row.findIndex(cell => 
          cell && String(cell).toLowerCase() === 'name'
        );
        
        if (rollIndex >= 0 && nameIndex >= 0) {
          headerRow = i;
          rollNoCol = rollIndex;
          nameCol = nameIndex;
          console.log(`✅ Found header row at index ${i}`);
          console.log(`   Roll Number column: ${rollNoCol}`);
          console.log(`   Name column: ${nameCol}`);
          break;
        }
      }
    }
    
    if (headerRow < 0) {
      console.log('⚠️  Could not find header row');
      return;
    }
    
    // Get header row to identify microcompetency columns
    const headers = jsonData[headerRow];
    console.log(`\n📋 Header row (first 30 columns):`, headers.slice(0, 30).map((h, i) => `${i}:${h || 'null'}`).join(', '));
    
    // Find microcompetency columns (A1, C1, D3, etc.)
    const microcompColumns = {};
    headers.forEach((header, colIndex) => {
      if (header && typeof header === 'string') {
        const trimmed = header.trim();
        // Check if it's a microcompetency code
        if (/^[A-Z]\d+$/.test(trimmed)) {
          microcompColumns[trimmed] = colIndex;
        }
      }
    });
    
    // Also check for microcompetencies in merged cells or empty columns
    // Sometimes the header might be in a merged cell above
    if (headerRow > 0) {
      const prevRow = jsonData[headerRow - 1];
      if (prevRow) {
        prevRow.forEach((cell, colIndex) => {
          if (cell && typeof cell === 'string') {
            const trimmed = cell.trim();
            if (/^[A-Z]\d+$/.test(trimmed) && !microcompColumns[trimmed]) {
              microcompColumns[trimmed] = colIndex;
            }
          }
        });
      }
    }
    
    console.log(`\n🔍 Found microcompetency columns:`, Object.keys(microcompColumns).sort().join(', '));
    
    // Process data rows (skip header row)
    let studentCount = 0;
    for (let i = headerRow + 1; i < jsonData.length; i++) {
      const row = jsonData[i];
      if (!row || row.length === 0) continue;
      
      const regNo = row[rollNoCol];
      const studentName = row[nameCol];
      
      if (!regNo) continue;
      
      const regNoStr = String(regNo).trim();
      
      // Check if this is one of our students
      if (expectedStudents.includes(regNoStr)) {
        studentCount++;
        
        if (!allScores[regNoStr]) {
          allScores[regNoStr] = {
            registration_no: regNoStr,
            name: studentName || 'Unknown',
            interventions: {}
          };
        }
        
        const interventionName = sheetToIntervention[sheetName] || sheetName;
        
        if (!allScores[regNoStr].interventions[interventionName]) {
          allScores[regNoStr].interventions[interventionName] = {
            sheet: sheetName,
            microcompetency_scores: {}
          };
        }
        
        // Extract scores from microcompetency columns
        Object.keys(microcompColumns).forEach(mcCode => {
          const colIndex = microcompColumns[mcCode];
          if (colIndex < row.length) {
            const scoreValue = row[colIndex];
            if (scoreValue !== null && scoreValue !== undefined && scoreValue !== '') {
              const score = parseFloat(scoreValue);
              if (!isNaN(score) && score >= 0) {
                allScores[regNoStr].interventions[interventionName].microcompetency_scores[mcCode] = score;
              }
            }
          }
        });
        
        // Also check for scores in columns that might have numeric values
        // Look for columns with numeric values that might be scores
        row.forEach((cell, colIndex) => {
          if (colIndex !== rollNoCol && colIndex !== nameCol && cell !== null && cell !== undefined) {
            const numValue = parseFloat(cell);
            if (!isNaN(numValue) && numValue >= 0 && numValue <= 10) {
              // Check if this column header or nearby header matches a microcompetency
              const headerValue = headers[colIndex];
              if (headerValue && typeof headerValue === 'string' && /^[A-Z]\d+$/.test(headerValue.trim())) {
                const mcCode = headerValue.trim();
                if (!allScores[regNoStr].interventions[interventionName].microcompetency_scores[mcCode]) {
                  allScores[regNoStr].interventions[interventionName].microcompetency_scores[mcCode] = numValue;
                }
              }
            }
          }
        });
      }
    }
    
    console.log(`✅ Found ${studentCount} students in this sheet`);
  });
  
  // Display results
  console.log('\n\n' + '='.repeat(80));
  console.log('📊 COMPLETE STUDENT SCORES SUMMARY');
  console.log('='.repeat(80));
  
  const studentRegNos = Object.keys(allScores).sort();
  console.log(`\n✅ Found scores for ${studentRegNos.length} students\n`);
  
  studentRegNos.forEach((regNo, idx) => {
    const student = allScores[regNo];
    console.log(`\n${idx + 1}. 👤 ${student.name} (${regNo})`);
    console.log(`   Interventions with scores: ${Object.keys(student.interventions).length}`);
    
    Object.keys(student.interventions).forEach(intName => {
      const intData = student.interventions[intName];
      const microcompCount = Object.keys(intData.microcompetency_scores).length;
      
      console.log(`\n   🎯 ${intName}`);
      console.log(`      Sheet: ${intData.sheet}`);
      console.log(`      Microcompetencies scored: ${microcompCount}`);
      
      if (microcompCount > 0) {
        console.log(`      Scores:`);
        Object.keys(intData.microcompetency_scores)
          .sort()
          .forEach(mc => {
            console.log(`         ${mc}: ${intData.microcompetency_scores[mc]}`);
          });
      } else {
        console.log(`      ⚠️  No microcompetency scores found`);
      }
    });
  });
  
  // Export to JSON
  const outputPath = path.join(__dirname, '../../test_data_2/student_scores_detailed.json');
  const outputData = {
    sourceFile: 'HPS Input Data - Level 1 updated.xlsx',
    analyzedAt: new Date().toISOString(),
    totalStudents: studentRegNos.length,
    students: studentRegNos.map(regNo => ({
      registration_no: allScores[regNo].registration_no,
      name: allScores[regNo].name,
      interventions: Object.keys(allScores[regNo].interventions).map(intName => ({
        intervention_name: intName,
        sheet: allScores[regNo].interventions[intName].sheet,
        microcompetency_scores: allScores[regNo].interventions[intName].microcompetency_scores,
        total_microcomps_scored: Object.keys(allScores[regNo].interventions[intName].microcompetency_scores).length
      }))
    }))
  };
  
  fs.writeFileSync(outputPath, JSON.stringify(outputData, null, 2));
  console.log(`\n💾 Detailed analysis saved to: ${outputPath}`);
  
  // Summary statistics
  console.log('\n' + '='.repeat(80));
  console.log('📊 SUMMARY STATISTICS');
  console.log('='.repeat(80));
  
  let totalScores = 0;
  const interventionStats = {};
  
  studentRegNos.forEach(regNo => {
    Object.keys(allScores[regNo].interventions).forEach(intName => {
      if (!interventionStats[intName]) {
        interventionStats[intName] = {
          students_scored: 0,
          total_scores: 0,
          microcompetencies: new Set()
        };
      }
      
      const scores = allScores[regNo].interventions[intName].microcompetency_scores;
      if (Object.keys(scores).length > 0) {
        interventionStats[intName].students_scored++;
        interventionStats[intName].total_scores += Object.keys(scores).length;
        Object.keys(scores).forEach(mc => {
          interventionStats[intName].microcompetencies.add(mc);
        });
        totalScores += Object.keys(scores).length;
      }
    });
  });
  
  console.log(`\n✅ Total microcompetency scores found: ${totalScores}`);
  console.log(`\n📊 Per Intervention Statistics:\n`);
  
  Object.keys(interventionStats).sort().forEach(intName => {
    const stats = interventionStats[intName];
    console.log(`  ${intName}:`);
    console.log(`    Students with scores: ${stats.students_scored}/${studentRegNos.length}`);
    console.log(`    Total scores: ${stats.total_scores}`);
    console.log(`    Unique microcompetencies: ${stats.microcompetencies.size}`);
    if (stats.microcompetencies.size > 0) {
      console.log(`    Microcompetencies: ${Array.from(stats.microcompetencies).sort().join(', ')}`);
    }
    console.log('');
  });
  
} catch (error) {
  console.error('❌ Error reading Excel file:', error);
  console.error(error.stack);
  process.exit(1);
}

