const xlsx = require('xlsx');
const path = require('path');

const excelFilePath = path.join(__dirname, '../../test_data_2/HPS Input Data - Level 1 updated.xlsx');
const workbook = xlsx.readFile(excelFilePath);

// Examine "Story Telling" sheet structure
const sheetName = 'Story Telling';
const worksheet = workbook.Sheets[sheetName];

// Read as array of arrays to see exact structure
const range = xlsx.utils.decode_range(worksheet['!ref']);
console.log(`Sheet: ${sheetName}`);
console.log(`Range: ${range.s.r} to ${range.e.r} rows, ${range.s.c} to ${range.e.c} columns\n`);

// Print first 5 rows with all columns
console.log('First 5 rows structure:\n');
for (let row = 0; row < Math.min(5, range.e.r + 1); row++) {
  const rowData = [];
  for (let col = 0; col < Math.min(30, range.e.c + 1); col++) {
    const cellAddress = xlsx.utils.encode_cell({ r: row, c: col });
    const cell = worksheet[cellAddress];
    if (cell) {
      rowData.push(`${col}:${cell.v}`);
    } else {
      rowData.push(`${col}:null`);
    }
  }
  console.log(`Row ${row}:`, rowData.join(' | '));
}

// Also read as JSON to see structure
const jsonData = xlsx.utils.sheet_to_json(worksheet, { defval: null, header: 1 });
console.log('\n\nFirst student row (after headers):');
const firstStudentRow = jsonData.find(row => row && row[1] && String(row[1]).includes('2024JULB00001'));
if (firstStudentRow) {
  console.log('Row data:', firstStudentRow.slice(0, 30));
  console.log('\nFull row length:', firstStudentRow.length);
  console.log('\nAll non-null values in row:');
  firstStudentRow.forEach((val, idx) => {
    if (val !== null && val !== undefined && val !== '') {
      console.log(`  Column ${idx}: ${val} (type: ${typeof val})`);
    }
  });
}

// Check for merged cells
if (worksheet['!merges']) {
  console.log('\n\nMerged cells found:');
  worksheet['!merges'].slice(0, 20).forEach(merge => {
    const start = xlsx.utils.encode_cell(merge.s);
    const end = xlsx.utils.encode_cell(merge.e);
    console.log(`  ${start}:${end}`);
  });
}

