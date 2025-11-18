const fs = require('fs');
const path = require('path');

/**
 * Execute all remaining statements from batches 19-23
 * This script reads batch files, splits them into statements, and executes them via Supabase MCP
 */

// Import the MCP function (we'll use the direct MCP call)
// Note: This script will be executed manually, calling mcp_supabase_execute_sql for each statement

function splitStatements(content) {
  const statements = [];
  const statementPattern = /(-- Student:[\s\S]*?ON CONFLICT[\s\S]*?term_id = EXCLUDED\.term_id;)/g;
  let match;
  while ((match = statementPattern.exec(content)) !== null) {
    statements.push(match[1].trim());
  }
  return statements;
}

async function executeRemainingBatches() {
  const batchesDir = path.join(__dirname, 'execution_batches');
  
  const allStatements = [];
  
  // Process batches 19-23
  for (let batchNum = 19; batchNum <= 23; batchNum++) {
    const batchFile = path.join(batchesDir, `batch_${batchNum}.sql`);
    if (fs.existsSync(batchFile)) {
      const content = fs.readFileSync(batchFile, 'utf8');
      const statements = splitStatements(content);
      
      // For batch 19, skip first 5 (already executed)
      if (batchNum === 19) {
        allStatements.push(...statements.slice(5));
        console.log(`Batch ${batchNum}: ${statements.length} total, ${statements.length - 5} remaining`);
      } else {
        allStatements.push(...statements);
        console.log(`Batch ${batchNum}: ${statements.length} statements`);
      }
    }
  }
  
  console.log(`\n✅ Total statements to execute: ${allStatements.length}`);
  console.log(`\n📋 Statements prepared. Execute them using mcp_supabase_execute_sql tool.`);
  console.log(`\nFirst statement preview:\n${allStatements[0].substring(0, 300)}...`);
  
  // Save statements to individual files for reference
  const outputDir = path.join(__dirname, 'remaining_statements');
  if (!fs.existsSync(outputDir)) {
    fs.mkdirSync(outputDir, { recursive: true });
  }
  
  allStatements.forEach((stmt, idx) => {
    const filePath = path.join(outputDir, `stmt_${idx + 1}.sql`);
    fs.writeFileSync(filePath, stmt);
  });
  
  console.log(`\n✅ Saved ${allStatements.length} statements to ${outputDir}/`);
  console.log(`\n⚠️  Note: Execute these statements using the mcp_supabase_execute_sql tool.`);
}

executeRemainingBatches().catch(console.error);
