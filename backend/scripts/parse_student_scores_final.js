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
    'Problem Solving': 'Case Study Analysis',
    'Debating': 'Debating',
    'Capstone': 'Capstone'
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
    
    // Read as array of arrays
    const jsonData = xlsx.utils.sheet_to_json(worksheet, { defval: null, header: 1 });
    
    if (jsonData.length < 2) {
      console.log('⚠️  Sheet has insufficient rows');
      return;
    }
    
    // Row 0: Category headers
    // Row 1: Microcompetency codes (A 1, C 1, etc.)
    // Row 2+: Student data
    
    const headerRow = jsonData[0];
    const microcompRow = jsonData[1];
    const dataRows = jsonData.slice(2);
    
    console.log(`📊 Sheet dimensions: ${jsonData.length} rows`);
    
    // Find column indices
    const rollNoCol = headerRow.findIndex(cell => 
      cell && String(cell).toLowerCase().includes('roll')
    );
    const nameCol = headerRow.findIndex(cell => 
      cell && String(cell).toLowerCase() === 'name'
    );
    
    if (rollNoCol < 0 || nameCol < 0) {
      console.log('⚠️  Could not find Roll Number or Name columns');
      return;
    }
    
    console.log(`✅ Roll Number column: ${rollNoCol}, Name column: ${nameCol}`);
    
    // Map microcompetency codes to column indices
    // Row 1 contains codes like "A 1", "C 1" which need to be converted to "A1", "C1"
    const microcompColumnMap = {};
    
    microcompRow.forEach((cell, colIndex) => {
      if (cell && typeof cell === 'string') {
        // Remove spaces and convert "A 1" to "A1"
        const cleaned = cell.trim().replace(/\s+/g, '');
        if (/^[A-Z]\d+$/.test(cleaned)) {
          microcompColumnMap[cleaned] = colIndex;
        }
      }
    });
    
    console.log(`🔍 Found ${Object.keys(microcompColumnMap).length} microcompetency columns`);
    console.log(`   Microcompetencies: ${Object.keys(microcompColumnMap).sort().join(', ')}`);
    
    // Process student rows
    let studentCount = 0;
    dataRows.forEach((row, rowIndex) => {
      if (!row || row.length === 0) return;
      
      const regNo = row[rollNoCol];
      const studentName = row[nameCol];
      
      if (!regNo) return;
      
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
        
        // Extract scores using the column map
        Object.keys(microcompColumnMap).forEach(mcCode => {
          const colIndex = microcompColumnMap[mcCode];
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
      }
    });
    
    console.log(`✅ Found ${studentCount} students with scores in this sheet`);
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
  const outputPath = path.join(__dirname, '../../test_data_2/student_scores_final.json');
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

