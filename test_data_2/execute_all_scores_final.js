const fs = require('fs');
const path = require('path');

/**
 * This script reads all optimized batch SQL files, splits them into individual statements,
 * and prepares them for execution via Supabase MCP
 */

function splitSqlFile(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  const statements = [];
  
  // Split by pattern: -- comment followed by INSERT ... ON CONFLICT ... ;
  const statementPattern = /(--[^\n]*\nINSERT[\s\S]*?ON CONFLICT[\s\S]*?;)/g;
  let match;
  
  while ((match = statementPattern.exec(content)) !== null) {
    statements.push(match[1].trim());
  }
  
  return statements;
}

async function processAllBatches() {
  const batchesDir = path.join(__dirname);
  const batchFiles = fs.readdirSync(batchesDir)
    .filter(file => file.startsWith('optimized_score_batch_') && file.endsWith('.sql'))
    .sort((a, b) => {
      const numA = parseInt(a.match(/\d+/)[0]);
      const numB = parseInt(b.match(/\d+/)[0]);
      return numA - numB;
    });

  console.log(`Found ${batchFiles.length} optimized batch files`);
  
  const allStatements = [];
  
  for (const file of batchFiles) {
    const filePath = path.join(batchesDir, file);
    console.log(`\nProcessing ${file}...`);
    const statements = splitSqlFile(filePath);
    console.log(`  Extracted ${statements.length} statements`);
    allStatements.push(...statements);
  }
  
  console.log(`\n✅ Total statements extracted: ${allStatements.length}`);
  
  // Save all statements to a single file for easy execution
  const outputFile = path.join(batchesDir, 'all_statements_combined.sql');
  fs.writeFileSync(outputFile, allStatements.join('\n\n'));
  console.log(`\n✅ Saved all ${allStatements.length} statements to ${outputFile}`);
  console.log('\n📋 Next steps:');
  console.log('1. Execute each statement using Supabase MCP execute_sql tool');
  console.log(`2. Total statements to execute: ${allStatements.length}`);
  console.log('3. Each statement is separated by double newlines');
}

processAllBatches().catch(console.error);

