// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');
const { query } = require('../src/config/supabase');
const { createClient } = require('@supabase/supabase-js');
const EnhancedUnifiedScoreCalculationServiceV2 = require('../src/services/enhancedUnifiedScoreCalculationServiceV2');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY
);

/**
 * Comprehensive HPS Audit: Recalculate all scores and compare with Excel
 */
async function comprehensiveHPSAudit() {
  try {
    console.log('\n📊 Comprehensive HPS Audit\n');
    console.log('='.repeat(80));
    
    // Service is exported as an instance
    const hpsService = EnhancedUnifiedScoreCalculationServiceV2;
    
    // Get all students
    const studentsResult = await query(
      supabase
        .from('students')
        .select('id, registration_no, name')
        .eq('status', 'Active')
        .order('registration_no')
    );
    
    // Get all terms
    const termsResult = await query(
      supabase
        .from('terms')
        .select('id, name, start_date, end_date')
        .in('name', ['Level 0', 'Level 1', 'Level 2', 'Level 3'])
        .eq('is_active', true)
        .order('start_date')
    );
    
    console.log(`\n📚 Found ${studentsResult.rows.length} students and ${termsResult.rows.length} terms\n`);
    
    // Recalculate all HPS scores
    console.log('🔄 Recalculating HPS scores...\n');
    const calculatedScores = [];
    
    for (const student of studentsResult.rows) {
      for (const term of termsResult.rows) {
        try {
          const result = await hpsService.calculateUnifiedHPS(student.id, term.id);
          calculatedScores.push({
            registration_no: student.registration_no,
            student_name: student.name,
            term_name: term.name,
            calculated_hps: result.totalHPS,
            quadrant_scores: result.quadrantScores,
            grade: result.grade,
            status: result.status
          });
          console.log(`  ✅ ${student.name} - ${term.name}: ${result.totalHPS.toFixed(2)}%`);
        } catch (error) {
          console.error(`  ❌ ${student.name} - ${term.name}: ${error.message}`);
          calculatedScores.push({
            registration_no: student.registration_no,
            student_name: student.name,
            term_name: term.name,
            error: error.message
          });
        }
      }
    }
    
    // Read Excel scores
    console.log('\n📊 Reading Excel scores...\n');
    const excelPath = path.join(__dirname, '../../test_data_2/HPS - Jagsom PEP Grade Updated.xlsx');
    const workbook = XLSX.readFile(excelPath);
    const ws = workbook.Sheets['HPS'];
    const excelData = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    // Parse Excel structure
    const levelRow = excelData[0] || [];
    const headerRow = excelData[1] || [];
    
    const regNoColIndex = headerRow.findIndex(col => 
      col && col.toString().toLowerCase().includes('rn')
    );
    const nameColIndex = headerRow.findIndex(col => 
      col && col.toString().toLowerCase().includes('student name')
    );
    
    const levelPositions = {};
    levelRow.forEach((col, idx) => {
      if (col) {
        const colStr = col.toString().toLowerCase().trim();
        if (colStr.includes('level 0')) levelPositions['Level 0'] = idx;
        else if (colStr.includes('level 1')) levelPositions['Level 1'] = idx;
        else if (colStr.includes('level 2')) levelPositions['Level 2'] = idx;
        else if (colStr.includes('level 3')) levelPositions['Level 3'] = idx;
      }
    });
    
    const finalHPSColIndices = {};
    Object.entries(levelPositions).forEach(([level, levelStart]) => {
      for (let i = levelStart; i < headerRow.length && i < levelStart + 20; i++) {
        if (headerRow[i] && headerRow[i].toString().toLowerCase().includes('final hps')) {
          finalHPSColIndices[level] = i;
          break;
        }
      }
    });
    
    // Extract Excel scores
    const excelScores = {};
    for (let i = 2; i < excelData.length; i++) {
      const row = excelData[i];
      if (!row || !row[regNoColIndex]) continue;
      
      const regNo = row[regNoColIndex].toString().trim();
      const name = row[nameColIndex] ? row[nameColIndex].toString().trim() : '';
      
      if (!regNo) continue;
      
      const studentKey = regNo;
      if (!excelScores[studentKey]) {
        excelScores[studentKey] = {
          registration_no: regNo,
          name: name,
          levels: {}
        };
      }
      
      Object.entries(finalHPSColIndices).forEach(([level, colIdx]) => {
        const score = row[colIdx];
        if (score !== undefined && score !== null && !isNaN(score)) {
          excelScores[studentKey].levels[level] = score;
        }
      });
    }
    
    console.log(`✅ Parsed ${Object.keys(excelScores).length} students from Excel\n`);
    
    // Compare scores
    console.log('📊 Comparing Scores...\n');
    const comparison = [];
    const discrepancies = [];
    
    calculatedScores.forEach(calc => {
      const excel = excelScores[calc.registration_no];
      if (!excel) {
        discrepancies.push({
          registration_no: calc.registration_no,
          student_name: calc.student_name,
          term_name: calc.term_name,
          issue: 'Student not found in Excel',
          calculated_hps: calc.calculated_hps
        });
        return;
      }
      
      const excelScore = excel.levels[calc.term_name];
      if (excelScore === undefined) {
        discrepancies.push({
          registration_no: calc.registration_no,
          student_name: calc.student_name,
          term_name: calc.term_name,
          issue: 'Term score not found in Excel',
          calculated_hps: calc.calculated_hps
        });
        return;
      }
      
      const diff = Math.abs(calc.calculated_hps - excelScore);
      const match = diff < 0.01; // 0.01% tolerance
      
      comparison.push({
        registration_no: calc.registration_no,
        student_name: calc.student_name,
        term_name: calc.term_name,
        calculated_hps: calc.calculated_hps,
        excel_hps: excelScore,
        difference: diff,
        match: match,
        grade: calc.grade
      });
      
      if (!match) {
        discrepancies.push({
          registration_no: calc.registration_no,
          student_name: calc.student_name,
          term_name: calc.term_name,
          calculated_hps: calc.calculated_hps.toFixed(2),
          excel_hps: excelScore.toFixed(2),
          difference: diff.toFixed(2)
        });
      }
    });
    
    // Generate report
    console.log('📈 HPS Comparison Summary:\n');
    console.log('Student'.padEnd(25) + ' | Term     | Calculated | Excel     | Diff     | Match');
    console.log('-'.repeat(25) + '-+-' + '-'.repeat(9) + '-+-' + '-'.repeat(11) + '-+-' + '-'.repeat(9) + '-+-' + '-'.repeat(9) + '-+-' + '-'.repeat(5));
    
    comparison.forEach(comp => {
      const student = (comp.student_name || comp.registration_no).padEnd(25);
      const term = comp.term_name.padEnd(9);
      const calc = comp.calculated_hps.toFixed(2).padStart(10) + '%';
      const excel = comp.excel_hps.toFixed(2).padStart(8) + '%';
      const diff = comp.difference.toFixed(2).padStart(8) + '%';
      const match = comp.match ? '✅' : '❌';
      console.log(`${student} | ${term} | ${calc} | ${excel} | ${diff} | ${match}`);
    });
    
    console.log('\n\n📊 Summary Statistics:');
    console.log(`  Total comparisons: ${comparison.length}`);
    console.log(`  Matches (within 0.01%): ${comparison.filter(c => c.match).length}`);
    console.log(`  Discrepancies: ${discrepancies.length}`);
    
    const differences = comparison.map(c => c.difference);
    if (differences.length > 0) {
      console.log(`  Average difference: ${(differences.reduce((a, b) => a + b, 0) / differences.length).toFixed(2)}%`);
      console.log(`  Max difference: ${Math.max(...differences).toFixed(2)}%`);
      console.log(`  Min difference: ${Math.min(...differences).toFixed(2)}%`);
    }
    
    // Save detailed report
    const reportPath = path.join(__dirname, '../../test_data_2/comprehensive_hps_audit_report.json');
    fs.writeFileSync(reportPath, JSON.stringify({
      calculated_scores: calculatedScores,
      excel_scores: excelScores,
      comparison: comparison,
      discrepancies: discrepancies,
      summary: {
        total_comparisons: comparison.length,
        matches: comparison.filter(c => c.match).length,
        discrepancies_count: discrepancies.length,
        average_difference: differences.length > 0 ? differences.reduce((a, b) => a + b, 0) / differences.length : 0,
        max_difference: differences.length > 0 ? Math.max(...differences) : 0,
        min_difference: differences.length > 0 ? Math.min(...differences) : 0
      },
      timestamp: new Date().toISOString()
    }, null, 2));
    
    console.log(`\n💾 Detailed report saved to: ${reportPath}`);
    
    // Generate markdown report
    const markdownPath = path.join(__dirname, '../../test_data_2/comprehensive_hps_audit_report.md');
    let markdown = '# Comprehensive HPS Audit Report\n\n';
    markdown += `Generated: ${new Date().toISOString()}\n\n`;
    markdown += '## Summary\n\n';
    markdown += `- Total comparisons: ${comparison.length}\n`;
    markdown += `- Matches (within 0.01%): ${comparison.filter(c => c.match).length}\n`;
    markdown += `- Discrepancies: ${discrepancies.length}\n`;
    if (differences.length > 0) {
      markdown += `- Average difference: ${(differences.reduce((a, b) => a + b, 0) / differences.length).toFixed(2)}%\n`;
      markdown += `- Max difference: ${Math.max(...differences).toFixed(2)}%\n`;
      markdown += `- Min difference: ${Math.min(...differences).toFixed(2)}%\n`;
    }
    
    markdown += '\n## Discrepancies\n\n';
    markdown += '| Student | Term | Calculated HPS | Excel HPS | Difference |\n';
    markdown += '|---------|------|----------------|-----------|------------|\n';
    discrepancies.forEach(d => {
      markdown += `| ${d.student_name} | ${d.term_name} | ${d.calculated_hps}% | ${d.excel_hps}% | ${d.difference}% |\n`;
    });
    
    fs.writeFileSync(markdownPath, markdown);
    console.log(`💾 Markdown report saved to: ${markdownPath}`);
    
    return { comparison, discrepancies };
    
  } catch (error) {
    console.error('❌ Comprehensive HPS audit error:', error);
    throw error;
  }
}

// Run if executed directly
if (require.main === module) {
  comprehensiveHPSAudit()
    .then(() => {
      console.log('\n✅ Comprehensive HPS audit completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Comprehensive HPS audit failed:', error);
      process.exit(1);
    });
}

module.exports = { comprehensiveHPSAudit };

