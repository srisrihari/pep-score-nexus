const fs = require('fs');
const path = require('path');

// This script will execute all SQL statements using Supabase MCP
// We'll need to call mcp_supabase_execute_sql for each statement

async function executeAllStatements() {
  const statementsDir = path.join(__dirname);
  
  // Get all batch statement files
  const batch1Files = fs.readdirSync(statementsDir)
    .filter(file => file.startsWith('batch1_stmt_') && file.endsWith('.sql'))
    .sort((a, b) => {
      const numA = parseInt(a.match(/\d+/)[0]);
      const numB = parseInt(b.match(/\d+/)[0]);
      return numA - numB;
    });

  console.log(`Found ${batch1Files.length} statements in batch 1`);
  console.log('Note: This script needs to be executed with access to mcp_supabase_execute_sql');
  console.log('Please execute statements manually or use a tool that has access to MCP tools');
  
  // Print first few statements for verification
  console.log('\nFirst 3 statements:');
  for (let i = 0; i < Math.min(3, batch1Files.length); i++) {
    const filePath = path.join(statementsDir, batch1Files[i]);
    const content = fs.readFileSync(filePath, 'utf8');
    console.log(`\n--- ${batch1Files[i]} ---`);
    console.log(content.substring(0, 200) + '...');
  }
}

executeAllStatements();

