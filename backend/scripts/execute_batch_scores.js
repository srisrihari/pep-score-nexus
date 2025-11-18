const fs = require('fs');
const path = require('path');

// Read the SQL file
const sqlFile = path.join(__dirname, '../../test_data_2/batch_insert_scores.sql');
const sqlContent = fs.readFileSync(sqlFile, 'utf8');

// Split by double newlines (batches are separated by blank lines)
const batches = sqlContent.split(/\n\n+/).filter(b => b.trim().length > 0);

console.log(`📊 Found ${batches.length} batches to execute\n`);

// Export batches for execution
batches.forEach((batch, idx) => {
  const batchFile = path.join(__dirname, `../../test_data_2/batch_${idx + 1}_exec.sql`);
  fs.writeFileSync(batchFile, batch.trim() + ';');
  console.log(`✅ Batch ${idx + 1}: ${batch.split('\n').length} lines -> ${batchFile}`);
});

console.log(`\n💾 All batches prepared. Execute them using Supabase MCP.`);

