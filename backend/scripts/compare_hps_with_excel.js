// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

/**
 * Compare calculated HPS scores with Excel grade sheet
 */
async function compareHPSWithExcel() {
  try {
    // Read calculated HPS results
    const resultsPath = path.join(__dirname, '../../test_data_2/hps_calculation_results.json');
    const calculatedResults = JSON.parse(fs.readFileSync(resultsPath, 'utf8'));

    // Read Excel grade sheet
    const excelPath = path.join(__dirname, '../../test_data_2/HPS - Jagsom PEP Grade Updated.xlsx');
    const workbook = XLSX.readFile(excelPath);
    
    console.log('\n📊 Available sheets in Excel:', workbook.SheetNames);
    
    // Try "HPS" sheet first, then "PEP Grade Final", then others
    let gradeSheetName = workbook.SheetNames.find(name => 
      name.toLowerCase().trim() === 'hps'
    );
    
    if (!gradeSheetName) {
      gradeSheetName = workbook.SheetNames.find(name => 
        name.toLowerCase().includes('pep grade final')
      );
    }
    
    if (!gradeSheetName) {
      gradeSheetName = workbook.SheetNames.find(name => 
        name.toLowerCase().includes('grade') || 
        name.toLowerCase().includes('hps') ||
        name.toLowerCase().includes('summary')
      ) || workbook.SheetNames[0];
    }
    
    console.log(`📄 Using sheet: ${gradeSheetName}\n`);
    
    const worksheet = workbook.Sheets[gradeSheetName];
    const excelData = XLSX.utils.sheet_to_json(worksheet, { header: 1 });
    
    // Display first few rows to understand structure
    console.log('📋 Excel sheet structure (first 5 rows):');
    excelData.slice(0, 5).forEach((row, idx) => {
      console.log(`Row ${idx}:`, row);
    });
    console.log('\n');
    
    // The Excel structure has level names in row 0, headers in row 1
    const levelRow = excelData[0] || [];
    const headerRow = excelData[1] || [];
    
    console.log('📋 Level row (row 0):', levelRow.slice(0, 60));
    console.log('📋 Header row (row 1):', headerRow.slice(0, 60));
    console.log('\n');
    
    // Find registration number column index (RN column)
    const regNoColIndex = headerRow.findIndex(col => 
      col && (col.toString().toLowerCase().includes('registration') || 
              col.toString().toLowerCase().includes('roll') ||
              col.toString().toLowerCase().includes('rn') ||
              col.toString().trim() === 'RN')
    );
    
    // Find name column index
    const nameColIndex = headerRow.findIndex(col => 
      col && col.toString().toLowerCase().includes('student name')
    );
    
    // Find level columns from row 0 (Level 0, Level 1, Level 2, Level 3)
    const levelColIndices = {};
    levelRow.forEach((col, idx) => {
      if (col) {
        const colStr = col.toString().toLowerCase().trim();
        if (colStr === 'level 0' || colStr === 'level0') {
          levelColIndices['Level 0'] = idx;
        } else if (colStr === 'level 1' || colStr === 'level1') {
          levelColIndices['Level 1'] = idx;
        } else if (colStr === 'level 2' || colStr === 'level2') {
          levelColIndices['Level 2'] = idx;
        } else if (colStr === 'level 3' || colStr === 'level3') {
          levelColIndices['Level 3'] = idx;
        }
      }
    });
    
    // Find FINAL HPS columns for each level (they appear after each level header)
    // FINAL HPS appears in row 1, we need to find them relative to level positions
    const finalHPSColIndices = {};
    Object.entries(levelColIndices).forEach(([level, levelStartCol]) => {
      // Find the next "FINAL HPS" after this level start
      for (let i = levelStartCol; i < headerRow.length; i++) {
        if (headerRow[i] && headerRow[i].toString().toLowerCase().includes('final hps')) {
          finalHPSColIndices[level] = i;
          break;
        }
      }
    });
    
    console.log('🔍 Column indices found:');
    console.log('  Registration No:', regNoColIndex);
    console.log('  Name:', nameColIndex);
    console.log('  Level start columns:', levelColIndices);
    console.log('  FINAL HPS columns:', finalHPSColIndices);
    console.log('\n');
    
    // Parse Excel data into structured format (start from row 2, as row 0-1 are headers)
    const excelScores = {};
    for (let i = 2; i < excelData.length; i++) {
      const row = excelData[i];
      if (!row || row.length === 0) continue;
      
      const regNo = regNoColIndex >= 0 ? (row[regNoColIndex] || '').toString().trim() : null;
      const name = nameColIndex >= 0 ? (row[nameColIndex] || '').toString().trim() : null;
      
      if (!regNo && !name) continue;
      
      const studentKey = regNo || name;
      excelScores[studentKey] = {
        registration_no: regNo,
        name: name,
        levels: {}
      };
      
      // Extract level scores from FINAL HPS columns
      Object.entries(finalHPSColIndices).forEach(([level, colIdx]) => {
        const score = row[colIdx];
        if (score !== undefined && score !== null && score !== '') {
          const scoreNum = typeof score === 'number' ? score : parseFloat(score);
          if (!isNaN(scoreNum)) {
            excelScores[studentKey].levels[level] = scoreNum;
          }
        }
      });
    }
    
    console.log(`📊 Found ${Object.keys(excelScores).length} students in Excel\n`);
    
    // Compare with calculated scores
    const comparison = [];
    const discrepancies = [];
    
    // Group calculated results by student and term
    const calculatedByStudent = {};
    calculatedResults.forEach(result => {
      if (!calculatedByStudent[result.registration_no]) {
        calculatedByStudent[result.registration_no] = {};
      }
      calculatedByStudent[result.registration_no][result.term_name] = result.hps_score;
    });
    
    // Compare each student
    Object.keys(calculatedByStudent).forEach(regNo => {
      const calculated = calculatedByStudent[regNo];
      const excel = excelScores[regNo] || excelScores[Object.keys(excelScores).find(k => 
        excelScores[k].registration_no === regNo || excelScores[k].name === calculatedResults.find(r => r.registration_no === regNo)?.student_name
      )];
      
      if (!excel) {
        discrepancies.push({
          registration_no: regNo,
          issue: 'Student not found in Excel',
          calculated: calculated
        });
        return;
      }
      
      ['Level 0', 'Level 1', 'Level 2', 'Level 3'].forEach(level => {
        const calculatedScore = calculated[level];
        const excelScore = excel.levels[level];
        
        if (calculatedScore !== undefined) {
          const diff = excelScore !== undefined ? Math.abs(calculatedScore - excelScore) : null;
          const match = diff !== null && diff < 0.01; // Allow 0.01% tolerance
          
          comparison.push({
            registration_no: regNo,
            student_name: calculatedResults.find(r => r.registration_no === regNo)?.student_name,
            level: level,
            calculated_hps: calculatedScore,
            excel_hps: excelScore,
            difference: diff,
            match: match
          });
          
          if (!match && excelScore !== undefined) {
            discrepancies.push({
              registration_no: regNo,
              student_name: calculatedResults.find(r => r.registration_no === regNo)?.student_name,
              level: level,
              calculated_hps: calculatedScore.toFixed(2),
              excel_hps: excelScore,
              difference: diff.toFixed(2)
            });
          }
        }
      });
    });
    
    // Display comparison results
    console.log('📊 HPS Comparison Results:\n');
    console.log('Student'.padEnd(25) + ' | Level  | Calculated | Excel     | Diff     | Match');
    console.log('-'.repeat(25) + '-+-' + '-'.repeat(7) + '-+-' + '-'.repeat(11) + '-+-' + '-'.repeat(9) + '-+-' + '-'.repeat(9) + '-+-' + '-'.repeat(5));
    
    comparison.forEach(comp => {
      const student = (comp.student_name || comp.registration_no).padEnd(25);
      const level = comp.level.padEnd(7);
      const calc = comp.calculated_hps.toFixed(2).padStart(10) + '%';
      const excel = comp.excel_hps !== undefined ? comp.excel_hps.toFixed(2).padStart(8) + '%' : 'N/A'.padStart(9);
      const diff = comp.difference !== null ? comp.difference.toFixed(2).padStart(8) + '%' : 'N/A'.padStart(9);
      const match = comp.match ? '✅' : '❌';
      console.log(`${student} | ${level} | ${calc} | ${excel} | ${diff} | ${match}`);
    });
    
    console.log('\n\n📈 Summary:');
    console.log(`  Total comparisons: ${comparison.length}`);
    console.log(`  Matches: ${comparison.filter(c => c.match).length}`);
    console.log(`  Discrepancies: ${discrepancies.length}`);
    
    if (discrepancies.length > 0) {
      console.log('\n\n❌ Discrepancies Found:\n');
      discrepancies.forEach(disc => {
        console.log(`  ${disc.student_name} (${disc.registration_no}) - ${disc.level}:`);
        console.log(`    Calculated: ${disc.calculated_hps}%`);
        console.log(`    Excel: ${disc.excel_hps}%`);
        console.log(`    Difference: ${disc.difference}%\n`);
      });
    }
    
    // Save comparison results
    const outputPath = path.join(__dirname, '../../test_data_2/hps_comparison_results.json');
    fs.writeFileSync(outputPath, JSON.stringify({
      comparison: comparison,
      discrepancies: discrepancies,
      summary: {
        total_comparisons: comparison.length,
        matches: comparison.filter(c => c.match).length,
        discrepancies_count: discrepancies.length
      }
    }, null, 2));
    
    console.log(`\n💾 Comparison results saved to: ${outputPath}`);
    
    return { comparison, discrepancies };
  } catch (error) {
    console.error('❌ Error comparing HPS scores:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  compareHPSWithExcel()
    .then(() => {
      console.log('\n✅ HPS comparison completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ HPS comparison failed:', error);
      process.exit(1);
    });
}

module.exports = { compareHPSWithExcel };

