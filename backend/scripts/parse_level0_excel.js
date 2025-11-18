// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

/**
 * Parse Level 0 Excel files to understand the data structure
 */
async function parseLevel0Excel() {
  try {
    console.log('\n📊 Parsing Level 0 Excel Files\n');
    console.log('='.repeat(80));
    
    // Parse Level 0 Capstone file
    const capstonePath = path.join(__dirname, '../../test_data_2/Level 0 Capstone(1).xlsx');
    if (fs.existsSync(capstonePath)) {
      console.log('\n📄 Parsing: Level 0 Capstone(1).xlsx');
      const capstoneWorkbook = XLSX.readFile(capstonePath);
      console.log('  Sheets:', capstoneWorkbook.SheetNames);
      
      capstoneWorkbook.SheetNames.forEach(sheetName => {
        const ws = capstoneWorkbook.Sheets[sheetName];
        const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
        console.log(`\n  Sheet: ${sheetName}`);
        console.log('  First 5 rows:');
        data.slice(0, 5).forEach((row, idx) => {
          console.log(`    Row ${idx}:`, row.slice(0, 10));
        });
      });
    }
    
    // Parse Level 0 Interventions file
    const interventionsPath = path.join(__dirname, '../../test_data_2/Level 0 - Interventions.xlsx');
    if (fs.existsSync(interventionsPath)) {
      console.log('\n📄 Parsing: Level 0 - Interventions.xlsx');
      const interventionsWorkbook = XLSX.readFile(interventionsPath);
      console.log('  Sheets:', interventionsWorkbook.SheetNames);
      
      interventionsWorkbook.SheetNames.forEach(sheetName => {
        const ws = interventionsWorkbook.Sheets[sheetName];
        const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
        console.log(`\n  Sheet: ${sheetName}`);
        console.log('  First 5 rows:');
        data.slice(0, 5).forEach((row, idx) => {
          console.log(`    Row ${idx}:`, row.slice(0, 10));
        });
      });
    }
    
    // Check HPS sheet for Level 0 structure
    const hpsPath = path.join(__dirname, '../../test_data_2/HPS - Jagsom PEP Grade Updated.xlsx');
    console.log('\n📄 Analyzing HPS sheet for Level 0 structure');
    const hpsWorkbook = XLSX.readFile(hpsPath);
    const hpsWs = hpsWorkbook.Sheets['HPS'];
    const hpsData = XLSX.utils.sheet_to_json(hpsWs, { header: 1 });
    
    // Find first student row
    const firstStudentRow = hpsData[2]; // Row 2 (0-indexed)
    const headers = hpsData[1];
    const subHeaders = hpsData[2];
    
    console.log('\n  Level 0 Column Structure:');
    const level0Start = 5;
    for (let i = level0Start; i < level0Start + 20 && i < headers.length; i++) {
      const h = (headers[i] || '').toString();
      const sh = (subHeaders[i] || '').toString();
      const val = firstStudentRow[i];
      if (h || sh || (val !== undefined && val !== null && val !== '')) {
        const valStr = typeof val === 'number' ? val.toFixed(2) : val;
        console.log(`    Col ${i}: [${h.padEnd(15)}] / [${sh.padEnd(15)}] = ${valStr}`);
      }
    }
    
  } catch (error) {
    console.error('❌ Error parsing Level 0 Excel:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  parseLevel0Excel()
    .then(() => {
      console.log('\n✅ Level 0 Excel parsing completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Level 0 Excel parsing failed:', error);
      process.exit(1);
    });
}

module.exports = { parseLevel0Excel };

