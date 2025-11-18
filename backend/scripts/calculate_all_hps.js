// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const { supabase, query } = require('../src/config/supabase');
const enhancedHPSCalculationService = require('../src/services/enhancedUnifiedScoreCalculationServiceV2');

/**
 * Calculate HPS for all students across all terms
 */
async function calculateAllHPS() {
  try {
    // Get all active students
    const studentsResult = await query(
      supabase
        .from('students')
        .select('id, registration_no, name')
        .eq('status', 'Active')
        .order('registration_no')
    );

    // Get all active terms
    const termsResult = await query(
      supabase
        .from('terms')
        .select('id, name, start_date, end_date')
        .eq('is_active', true)
        .order('start_date')
    );

    const students = studentsResult.rows || [];
    const terms = termsResult.rows || [];

    console.log(`\n📊 Starting HPS calculation for ${students.length} students across ${terms.length} terms\n`);

    const results = [];
    let successCount = 0;
    let errorCount = 0;

    for (const student of students) {
      console.log(`\n👤 Processing student: ${student.name} (${student.registration_no})`);
      
      for (const term of terms) {
        try {
          console.log(`  📅 Calculating HPS for term: ${term.name}...`);
          
          const hpsResult = await enhancedHPSCalculationService.calculateUnifiedHPS(
            student.id,
            term.id
          );

          const hpsScore = hpsResult.totalHPS || hpsResult.hps || 0;
          
          results.push({
            student_id: student.id,
            student_name: student.name,
            registration_no: student.registration_no,
            term_id: term.id,
            term_name: term.name,
            hps_score: hpsScore,
            success: true
          });

          console.log(`    ✅ HPS: ${hpsScore.toFixed(2)}%`);
          successCount++;
        } catch (error) {
          console.error(`    ❌ Error calculating HPS for ${student.name} in ${term.name}:`, error.message);
          
          results.push({
            student_id: student.id,
            student_name: student.name,
            registration_no: student.registration_no,
            term_id: term.id,
            term_name: term.name,
            hps_score: null,
            success: false,
            error: error.message
          });
          
          errorCount++;
        }
      }
    }

    console.log(`\n\n📈 HPS Calculation Summary:`);
    console.log(`  ✅ Successful: ${successCount}`);
    console.log(`  ❌ Failed: ${errorCount}`);
    console.log(`  📊 Total calculations: ${successCount + errorCount}`);

    // Save results to JSON file
    const fs = require('fs');
    const path = require('path');
    const outputPath = path.join(__dirname, '../../test_data_2/hps_calculation_results.json');
    fs.writeFileSync(outputPath, JSON.stringify(results, null, 2));
    console.log(`\n💾 Results saved to: ${outputPath}`);

    // Display summary table
    console.log(`\n📋 HPS Scores Summary:\n`);
    console.log('Student'.padEnd(25) + ' | ' + terms.map(t => t.name.padEnd(12)).join(' | '));
    console.log('-'.repeat(25) + '-+-' + terms.map(() => '-'.repeat(12)).join('-+-'));

    students.forEach(student => {
      const studentResults = results.filter(r => r.student_id === student.id);
      const scores = terms.map(term => {
        const result = studentResults.find(r => r.term_id === term.id);
        return result && result.success 
          ? result.hps_score.toFixed(2).padStart(10) + '%'
          : 'N/A'.padStart(13);
      });
      console.log(student.name.padEnd(25) + ' | ' + scores.join(' | '));
    });

    return results;
  } catch (error) {
    console.error('❌ Fatal error in calculateAllHPS:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  calculateAllHPS()
    .then(() => {
      console.log('\n✅ HPS calculation completed successfully');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ HPS calculation failed:', error);
      process.exit(1);
    });
}

module.exports = { calculateAllHPS };

