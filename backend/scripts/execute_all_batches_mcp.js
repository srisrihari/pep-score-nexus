const { supabaseServiceRole } = require('../src/config/supabaseClient');
const fs = require('fs');
const path = require('path');

const executeSqlFile = async (filePath) => {
  const sql = fs.readFileSync(filePath, 'utf8');
  console.log(`📝 Executing SQL from ${path.basename(filePath)}...`);
  
  const { data, error } = await supabaseServiceRole.rpc('execute_sql_query', { query_string: sql });
  
  if (error) {
    throw new Error(`Failed to execute SQL from ${filePath}: ${error.message}`);
  }
  
  console.log(`✅ Successfully executed ${path.basename(filePath)}`);
  return data;
};

const executeAllBatches = async () => {
  const batchesDir = path.join(__dirname, '../../test_data_2');
  const batchFiles = fs.readdirSync(batchesDir)
    .filter(file => file.startsWith('batch_') && file.endsWith('_exec.sql'))
    .sort(); // Sort to ensure correct order

  console.log(`📊 Found ${batchFiles.length} batches to execute`);

  for (const file of batchFiles) {
    const filePath = path.join(batchesDir, file);
    try {
      await executeSqlFile(filePath);
    } catch (error) {
      console.error(`❌ Error executing ${file}:`, error.message);
      process.exit(1);
    }
  }
  
  console.log('🎉 All batches executed successfully!');
};

executeAllBatches().catch(console.error);
