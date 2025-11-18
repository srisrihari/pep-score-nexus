const fs = require('fs');
const path = require('path');

/**
 * This script splits all SQL statements into batches for execution via Supabase MCP
 */

function splitSqlStatements(content) {
  // Split by pattern: -- comment followed by INSERT ... ON CONFLICT ... ;
  const statementPattern = /(--[^\n]*\nINSERT[\s\S]*?ON CONFLICT[\s\S]*?;)/g;
  const statements = [];
  let match;
  
  while ((match = statementPattern.exec(content)) !== null) {
    statements.push(match[1].trim());
  }
  
  return statements;
}

function createBatches() {
  const sqlFilePath = path.join(__dirname, 'all_statements_combined.sql');
  
  if (!fs.existsSync(sqlFilePath)) {
    console.error(`❌ File not found: ${sqlFilePath}`);
    process.exit(1);
  }
  
  const sqlContent = fs.readFileSync(sqlFilePath, 'utf8');
  const statements = splitSqlStatements(sqlContent);
  
  console.log(`📊 Found ${statements.length} SQL statements\n`);
  
  const batchSize = 10; // Execute 10 statements at a time
  const batches = [];
  
  for (let i = 0; i < statements.length; i += batchSize) {
    const batch = statements.slice(i, i + batchSize);
    batches.push(batch);
  }
  
  console.log(`📦 Created ${batches.length} batches (${batchSize} statements per batch)\n`);
  
  // Save each batch to a separate file
  const batchesDir = path.join(__dirname, 'execution_batches');
  if (!fs.existsSync(batchesDir)) {
    fs.mkdirSync(batchesDir, { recursive: true });
  }
  
  batches.forEach((batch, index) => {
    const batchFile = path.join(batchesDir, `batch_${index + 1}.sql`);
    const batchContent = batch.join('\n\n');
    fs.writeFileSync(batchFile, batchContent);
    console.log(`✅ Created batch_${index + 1}.sql (${batch.length} statements)`);
  });
  
  console.log(`\n📋 Next steps:`);
  console.log(`1. Execute each batch file using Supabase MCP execute_sql tool`);
  console.log(`2. Total batches: ${batches.length}`);
  console.log(`3. Batch files are in: ${batchesDir}`);
}

createBatches();

