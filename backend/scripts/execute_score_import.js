const fs = require('fs');
const path = require('path');

// Read the SQL file
const sqlFile = path.join(__dirname, '../../test_data_2/import_student_scores.sql');
const sqlContent = fs.readFileSync(sqlFile, 'utf8');

// Split into individual statements and fix the ON CONFLICT clause
const statements = sqlContent
  .split(';')
  .map(s => s.trim())
  .filter(s => s.length > 0)
  .map(statement => {
    // Fix ON CONFLICT to match actual constraint (without term_id)
    return statement.replace(
      /ON CONFLICT \(student_id, intervention_id, microcompetency_id, term_id\)/g,
      'ON CONFLICT (student_id, intervention_id, microcompetency_id)'
    );
  });

console.log(`📊 Prepared ${statements.length} SQL statements to execute`);
console.log(`\n⚠️  Note: This will insert/update scores in batches of 50\n`);

// Export statements for execution
module.exports = { statements };

// If run directly, print first few statements as sample
if (require.main === module) {
  console.log('Sample statements (first 3):\n');
  statements.slice(0, 3).forEach((stmt, idx) => {
    console.log(`${idx + 1}. ${stmt.substring(0, 100)}...`);
  });
  console.log(`\n✅ Total: ${statements.length} statements ready for execution`);
}

