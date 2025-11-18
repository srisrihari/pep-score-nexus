/**
 * This script executes all SQL batch files using Supabase MCP
 * Note: This script requires manual execution via MCP tools
 * as MCP functions cannot be called directly from Node.js
 */

const fs = require('fs');
const path = require('path');

const batchesDir = path.join(__dirname, 'execution_batches');
const batchFiles = fs.readdirSync(batchesDir)
  .filter(file => file.startsWith('batch_') && file.endsWith('.sql'))
  .sort((a, b) => {
    const numA = parseInt(a.match(/\d+/)[0]);
    const numB = parseInt(b.match(/\d+/)[0]);
    return numA - numB;
  });

console.log(`📊 Found ${batchFiles.length} batch files to execute\n`);

// Split each batch file into individual statements
batchFiles.forEach((file, index) => {
  const filePath = path.join(batchesDir, file);
  const content = fs.readFileSync(filePath, 'utf8');
  
  // Split by comment pattern that starts each new statement
  const statements = content.split(/(?=-- Student:)/)
    .map(s => s.trim())
    .filter(s => s.length > 0 && s.includes('INSERT'));
  
  console.log(`Batch ${index + 1}: ${file} - ${statements.length} statements`);
  
  // Write individual statements to a subdirectory for easier execution
  const statementsDir = path.join(__dirname, `batch_${index + 1}_statements`);
  if (!fs.existsSync(statementsDir)) {
    fs.mkdirSync(statementsDir, { recursive: true });
  }
  
  statements.forEach((stmt, stmtIndex) => {
    const stmtFile = path.join(statementsDir, `stmt_${stmtIndex + 1}.sql`);
    fs.writeFileSync(stmtFile, stmt);
  });
});

console.log(`\n✅ Prepared all batch files for execution`);
console.log(`\n💡 To execute all batches, use mcp_supabase_execute_sql on each statement file sequentially.`);
console.log(`\n📝 Individual statement files are located in batch_X_statements/ directories.`);

