const fs = require('fs');
const path = require('path');

/**
 * This script executes all remaining SQL statements from remaining_statements_all.sql
 * It splits the file by "-- Student:" comments and executes each statement sequentially
 */

function splitStatements(content) {
  // Split by "-- Student:" pattern which marks the start of each statement
  const statements = content.split(/(?=-- Student:)/)
    .map(s => s.trim())
    .filter(s => s.length > 0 && s.includes('INSERT'));
  
  return statements;
}

async function executeRemainingStatements() {
  const sqlFilePath = path.join(__dirname, 'remaining_statements_all.sql');
  
  if (!fs.existsSync(sqlFilePath)) {
    console.error(`❌ File not found: ${sqlFilePath}`);
    process.exit(1);
  }
  
  const sqlContent = fs.readFileSync(sqlFilePath, 'utf8');
  const statements = splitStatements(sqlContent);
  
  console.log(`📊 Found ${statements.length} statements to execute\n`);
  
  let successCount = 0;
  let errorCount = 0;
  const errors = [];
  
  for (let i = 0; i < statements.length; i++) {
    const statement = statements[i];
    const statementNum = i + 1;
    
    // Extract student info from comment for logging
    const studentMatch = statement.match(/-- Student: ([^|]+)/);
    const studentInfo = studentMatch ? studentMatch[1].trim() : `Statement ${statementNum}`;
    
    console.log(`\n[${statementNum}/${statements.length}] Executing: ${studentInfo}`);
    console.log(`SQL preview: ${statement.substring(0, 150).replace(/\n/g, ' ')}...`);
    
    try {
      // Import mcp_supabase_execute_sql dynamically
      const { mcp_supabase_execute_sql } = require('../../agent-tools/mcp_supabase_execute_sql');
      await mcp_supabase_execute_sql(statement);
      console.log(`✅ Statement ${statementNum} executed successfully`);
      successCount++;
    } catch (error) {
      console.error(`❌ Error executing statement ${statementNum}:`, error.message);
      errorCount++;
      errors.push({
        statementNum,
        studentInfo,
        error: error.message,
        sqlPreview: statement.substring(0, 200)
      });
    }
  }
  
  console.log('\n--- Execution Summary ---');
  console.log(`Total statements: ${statements.length}`);
  console.log(`Successful: ${successCount}`);
  console.log(`Failed: ${errorCount}`);
  
  if (errorCount > 0) {
    console.log('\nFailed statements:');
    errors.forEach(err => {
      console.log(`  - Statement ${err.statementNum} (${err.studentInfo}): ${err.error}`);
    });
    process.exit(1);
  } else {
    console.log('\n🎉 All statements executed successfully!');
  }
}

executeRemainingStatements().catch(error => {
  console.error('Fatal error:', error);
  process.exit(1);
});

