const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');

const excelFiles = [
  'HPS Input Data - Level 1 updated.xlsx',
  'Level 0 - Interventions.xlsx',
  'Level 0 Capstone(1).xlsx',
  'HPS Input Data - Level 3 updated.xlsx',
  'HPS Input Data - Level 2 updated.xlsx',
  'HPS - Jagsom PEP Grade Updated.xlsx'
];

const results = {};

excelFiles.forEach(fileName => {
  const filePath = path.join(__dirname, fileName);
  
  if (!fs.existsSync(filePath)) {
    console.log(`⚠️  File not found: ${fileName}`);
    return;
  }

  console.log(`\n${'='.repeat(80)}`);
  console.log(`📊 Analyzing: ${fileName}`);
  console.log('='.repeat(80));

  try {
    const workbook = XLSX.readFile(filePath);
    const sheetNames = workbook.SheetNames;
    
    const fileInfo = {
      fileName: fileName,
      totalSheets: sheetNames.length,
      sheetNames: sheetNames,
      fileSize: fs.statSync(filePath).size,
      sheets: {}
    };

    sheetNames.forEach(sheetName => {
      const worksheet = workbook.Sheets[sheetName];
      const data = XLSX.utils.sheet_to_json(worksheet, { 
        header: 1, 
        defval: null,
        raw: false 
      });

      // Get dimensions
      const range = XLSX.utils.decode_range(worksheet['!ref'] || 'A1');
      const totalRows = range.e.r + 1;
      const totalCols = range.e.c + 1;

      // Analyze header rows (first 3 rows)
      const headerRows = data.slice(0, Math.min(3, data.length));
      
      // Count non-empty rows
      const nonEmptyRows = data.filter(row => row.some(cell => cell !== null && cell !== '')).length;

      // Get sample data (first 5 rows after headers)
      const sampleData = data.slice(0, Math.min(8, data.length));

      // Identify column types
      const columnAnalysis = [];
      if (data.length > 0) {
        for (let col = 0; col < Math.min(totalCols, 20); col++) {
          const columnValues = data.slice(1, Math.min(10, data.length))
            .map(row => row[col])
            .filter(val => val !== null && val !== '');
          
          const columnInfo = {
            columnIndex: col,
            header: data[0]?.[col] || `Column ${col + 1}`,
            sampleValues: columnValues.slice(0, 5),
            dataType: columnValues.length > 0 ? 
              (typeof columnValues[0] === 'number' ? 'number' : 
               typeof columnValues[0] === 'string' ? 'string' : 'mixed') : 'empty'
          };
          columnAnalysis.push(columnInfo);
        }
      }

      fileInfo.sheets[sheetName] = {
        name: sheetName,
        dimensions: {
          totalRows: totalRows,
          totalCols: totalCols,
          nonEmptyRows: nonEmptyRows
        },
        headerRows: headerRows,
        columnAnalysis: columnAnalysis.slice(0, 15), // Limit to first 15 columns
        sampleData: sampleData
      };

      console.log(`\n📄 Sheet: "${sheetName}"`);
      console.log(`   Dimensions: ${totalRows} rows × ${totalCols} columns`);
      console.log(`   Non-empty rows: ${nonEmptyRows}`);
      console.log(`   First row (headers):`, headerRows[0]?.slice(0, 10).map(h => h || '').join(' | '));
      if (headerRows.length > 1) {
        console.log(`   Second row:`, headerRows[1]?.slice(0, 10).map(h => h || '').join(' | '));
      }
    });

    results[fileName] = fileInfo;

  } catch (error) {
    console.error(`❌ Error reading ${fileName}:`, error.message);
    results[fileName] = {
      fileName: fileName,
      error: error.message
    };
  }
});

// Save detailed analysis
const outputPath = path.join(__dirname, 'all_excel_analysis.json');
fs.writeFileSync(outputPath, JSON.stringify(results, null, 2));
console.log(`\n\n✅ Detailed analysis saved to: ${outputPath}`);

// Print summary
console.log(`\n${'='.repeat(80)}`);
console.log('📋 SUMMARY');
console.log('='.repeat(80));
Object.keys(results).forEach(fileName => {
  const info = results[fileName];
  if (info.error) {
    console.log(`\n❌ ${fileName}: ERROR - ${info.error}`);
  } else {
    console.log(`\n✅ ${fileName}`);
    console.log(`   Size: ${(info.fileSize / 1024).toFixed(2)} KB`);
    console.log(`   Sheets: ${info.totalSheets} (${info.sheetNames.join(', ')})`);
  }
});

