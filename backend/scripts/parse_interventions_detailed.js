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
  
  // Focus on the "Interventions" sheet
  const interventionsSheet = workbook.Sheets['Interventions'];
  
  if (!interventionsSheet) {
    console.error('❌ "Interventions" sheet not found');
    process.exit(1);
  }
  
  // Convert to JSON with header row
  const data = xlsx.utils.sheet_to_json(interventionsSheet, { defval: null });
  
  console.log(`✅ Found ${data.length} rows in Interventions sheet\n`);
  
  // Extract interventions and their microcompetencies
  const interventionsMap = {};
  
  data.forEach((row, idx) => {
    // Get intervention name
    const interventionName = row['Interventions (Name)'] || 
                            row['Intervention Name'] ||
                            row['Intervention'];
    
    // Skip if no intervention name
    if (!interventionName || interventionName === 'Interventions (Name)') {
      return;
    }
    
    // Collect all microcompetencies from various columns
    const microcompetencies = new Set();
    
    // Primary microcompetency column
    if (row['Micro - Competencies']) {
      microcompetencies.add(row['Micro - Competencies'].toString().trim());
    }
    
    // Check all empty columns (these contain additional microcompetencies)
    Object.keys(row).forEach(key => {
      if (key.startsWith('__EMPTY') || key.startsWith('__EMPTY_')) {
        const value = row[key];
        if (value && typeof value === 'string' && value.trim().length > 0) {
          // Check if it looks like a microcompetency code (e.g., C1, A2, P3, etc.)
          const trimmed = value.trim();
          if (/^[A-Z]\d+$/.test(trimmed)) {
            microcompetencies.add(trimmed);
          }
        }
      }
    });
    
    // Initialize intervention if not exists
    if (!interventionsMap[interventionName]) {
      interventionsMap[interventionName] = {
        name: interventionName,
        programLevel: row['Program Level'] || null,
        activityName: row['Activity / Workshops Name'] || null,
        institution: row['Institution'] || null,
        programCourse: row['Program / Course'] || null,
        batch: row['Batch'] || null,
        termSemester: row['Term / Semester'] || null,
        sessionsPlanned: row['No: of Session Planned'] || null,
        sessionsConducted: row['No: of Session Conducted'] || null,
        microcompetencies: new Set(),
        allRowData: []
      };
    }
    
    // Add microcompetencies
    microcompetencies.forEach(mc => {
      interventionsMap[interventionName].microcompetencies.add(mc);
    });
    
    // Store row data
    interventionsMap[interventionName].allRowData.push({
      rowNumber: idx + 2,
      data: row
    });
  });
  
  // Convert to array and sort
  const interventions = Object.values(interventionsMap).map(int => ({
    ...int,
    microcompetencies: Array.from(int.microcompetencies).sort()
  }));
  
  // Display results
  console.log(`📊 FOUND ${interventions.length} UNIQUE INTERVENTIONS\n`);
  console.log('='.repeat(80));
  
  interventions.forEach((intervention, idx) => {
    console.log(`\n${idx + 1}. 🎯 ${intervention.name}`);
    console.log(`   📋 Activity: ${intervention.activityName || 'N/A'}`);
    console.log(`   📊 Program Level: ${intervention.programLevel || 'N/A'}`);
    console.log(`   🏫 Institution: ${intervention.institution || 'N/A'}`);
    console.log(`   📚 Program/Course: ${intervention.programCourse || 'N/A'}`);
    console.log(`   👥 Batch: ${intervention.batch || 'N/A'}`);
    console.log(`   📅 Term/Semester: ${intervention.termSemester || 'N/A'}`);
    console.log(`   📝 Sessions: ${intervention.sessionsConducted || 0}/${intervention.sessionsPlanned || 0}`);
    console.log(`   🔢 Total Microcompetencies: ${intervention.microcompetencies.length}`);
    
    if (intervention.microcompetencies.length > 0) {
      console.log(`   📋 Microcompetencies:`);
      intervention.microcompetencies.forEach((mc, mcIdx) => {
        console.log(`      ${mcIdx + 1}. ${mc}`);
      });
    } else {
      console.log(`   ⚠️  No microcompetencies found`);
    }
    
    console.log(`   📄 Rows in sheet: ${intervention.allRowData.length}`);
  });
  
  // Summary statistics
  console.log('\n' + '='.repeat(80));
  console.log('📊 SUMMARY STATISTICS');
  console.log('='.repeat(80));
  console.log(`\n✅ Total Interventions: ${interventions.length}`);
  
  const totalMicrocompetencies = new Set();
  interventions.forEach(int => {
    int.microcompetencies.forEach(mc => totalMicrocompetencies.add(mc));
  });
  console.log(`✅ Unique Microcompetencies: ${totalMicrocompetencies.size}`);
  console.log(`✅ Microcompetency List: ${Array.from(totalMicrocompetencies).sort().join(', ')}`);
  
  const avgMicrocomps = interventions.reduce((sum, int) => sum + int.microcompetencies.length, 0) / interventions.length;
  console.log(`✅ Average Microcompetencies per Intervention: ${avgMicrocomps.toFixed(2)}`);
  
  // Export to JSON
  const outputPath = path.join(__dirname, '../../test_data_2/interventions_detailed.json');
  const outputData = {
    sourceFile: 'HPS Input Data - Level 1 updated.xlsx',
    analyzedAt: new Date().toISOString(),
    summary: {
      totalInterventions: interventions.length,
      totalUniqueMicrocompetencies: totalMicrocompetencies.size,
      averageMicrocompetenciesPerIntervention: avgMicrocomps
    },
    interventions: interventions.map(int => ({
      name: int.name,
      activityName: int.activityName,
      programLevel: int.programLevel,
      institution: int.institution,
      programCourse: int.programCourse,
      batch: int.batch,
      termSemester: int.termSemester,
      sessionsPlanned: int.sessionsPlanned,
      sessionsConducted: int.sessionsConducted,
      microcompetencies: int.microcompetencies,
      microcompetencyCount: int.microcompetencies.length
    })),
    allMicrocompetencies: Array.from(totalMicrocompetencies).sort()
  };
  
  fs.writeFileSync(outputPath, JSON.stringify(outputData, null, 2));
  console.log(`\n💾 Detailed analysis saved to: ${outputPath}`);
  
} catch (error) {
  console.error('❌ Error reading Excel file:', error);
  console.error(error.stack);
  process.exit(1);
}

