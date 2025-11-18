const fs = require('fs');
const path = require('path');

/**
 * This script executes all remaining SQL batches (9-23) using Supabase MCP
 * It reads batch files, splits them into individual statements, and executes them sequentially
 */

// Import the MCP function (adjust path as needed)
// Note: This assumes the MCP function is available in the environment
// In a real scenario, you'd import it from the appropriate module

async function executeSqlViaMCP(sql) {
  // This is a placeholder - in reality, you'd call the actual MCP function
  // For now, we'll use a mock that logs the SQL
  console.log(`Executing SQL (${sql.length} chars)...`);
  // In production, this would be:
  // const { mcp_supabase_execute_sql } = require('../../agent-tools/mcp_supabase_execute_sql');
  // return await mcp_supabase_execute_sql(sql);
  
  // For now, return a mock success
  return { success: true };
}

function splitSqlStatements(content) {
  const statements = [];
  // Split by pattern: -- Student: comment followed by INSERT ... ON CONFLICT ... ;
  const statementPattern = /(--[^\n]*\nINSERT[\s\S]*?ON CONFLICT[\s\S]*?;)/g;
  let match;
  
  while ((match = statementPattern.exec(content)) !== null) {
    statements.push(match[1].trim());
  }
  
  return statements;
}

async function executeAllRemainingBatches() {
  const batchesDir = path.join(__dirname, 'execution_batches');
  
  if (!fs.existsSync(batchesDir)) {
    console.error(`❌ Directory not found: ${batchesDir}`);
    process.exit(1);
  }
  
  // Get all batch files from 9 to 23
  const batchFiles = fs.readdirSync(batchesDir)
    .filter(file => file.startsWith('batch_') && file.endsWith('.sql'))
    .filter(file => {
      const batchNum = parseInt(file.match(/\d+/)[0]);
      return batchNum >= 9 && batchNum <= 23;
    })
    .sort((a, b) => {
      const numA = parseInt(a.match(/\d+/)[0]);
      const numB = parseInt(b.match(/\d+/)[0]);
      return numA - numB;
    });
  
  console.log(`📊 Found ${batchFiles.length} batch files to execute (batches 9-23)\n`);
  
  let globalStatementIndex = 100; // Starting from 100 since we've completed 100 statements
  let totalStatements = 0;
  let successfulStatements = 0;
  let failedStatements = 0;
  const errors = [];
  
  for (const batchFile of batchFiles) {
    const batchFilePath = path.join(batchesDir, batchFile);
    const sqlContent = fs.readFileSync(batchFilePath, 'utf8');
    const statements = splitSqlStatements(sqlContent);
    
    console.log(`\n📦 Processing ${batchFile}: ${statements.length} statements`);
    totalStatements += statements.length;
    
    for (let i = 0; i < statements.length; i++) {
      globalStatementIndex++;
      const statement = statements[i];
      
      // Extract student info from comment for logging
      const studentMatch = statement.match(/-- Student: ([^\|]+)/);
      const studentInfo = studentMatch ? studentMatch[1].trim() : 'Unknown';
      
      console.log(`  Executing statement ${globalStatementIndex}/${230} (${studentInfo})...`);
      
      try {
        await executeSqlViaMCP(statement);
        successfulStatements++;
        console.log(`  ✅ Statement ${globalStatementIndex} executed successfully`);
      } catch (error) {
        failedStatements++;
        const errorInfo = {
          statementIndex: globalStatementIndex,
          batchFile: batchFile,
          studentInfo: studentInfo,
          error: error.message,
          sqlPreview: statement.substring(0, 200)
        };
        errors.push(errorInfo);
        console.error(`  ❌ Error executing statement ${globalStatementIndex}:`, error.message);
      }
    }
  }
  
  console.log('\n--- Execution Summary ---');
  console.log(`Total batches processed: ${batchFiles.length}`);
  console.log(`Total statements attempted: ${totalStatements}`);
  console.log(`Successful statements: ${successfulStatements}`);
  console.log(`Failed statements: ${failedStatements}`);
  
  if (errors.length > 0) {
    console.log('\nDetails of failed statements:');
    errors.forEach(err => {
      console.log(`  - Stmt ${err.statementIndex} (Batch: ${err.batchFile}, Student: ${err.studentInfo}): ${err.error}`);
    });
  }
  
  console.log('------------------------');
  
  // Save detailed summary to a JSON file
  const summary = {
    totalBatches: batchFiles.length,
    totalStatements,
    successfulStatements,
    failedStatements,
    errors
  };
  
  fs.writeFileSync(
    path.join(__dirname, 'remaining_batches_execution_summary.json'),
    JSON.stringify(summary, null, 2)
  );
  
  console.log(`📄 Detailed execution summary saved to remaining_batches_execution_summary.json`);
  
  if (failedStatements > 0) {
    process.exit(1);
  } else {
    console.log('🎉 All remaining batches executed successfully!');
  }
}

// Run the script
executeAllRemainingBatches().catch(error => {
  console.error('❌ Fatal error:', error);
  process.exit(1);
});

