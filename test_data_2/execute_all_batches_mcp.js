const fs = require('fs');
const path = require('path');

// This script reads all batch files and prepares them for execution
// The actual execution will be done via Supabase MCP

async function prepareBatchStatements() {
  const batchesDir = __dirname;
  const batchFiles = fs.readdirSync(batchesDir)
    .filter(file => file.startsWith('optimized_score_batch_') && file.endsWith('.sql'))
    .sort((a, b) => {
      const numA = parseInt(a.match(/\d+/)[0]);
      const numB = parseInt(b.match(/\d+/)[0]);
      return numA - numB;
    });

  console.log(`📊 Found ${batchFiles.length} batch files`);

  let allStatements = [];
  let batchIndex = 0;

  for (const batchFile of batchFiles) {
    const filePath = path.join(batchesDir, batchFile);
    const content = fs.readFileSync(filePath, 'utf8');
    
    // Split by semicolon followed by newline and comment pattern
    const statements = content
      .split(/;\s*\n\s*--/)
      .map(s => {
        let stmt = s.trim();
        // Remove comment lines at the start
        stmt = stmt.replace(/^--[^\n]*\n/g, '');
        if (!stmt.endsWith(';')) stmt += ';';
        return stmt;
      })
      .filter(s => s.length > 0 && s.includes('INSERT'));

    console.log(`📄 ${batchFile}: ${statements.length} statements`);

    statements.forEach((stmt, idx) => {
      allStatements.push({
        batch: batchIndex + 1,
        statementIndex: idx + 1,
        statement: stmt
      });
    });

    batchIndex++;
  }

  console.log(`\n✅ Total statements prepared: ${allStatements.length}`);
  
  // Save all statements to a JSON file for reference
  fs.writeFileSync(
    path.join(batchesDir, 'all_statements.json'),
    JSON.stringify(allStatements, null, 2)
  );
  
  console.log(`💾 Saved all statements to all_statements.json`);
  
  return allStatements;
}

prepareBatchStatements().catch(console.error);
