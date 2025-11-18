const fs = require('fs');
const path = require('path');

/**
 * This script reads all batch files, splits them into individual statements,
 * and creates a consolidated file with all statements for execution
 */

const batchesDir = path.join(__dirname, 'execution_batches');
const batchFiles = fs.readdirSync(batchesDir)
  .filter(file => file.startsWith('batch_') && file.endsWith('.sql'))
  .sort((a, b) => {
    const numA = parseInt(a.match(/\d+/)[0]);
    const numB = parseInt(b.match(/\d+/)[0]);
    return numA - numB;
  });

console.log(`📊 Found ${batchFiles.length} batch files\n`);

const allStatements = [];

batchFiles.forEach((file, batchIndex) => {
  const filePath = path.join(batchesDir, file);
  const content = fs.readFileSync(filePath, 'utf8');
  
  // Split by comment pattern that starts each new statement
  const statements = content.split(/(?=-- Student:)/)
    .map(s => s.trim())
    .filter(s => s.length > 0 && s.includes('INSERT'));
  
  statements.forEach((stmt, stmtIndex) => {
    allStatements.push({
      batch: file,
      batchIndex: batchIndex + 1,
      statementIndex: stmtIndex + 1,
      statement: stmt
    });
  });
  
  console.log(`Batch ${batchIndex + 1}: ${file} - ${statements.length} statements`);
});

console.log(`\n✅ Total: ${allStatements.length} SQL statements across ${batchFiles.length} batches`);

// Write all statements to individual files for easier execution
const statementsDir = path.join(__dirname, 'all_statements');
if (!fs.existsSync(statementsDir)) {
  fs.mkdirSync(statementsDir, { recursive: true });
}

allStatements.forEach((item, index) => {
  const filename = `stmt_${String(index + 1).padStart(4, '0')}_batch${item.batchIndex}_stmt${item.statementIndex}.sql`;
  const filePath = path.join(statementsDir, filename);
  fs.writeFileSync(filePath, item.statement);
});

console.log(`\n📝 Created ${allStatements.length} individual statement files in ${statementsDir}/`);
console.log(`\n💡 To execute all statements, use mcp_supabase_execute_sql on each file sequentially.`);

// Also create a summary file
const summary = {
  totalBatches: batchFiles.length,
  totalStatements: allStatements.length,
  statements: allStatements.map(item => ({
    batch: item.batch,
    batchIndex: item.batchIndex,
    statementIndex: item.statementIndex,
    filename: `stmt_${String(allStatements.indexOf(item) + 1).padStart(4, '0')}_batch${item.batchIndex}_stmt${item.statementIndex}.sql`,
    preview: item.statement.substring(0, 150).replace(/\n/g, ' ')
  }))
};

fs.writeFileSync(
  path.join(__dirname, 'execution_summary.json'),
  JSON.stringify(summary, null, 2)
);

console.log(`\n📄 Created execution_summary.json with details of all statements`);

