const fs = require('fs');
const path = require('path');

/**
 * This script executes all remaining SQL batch files (13-23) using Supabase MCP
 * It reads each batch file, splits it into individual statements, and executes them sequentially
 */

// Import the MCP Supabase execute function
// Note: This assumes the MCP tool is available via the tool calling interface
// We'll need to use the mcp_supabase_execute_sql tool directly

function splitSqlStatements(content) {
  const statements = [];
  const statementPattern = /(--[^\n]*\nINSERT[\s\S]*?ON CONFLICT[\s\S]*?;)/g;
  let match;
  while ((match = statementPattern.exec(content)) !== null) {
    statements.push(match[1].trim());
  }
  return statements;
}

async function executeBatch(batchNum) {
  const batchFile = path.join(__dirname, `execution_batches/batch_${batchNum}.sql`);
  
  if (!fs.existsSync(batchFile)) {
    console.error(`❌ Batch file not found: ${batchFile}`);
    return { success: false, statements: 0 };
  }
  
  const sqlContent = fs.readFileSync(batchFile, 'utf8');
  const statements = splitSqlStatements(sqlContent);
  
  console.log(`\n📦 Processing Batch ${batchNum}: ${statements.length} statements`);
  
  let successCount = 0;
  let errorCount = 0;
  const errors = [];
  
  for (let i = 0; i < statements.length; i++) {
    const statement = statements[i];
    const statementNum = i + 1;
    
    try {
      // Note: This would need to be called via the MCP tool
      // For now, we'll save the statements to files that can be executed
      const outputFile = path.join(__dirname, `execution_batches/batch_${batchNum}_stmt_${statementNum}.sql`);
      fs.writeFileSync(outputFile, statement);
      
      // Extract student info from comment
      const studentMatch = statement.match(/-- Student: ([^|]+)/);
      const studentInfo = studentMatch ? studentMatch[1].trim() : `Statement ${statementNum}`;
      
      console.log(`  ✓ Prepared statement ${statementNum}/10: ${studentInfo}`);
      successCount++;
    } catch (error) {
      console.error(`  ✗ Error preparing statement ${statementNum}:`, error.message);
      errorCount++;
      errors.push({ statementNum, error: error.message });
    }
  }
  
  return {
    success: errorCount === 0,
    statements: statements.length,
    successCount,
    errorCount,
    errors
  };
}

async function executeAllRemainingBatches() {
  const remainingBatches = [13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23];
  
  console.log(`🚀 Starting execution of ${remainingBatches.length} batches (${remainingBatches[0]}-${remainingBatches[remainingBatches.length - 1]})`);
  console.log(`📊 Total batches to process: ${remainingBatches.length}`);
  
  const summary = {
    totalBatches: remainingBatches.length,
    totalStatements: 0,
    successfulStatements: 0,
    failedStatements: 0,
    batchResults: []
  };
  
  for (const batchNum of remainingBatches) {
    const result = await executeBatch(batchNum);
    summary.totalStatements += result.statements;
    summary.successfulStatements += result.successCount;
    summary.failedStatements += result.errorCount;
    summary.batchResults.push({ batchNum, ...result });
  }
  
  console.log('\n' + '='.repeat(60));
  console.log('📊 EXECUTION SUMMARY');
  console.log('='.repeat(60));
  console.log(`Total batches processed: ${summary.totalBatches}`);
  console.log(`Total statements prepared: ${summary.totalStatements}`);
  console.log(`Successful statements: ${summary.successfulStatements}`);
  console.log(`Failed statements: ${summary.failedStatements}`);
  
  if (summary.failedStatements > 0) {
    console.log('\n❌ Errors encountered:');
    summary.batchResults.forEach(batch => {
      if (batch.errors && batch.errors.length > 0) {
        console.log(`  Batch ${batch.batchNum}:`);
        batch.errors.forEach(err => {
          console.log(`    - Statement ${err.statementNum}: ${err.error}`);
        });
      }
    });
  } else {
    console.log('\n✅ All statements prepared successfully!');
    console.log('\n📝 Note: Statements have been saved to individual files.');
    console.log('   Execute them using the mcp_supabase_execute_sql tool.');
  }
  
  // Save summary to file
  fs.writeFileSync(
    path.join(__dirname, 'execution_summary_remaining.json'),
    JSON.stringify(summary, null, 2)
  );
  
  console.log(`\n📄 Detailed summary saved to: execution_summary_remaining.json`);
  
  return summary;
}

// Run if executed directly
if (require.main === module) {
  executeAllRemainingBatches()
    .then(() => {
      console.log('\n✅ Script completed successfully!');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Script failed:', error);
      process.exit(1);
    });
}

module.exports = { executeAllRemainingBatches, executeBatch };

