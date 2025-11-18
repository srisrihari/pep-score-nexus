const xlsx = require('xlsx');
const path = require('path');
const fs = require('fs');

// Path to the Excel file
const excelFilePath = path.join(__dirname, '../../test_data_2/HPS Input Data - Level 1 updated.xlsx');

console.log('📊 Reading Excel file:', excelFilePath);

try {
  // Check if file exists
  if (!fs.existsSync(excelFilePath)) {
    console.error('❌ File not found:', excelFilePath);
    process.exit(1);
  }

  // Read the Excel file
  const workbook = xlsx.readFile(excelFilePath);
  
  // Get all sheet names
  const sheetNames = workbook.SheetNames;
  console.log('\n📑 Found sheets:', sheetNames.join(', '));
  
  // Process each sheet
  const allInterventions = {};
  
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
    console.log('\n📋 Column Headers:', headers.join(', '));
    
    // Try to identify intervention and microcompetency columns
    const interventionCol = headers.find(h => 
      h && (h.toLowerCase().includes('intervention') || 
           h.toLowerCase().includes('program') ||
           h.toLowerCase().includes('course'))
    );
    
    const microcompCol = headers.find(h => 
      h && (h.toLowerCase().includes('microcomp') || 
           h.toLowerCase().includes('micro') ||
           h.toLowerCase().includes('competency'))
    );
    
    const weightCol = headers.find(h => 
      h && (h.toLowerCase().includes('weight') || 
           h.toLowerCase().includes('weightage'))
    );
    
    console.log('\n🔍 Detected columns:');
    console.log('  Intervention:', interventionCol || 'Not found');
    console.log('  Microcompetency:', microcompCol || 'Not found');
    console.log('  Weight:', weightCol || 'Not found');
    
    // Group by intervention
    const interventions = {};
    
    data.forEach((row, idx) => {
      // Try multiple column name variations
      const interventionName = row[interventionCol] || 
                              row['Intervention'] || 
                              row['INTERVENTION'] ||
                              row['intervention'] ||
                              row['Program'] ||
                              row['PROGRAM'] ||
                              row['program'] ||
                              row['Course'] ||
                              row['COURSE'] ||
                              row['course'];
      
      const microcompName = row[microcompCol] || 
                           row['Microcompetency'] || 
                           row['MICROCOMPETENCY'] ||
                           row['microcompetency'] ||
                           row['Micro'] ||
                           row['MICRO'] ||
                           row['micro'] ||
                           row['Competency'] ||
                           row['COMPETENCY'] ||
                           row['competency'];
      
      const weight = row[weightCol] || 
                    row['Weight'] || 
                    row['WEIGHT'] ||
                    row['weight'] ||
                    row['Weightage'] ||
                    row['WEIGHTAGE'] ||
                    row['weightage'];
      
      // Skip empty rows
      if (!interventionName && !microcompName) {
        return;
      }
      
      // Use sheet name as intervention if no intervention column found
      const finalInterventionName = interventionName || sheetName;
      
      if (!interventions[finalInterventionName]) {
        interventions[finalInterventionName] = {
          sheet: sheetName,
          microcompetencies: [],
          allData: []
        };
      }
      
      // Collect all row data
      const rowData = {
        rowNumber: idx + 2, // +2 because Excel rows start at 1 and we have header
        data: row
      };
      
      if (microcompName) {
        rowData.microcompetency = microcompName;
        rowData.weight = weight;
        
        // Check if microcomp already exists
        const existingMicrocomp = interventions[finalInterventionName].microcompetencies.find(
          m => m.name === microcompName
        );
        
        if (!existingMicrocomp) {
          interventions[finalInterventionName].microcompetencies.push({
            name: microcompName,
            weight: weight || null
          });
        }
      }
      
      interventions[finalInterventionName].allData.push(rowData);
    });
    
    // Store interventions
    Object.keys(interventions).forEach(intName => {
      if (!allInterventions[intName]) {
        allInterventions[intName] = {
          sheets: [],
          microcompetencies: new Set(),
          weights: []
        };
      }
      
      allInterventions[intName].sheets.push(sheetName);
      interventions[intName].microcompetencies.forEach(m => {
        allInterventions[intName].microcompetencies.add(m.name);
        if (m.weight) {
          allInterventions[intName].weights.push({
            microcomp: m.name,
            weight: m.weight
          });
        }
      });
    });
    
    // Display results for this sheet
    console.log('\n📊 Interventions found in this sheet:');
    Object.keys(interventions).forEach(intName => {
      const int = interventions[intName];
      console.log(`\n  🎯 ${intName}`);
      console.log(`     Sheet: ${int.sheet}`);
      console.log(`     Microcompetencies: ${int.microcompetencies.length}`);
      
      if (int.microcompetencies.length > 0) {
        console.log(`     Details:`);
        int.microcompetencies.forEach((m, idx) => {
          console.log(`       ${idx + 1}. ${m.name}${m.weight ? ` (Weight: ${m.weight})` : ''}`);
        });
      }
    });
    
    // Show sample data structure
    if (data.length > 0) {
      console.log('\n📝 Sample row data (first row):');
      console.log(JSON.stringify(data[0], null, 2));
    }
  });
  
  // Final summary
  console.log('\n\n' + '='.repeat(80));
  console.log('📊 FINAL SUMMARY - ALL INTERVENTIONS');
  console.log('='.repeat(80));
  
  const interventionNames = Object.keys(allInterventions);
  console.log(`\n✅ Total unique interventions found: ${interventionNames.length}\n`);
  
  interventionNames.forEach((intName, idx) => {
    const int = allInterventions[intName];
    console.log(`${idx + 1}. 🎯 ${intName}`);
    console.log(`   📑 Found in sheets: ${int.sheets.join(', ')}`);
    console.log(`   📊 Total microcompetencies: ${int.microcompetencies.size}`);
    
    if (int.microcompetencies.size > 0) {
      console.log(`   📋 Microcompetencies:`);
      Array.from(int.microcompetencies).sort().forEach((m, mIdx) => {
        const weights = int.weights.filter(w => w.microcomp === m);
        const weightStr = weights.length > 0 ? ` (Weight: ${weights.map(w => w.weight).join(', ')})` : '';
        console.log(`      ${mIdx + 1}. ${m}${weightStr}`);
      });
    }
    console.log('');
  });
  
  // Export to JSON for easier inspection
  const outputPath = path.join(__dirname, '../../test_data_2/interventions_analysis.json');
  const outputData = {
    sourceFile: 'HPS Input Data - Level 1 updated.xlsx',
    analyzedAt: new Date().toISOString(),
    totalInterventions: interventionNames.length,
    interventions: Object.keys(allInterventions).map(intName => ({
      name: intName,
      sheets: allInterventions[intName].sheets,
      microcompetencies: Array.from(allInterventions[intName].microcompetencies).sort(),
      weights: allInterventions[intName].weights
    }))
  };
  
  fs.writeFileSync(outputPath, JSON.stringify(outputData, null, 2));
  console.log(`\n💾 Detailed analysis saved to: ${outputPath}`);
  
} catch (error) {
  console.error('❌ Error reading Excel file:', error);
  console.error(error.stack);
  process.exit(1);
}

