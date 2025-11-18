const fs = require('fs');
const path = require('path');

/**
 * This script reads all optimized batch SQL files and splits them into individual statements
 * Each statement can then be executed using Supabase MCP
 */

function splitSqlFile(filePath) {
  const content = fs.readFileSync(filePath, 'utf8');
  const statements = [];
  
  // Split by pattern: -- comment followed by INSERT ... ON CONFLICT ... ;
  // Use regex to find complete statements
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
    allStatements.push(...statements.map(stmt => ({ file, statement: stmt })));
  }
  
  console.log(`\n✅ Total statements extracted: ${allStatements.length}`);
  console.log('\n📝 First statement preview:');
  console.log(allStatements[0].statement.substring(0, 300) + '...');
  
  // Save all statements to a JSON file for reference
  fs.writeFileSync(
    path.join(batchesDir, 'all_statements_list.json'),
    JSON.stringify(allStatements.map((s, idx) => ({
      index: idx + 1,
      file: s.file,
      statement: s.statement.substring(0, 200) + '...' // Preview only
    })), null, 2)
  );
  
  // Also save individual statement files for easier execution
  const statementsDir = path.join(batchesDir, 'individual_statements');
  if (!fs.existsSync(statementsDir)) {
    fs.mkdirSync(statementsDir);
  }
  
  allStatements.forEach((stmt, idx) => {
    const stmtFile = path.join(statementsDir, `stmt_${idx + 1}.sql`);
    fs.writeFileSync(stmtFile, stmt.statement);
  });
  
  console.log(`\n✅ Saved ${allStatements.length} individual statement files to ${statementsDir}/`);
  console.log('\n📋 Next steps:');
  console.log('1. Execute each statement using Supabase MCP execute_sql tool');
  console.log(`2. Statements are numbered from stmt_1.sql to stmt_${allStatements.length}.sql`);
}

processAllBatches().catch(console.error);

