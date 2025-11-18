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
  
  // Get all sheet names
  const sheetNames = workbook.SheetNames;
  console.log('\n📑 Found sheets:', sheetNames.join(', '));
  
  // Expected student registration numbers
  const expectedStudents = [
    '2024JULB00001', '2024JULB00002', '2024JULB00003', '2024JULB00004', 
    '2024JULB00005', '2024JULB00006', '2024JULB00007', '2024JULB00008', 
    '2024JULB00009', '2024JULB00012'
  ];
  
  // Expected interventions (from previous analysis)
  const expectedInterventions = [
    'Storytelling Presentation',
    'Book Review Presentation',
    'Interpersonal Role Play',
    'Case Study Analysis',
    'Business Proposal Report',
    'Email Writing',
    'Debating'
  ];
  
  // Store all scores
  const allScores = {};
  
  // Process each sheet
  sheetNames.forEach((sheetName, index) => {
    console.log(`\n${'='.repeat(80)}`);
    console.log(`📄 Processing Sheet ${index + 1}: ${sheetName}`);
    console.log('='.repeat(80));
    
    const worksheet = workbook.Sheets[sheetName];
    const data = xlsx.utils.sheet_to_json(worksheet, { defval: null });
    
    if (data.length === 0) {
      console.log('⚠️  Sheet is empty');
      return;
    }
    
    // Display column headers
    const headers = Object.keys(data[0]);
    console.log('\n📋 Column Headers:', headers.slice(0, 20).join(', '), '...');
    
    // Try to identify key columns
    const regNoCol = headers.find(h => 
      h && (h.toLowerCase().includes('roll') || 
           h.toLowerCase().includes('registration') ||
           h.toLowerCase().includes('reg') ||
           h.toLowerCase().includes('student'))
    );
    
    const nameCol = headers.find(h => 
      h && (h.toLowerCase().includes('name') && !h.toLowerCase().includes('intervention'))
    );
    
    console.log('\n🔍 Detected columns:');
    console.log('  Registration/Roll:', regNoCol || 'Not found');
    console.log('  Name:', nameCol || 'Not found');
    
    // Check if this sheet contains student scores
    let hasStudentData = false;
    let interventionName = sheetName;
    
    // Try to match sheet name to intervention
    const interventionMatch = expectedInterventions.find(int => 
      sheetName.toLowerCase().includes(int.toLowerCase().split(' ')[0]) ||
      int.toLowerCase().includes(sheetName.toLowerCase().split(' ')[0])
    );
    
    if (interventionMatch) {
      interventionName = interventionMatch;
    }
    
    // Process rows to find student scores
    data.forEach((row, idx) => {
      const regNo = row[regNoCol] || row['Roll Number'] || row['Registration No'] || row['Reg No'];
      const studentName = row[nameCol] || row['Name'] || row['Student Name'];
      
      // Check if this row contains student data
      if (regNo && expectedStudents.includes(String(regNo).trim())) {
        hasStudentData = true;
        
        if (!allScores[regNo]) {
          allScores[regNo] = {
            registration_no: String(regNo).trim(),
            name: studentName || 'Unknown',
            interventions: {}
          };
        }
        
        if (!allScores[regNo].interventions[interventionName]) {
          allScores[regNo].interventions[interventionName] = {
            sheet: sheetName,
            microcompetency_scores: {},
            row_data: row
          };
        }
        
        // Extract microcompetency scores from columns
        // Look for columns that match microcompetency codes (A1, C1, D3, etc.)
        headers.forEach(header => {
          if (header && /^[A-Z]\d+$/.test(String(header).trim())) {
            const microcompCode = String(header).trim();
            const scoreValue = row[header];
            
            if (scoreValue !== null && scoreValue !== undefined && scoreValue !== '') {
              const score = parseFloat(scoreValue);
              if (!isNaN(score)) {
                allScores[regNo].interventions[interventionName].microcompetency_scores[microcompCode] = score;
              }
            }
          }
        });
      }
    });
    
    if (hasStudentData) {
      console.log(`✅ Found student score data in this sheet`);
    } else {
      console.log(`⚠️  No matching student data found in this sheet`);
    }
  });
  
  // Display results
  console.log('\n\n' + '='.repeat(80));
  console.log('📊 STUDENT SCORES SUMMARY');
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
  const outputPath = path.join(__dirname, '../../test_data_2/student_scores_analysis.json');
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
    console.log(`    Microcompetencies: ${Array.from(stats.microcompetencies).sort().join(', ')}`);
    console.log('');
  });
  
} catch (error) {
  console.error('❌ Error reading Excel file:', error);
  console.error(error.stack);
  process.exit(1);
}

