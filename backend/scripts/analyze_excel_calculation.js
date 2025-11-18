// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

/**
 * Analyze Excel calculation logic to understand how HPS is calculated
 */
async function analyzeExcelCalculation() {
  try {
    const excelPath = path.join(__dirname, '../../test_data_2/HPS - Jagsom PEP Grade Updated.xlsx');
    const workbook = XLSX.readFile(excelPath);
    
    // Analyze the HPS sheet
    const worksheet = workbook.Sheets['HPS'];
    const excelData = XLSX.utils.sheet_to_json(worksheet, { header: 1 });
    
    console.log('\n📊 Analyzing Excel HPS Calculation Logic\n');
    console.log('='.repeat(80));
    
    // Get header structure
    const levelRow = excelData[0] || [];
    const headerRow = excelData[1] || [];
    const subHeaderRow = excelData[2] || [];
    
    // Find column positions
    const regNoColIndex = headerRow.findIndex(col => 
      col && col.toString().toLowerCase().includes('rn')
    );
    const nameColIndex = headerRow.findIndex(col => 
      col && col.toString().toLowerCase().includes('student name')
    );
    
    // Find level positions
    const levelPositions = {};
    levelRow.forEach((col, idx) => {
      if (col) {
        const colStr = col.toString().toLowerCase().trim();
        if (colStr.includes('level 0')) levelPositions['Level 0'] = idx;
        else if (colStr.includes('level 1')) levelPositions['Level 1'] = idx;
        else if (colStr.includes('level 2')) levelPositions['Level 2'] = idx;
        else if (colStr.includes('level 3')) levelPositions['Level 3'] = idx;
      }
    });
    
    console.log('\n📋 Column Structure Analysis:');
    console.log('  Registration No Column:', regNoColIndex);
    console.log('  Name Column:', nameColIndex);
    console.log('  Level Positions:', levelPositions);
    
    // Analyze structure for Level 0 (first student as example)
    const firstStudentRow = excelData[2]; // Row 2 is first data row (0-indexed)
    if (firstStudentRow && firstStudentRow[regNoColIndex]) {
      console.log('\n📊 First Student Row Analysis (Row 2):');
      console.log('  Registration:', firstStudentRow[regNoColIndex]);
      console.log('  Name:', firstStudentRow[nameColIndex]);
      
      // Analyze Level 0 structure
      if (levelPositions['Level 0']) {
        const level0Start = levelPositions['Level 0'];
        console.log('\n  Level 0 Structure (starting at column', level0Start, '):');
        console.log('    Header Row:', headerRow.slice(level0Start, level0Start + 15));
        console.log('    Sub-Header Row:', subHeaderRow.slice(level0Start, level0Start + 15));
        console.log('    Data Row:', firstStudentRow.slice(level0Start, level0Start + 15));
        
        // Find FINAL HPS column for Level 0
        let finalHPSCol = null;
        for (let i = level0Start; i < headerRow.length && i < level0Start + 20; i++) {
          if (headerRow[i] && headerRow[i].toString().toLowerCase().includes('final hps')) {
            finalHPSCol = i;
            break;
          }
        }
        
        if (finalHPSCol) {
          console.log('\n    FINAL HPS Column:', finalHPSCol);
          console.log('    FINAL HPS Value:', firstStudentRow[finalHPSCol]);
          
          // Try to identify what columns contribute to FINAL HPS
          console.log('\n    Columns before FINAL HPS:');
          for (let i = level0Start; i < finalHPSCol; i++) {
            const header = headerRow[i] || '';
            const subHeader = subHeaderRow[i] || '';
            const value = firstStudentRow[i];
            if (header || subHeader || (value !== undefined && value !== null && value !== '')) {
              console.log(`      Col ${i}: ${header} / ${subHeader} = ${value}`);
            }
          }
        }
      }
    }
    
    // Analyze calculation pattern by looking at multiple students
    console.log('\n\n📊 Analyzing Calculation Pattern (First 3 Students):');
    console.log('='.repeat(80));
    
    for (let rowIdx = 2; rowIdx < Math.min(5, excelData.length); rowIdx++) {
      const row = excelData[rowIdx];
      if (!row || !row[regNoColIndex]) continue;
      
      console.log(`\n  Student: ${row[nameColIndex]} (${row[regNoColIndex]})`);
      
      Object.entries(levelPositions).forEach(([level, levelStart]) => {
        // Find FINAL HPS column
        let finalHPSCol = null;
        for (let i = levelStart; i < headerRow.length && i < levelStart + 20; i++) {
          if (headerRow[i] && headerRow[i].toString().toLowerCase().includes('final hps')) {
            finalHPSCol = i;
            break;
          }
        }
        
        if (finalHPSCol) {
          const finalHPS = row[finalHPSCol];
          
          // Look for Persona, Wellness, Behavior, Discipline columns before FINAL HPS
          const quadrantScores = {};
          for (let i = levelStart; i < finalHPSCol; i++) {
            const header = (headerRow[i] || '').toString().toLowerCase();
            const subHeader = (subHeaderRow[i] || '').toString().toLowerCase();
            const value = row[i];
            
            if (header.includes('persona') && subHeader.includes('hps')) {
              quadrantScores['Persona'] = value;
            } else if (header.includes('wellness') && subHeader.includes('hps')) {
              quadrantScores['Wellness'] = value;
            } else if (header.includes('behavior') && subHeader.includes('hps')) {
              quadrantScores['Behavior'] = value;
            } else if (header.includes('discipline') && subHeader.includes('hps')) {
              quadrantScores['Discipline'] = value;
            }
          }
          
          console.log(`    ${level}:`);
          console.log(`      Quadrant Scores:`, quadrantScores);
          console.log(`      FINAL HPS: ${finalHPS}`);
          
          // Try to calculate from quadrants
          const quadrants = Object.values(quadrantScores).filter(v => v !== undefined && v !== null && !isNaN(v));
          if (quadrants.length > 0) {
            const avg = quadrants.reduce((sum, v) => sum + v, 0) / quadrants.length;
            console.log(`      Average of Quadrants: ${avg.toFixed(2)}%`);
            console.log(`      Difference from FINAL HPS: ${Math.abs(finalHPS - avg).toFixed(2)}%`);
          }
        }
      });
    }
    
    // Save analysis results
    const analysisPath = path.join(__dirname, '../../test_data_2/excel_calculation_analysis.json');
    fs.writeFileSync(analysisPath, JSON.stringify({
      levelPositions,
      regNoColIndex,
      nameColIndex,
      headerStructure: {
        levelRow: levelRow.slice(0, 100),
        headerRow: headerRow.slice(0, 100),
        subHeaderRow: subHeaderRow.slice(0, 100)
      }
    }, null, 2));
    
    console.log(`\n💾 Analysis saved to: ${analysisPath}`);
    
  } catch (error) {
    console.error('❌ Error analyzing Excel calculation:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  analyzeExcelCalculation()
    .then(() => {
      console.log('\n✅ Excel calculation analysis completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Excel calculation analysis failed:', error);
      process.exit(1);
    });
}

module.exports = { analyzeExcelCalculation };

