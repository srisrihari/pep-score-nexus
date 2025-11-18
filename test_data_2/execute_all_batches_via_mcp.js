const fs = require('fs');
const path = require('path');

/**
 * This script reads all batch files and outputs them for execution via Supabase MCP
 * Since we can't directly call MCP from Node.js, this script will help us prepare
 * the SQL statements for manual execution
 */

const batchesDir = path.join(__dirname, 'execution_batches');

if (!fs.existsSync(batchesDir)) {
  console.error(`❌ Directory not found: ${batchesDir}`);
  process.exit(1);
}

const batchFiles = fs.readdirSync(batchesDir)
  .filter(file => file.startsWith('batch_') && file.endsWith('.sql'))
  .sort((a, b) => {
    const numA = parseInt(a.match(/\d+/)[0]);
    const numB = parseInt(b.match(/\d+/)[0]);
    return numA - numB;
  });

console.log(`📊 Found ${batchFiles.length} batch files\n`);

let totalStatements = 0;

batchFiles.forEach((file, index) => {
  const filePath = path.join(batchesDir, file);
  const content = fs.readFileSync(filePath, 'utf8');
  
  // Count statements (each INSERT statement ends with semicolon)
  const statements = content.split(/;\s*\n\s*--/).filter(s => s.trim().length > 0 && s.includes('INSERT'));
  totalStatements += statements.length;
  
  console.log(`Batch ${index + 1}/${batchFiles.length}: ${file}`);
  console.log(`  Size: ${(content.length / 1024).toFixed(2)} KB`);
  console.log(`  Statements: ${statements.length}`);
  console.log(`  First 200 chars: ${content.substring(0, 200).replace(/\n/g, ' ')}...\n`);
});

console.log(`\n✅ Total: ${totalStatements} SQL statements across ${batchFiles.length} batches`);
console.log(`\n📝 To execute, read each batch file and execute via mcp_supabase_execute_sql`);

