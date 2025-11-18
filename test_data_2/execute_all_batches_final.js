const fs = require('fs');
const path = require('path');
const { mcp_supabase_execute_sql } = require('../agent-tools/mcp_supabase_execute_sql');

/**
 * This script executes all SQL batch files using Supabase MCP
 */

async function executeAllBatches() {
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
  
  console.log(`📊 Found ${batchFiles.length} batch files to execute\n`);
  
  let successCount = 0;
  let errorCount = 0;
  const errors = [];
  
  for (let i = 0; i < batchFiles.length; i++) {
    const batchFile = batchFiles[i];
    const batchNum = i + 1;
    const filePath = path.join(batchesDir, batchFile);
    const sqlContent = fs.readFileSync(filePath, 'utf8');
    
    console.log(`[${batchNum}/${batchFiles.length}] Executing ${batchFile}...`);
    
    try {
      await mcp_supabase_execute_sql(sqlContent);
      successCount++;
      console.log(`  ✅ Successfully executed ${batchFile}\n`);
    } catch (error) {
      errorCount++;
      errors.push({
        batch: batchFile,
        error: error.message
      });
      console.error(`  ❌ Error executing ${batchFile}: ${error.message}\n`);
    }
  }
  
  console.log(`\n📊 Execution Summary:`);
  console.log(`  ✅ Successful batches: ${successCount}`);
  console.log(`  ❌ Failed batches: ${errorCount}`);
  
  if (errors.length > 0) {
    console.log(`\n❌ Errors encountered:`);
    errors.forEach(err => {
      console.log(`  ${err.batch}: ${err.error}`);
    });
  }
  
  if (successCount === batchFiles.length) {
    console.log(`\n🎉 All batches executed successfully!`);
  }
}

executeAllBatches().catch(console.error);

