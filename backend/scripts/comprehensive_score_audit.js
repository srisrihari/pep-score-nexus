// Load environment variables first
require('dotenv').config({ path: require('path').join(__dirname, '../.env') });

const XLSX = require('xlsx');
const fs = require('fs');
const path = require('path');
const { query } = require('../src/config/supabase');
const { createClient } = require('@supabase/supabase-js');

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY || process.env.SUPABASE_ANON_KEY
);

/**
 * Comprehensive audit of all scores across all students, interventions, and terms
 */
async function comprehensiveScoreAudit() {
  try {
    console.log('\n🔍 Comprehensive Score Audit\n');
    console.log('='.repeat(80));
    
    // Get all students
    const studentsResult = await query(
      supabase
        .from('students')
        .select('id, registration_no, name')
        .eq('status', 'Active')
        .order('registration_no')
    );
    
    const studentsMap = {};
    studentsResult.rows.forEach(s => {
      studentsMap[s.registration_no] = s;
    });
    
    console.log(`📚 Found ${studentsResult.rows.length} students\n`);
    
    // Get all terms
    const termsResult = await query(
      supabase
        .from('terms')
        .select('id, name')
        .in('name', ['Level 0', 'Level 1', 'Level 2', 'Level 3'])
        .eq('is_active', true)
        .order('name')
    );
    
    const termsMap = {};
    termsResult.rows.forEach(t => {
      termsMap[t.name] = t;
    });
    
    console.log(`📚 Found ${termsResult.rows.length} terms\n`);
    
    // Get all interventions with their microcompetencies
    const interventionsResult = await query(
      supabase
        .from('interventions')
        .select(`
          id,
          name,
          term_id,
          intervention_microcompetencies(
            microcompetency_id,
            microcompetencies(id, name)
          )
        `)
        .in('term_id', termsResult.rows.map(t => t.id))
    );
    
    console.log(`📚 Found ${interventionsResult.rows.length} interventions\n`);
    
    // Parse Excel files for each level
    const excelDataPath = path.join(__dirname, '../../test_data_2');
    const auditResults = {
      summary: {
        total_students: studentsResult.rows.length,
        total_terms: termsResult.rows.length,
        total_interventions: interventionsResult.rows.length,
        total_comparisons: 0,
        matches: 0,
        discrepancies: 0,
        missing_scores: 0,
        incorrect_scores: 0
      },
      by_term: {},
      by_intervention: {},
      by_student: {},
      issues: []
    };
    
    // Process each term
    for (const term of termsResult.rows) {
      console.log(`\n📅 Processing Term: ${term.name}`);
      console.log('-'.repeat(80));
      
      auditResults.by_term[term.name] = {
        interventions: {},
        issues: [],
        summary: {
          total_comparisons: 0,
          matches: 0,
          discrepancies: 0,
          missing_scores: 0
        }
      };
      
      // Find Excel file for this term
      let excelFile = null;
      let excelSheet = null;
      
      if (term.name === 'Level 0') {
        // Level 0 has multiple files
        const capstoneFile = path.join(excelDataPath, 'Level 0 Capstone(1).xlsx');
        const interventionsFile = path.join(excelDataPath, 'Level 0 - Interventions.xlsx');
        const wellnessFile = path.join(excelDataPath, 'HPS - Jagsom PEP Grade Updated.xlsx');
        
        // Check which files exist
        if (fs.existsSync(capstoneFile)) {
          excelFile = capstoneFile;
          excelSheet = 'Sheet1';
        }
        if (fs.existsSync(interventionsFile)) {
          excelFile = interventionsFile;
          excelSheet = 'Sheet1';
        }
      } else {
        // Level 1, 2, 3
        const levelFile = path.join(excelDataPath, `HPS Input Data - ${term.name} updated.xlsx`);
        if (fs.existsSync(levelFile)) {
          excelFile = levelFile;
          excelSheet = 'Sheet1';
        }
      }
      
      // Also check Wellness sheet
      const wellnessExcelPath = path.join(excelDataPath, 'HPS - Jagsom PEP Grade Updated.xlsx');
      const hpsExcelPath = path.join(excelDataPath, 'HPS - Jagsom PEP Grade Updated.xlsx');
      
      // Get interventions for this term
      const termInterventions = interventionsResult.rows.filter(i => i.term_id === term.id);
      
      console.log(`  Found ${termInterventions.length} interventions`);
      
      // Process each intervention
      for (const intervention of termInterventions) {
        console.log(`\n  📋 Intervention: ${intervention.name}`);
        
        auditResults.by_term[term.name].interventions[intervention.name] = {
          microcompetencies: {},
          issues: [],
          summary: {
            total_comparisons: 0,
            matches: 0,
            discrepancies: 0,
            missing_scores: 0
          }
        };
        
        // Get microcompetencies for this intervention
        const microcomps = (intervention.intervention_microcompetencies || []).map(im => ({
          id: im.microcompetencies.id,
          name: im.microcompetencies.name
        }));
        
        console.log(`    Found ${microcomps.length} microcompetencies`);
        
        // Get scores from database
        const dbScoresResult = await query(
          supabase
            .from('microcompetency_scores')
            .select(`
              student_id,
              microcompetency_id,
              obtained_score,
              max_score,
              status,
              students(registration_no, name),
              microcompetencies(name)
            `)
            .eq('intervention_id', intervention.id)
            .eq('term_id', term.id)
            .eq('status', 'Submitted')
        );
        
        const dbScoresMap = {};
        (dbScoresResult.rows || []).forEach(score => {
          const key = `${score.students.registration_no}_${score.microcompetencies.name}`;
          dbScoresMap[key] = {
            obtained_score: parseFloat(score.obtained_score),
            max_score: parseFloat(score.max_score),
            percentage: (parseFloat(score.obtained_score) / parseFloat(score.max_score)) * 100
          };
        });
        
        // Parse Excel scores based on intervention type
        let excelScoresMap = {};
        
        if (intervention.name.includes('Wellness')) {
          excelScoresMap = await parseWellnessScores(wellnessExcelPath, term.name, studentsMap, microcomps);
        } else if (intervention.name.includes('Behavior')) {
          excelScoresMap = await parseBehaviorScores(hpsExcelPath, term.name, studentsMap, microcomps);
        } else if (intervention.name.includes('Capstone')) {
          excelScoresMap = await parseCapstoneScores(excelDataPath, term.name, studentsMap, microcomps);
        } else {
          // Other interventions (Fearless, etc.)
          excelScoresMap = await parseInterventionScores(excelFile, excelSheet, term.name, intervention.name, studentsMap, microcomps);
        }
        
        // Compare scores
        for (const student of studentsResult.rows) {
          for (const mc of microcomps) {
            const key = `${student.registration_no}_${mc.name}`;
            const dbScore = dbScoresMap[key];
            const excelScore = excelScoresMap[key];
            
            auditResults.summary.total_comparisons++;
            auditResults.by_term[term.name].summary.total_comparisons++;
            auditResults.by_term[term.name].interventions[intervention.name].summary.total_comparisons++;
            
            if (!dbScore && !excelScore) {
              // Both missing - not an issue
              continue;
            }
            
            if (!dbScore && excelScore) {
              // Missing in database
              auditResults.summary.missing_scores++;
              auditResults.by_term[term.name].summary.missing_scores++;
              auditResults.by_term[term.name].interventions[intervention.name].summary.missing_scores++;
              
              const issue = {
                type: 'MISSING_SCORE',
                term: term.name,
                intervention: intervention.name,
                student: student.registration_no,
                microcompetency: mc.name,
                excel_score: excelScore,
                message: `Missing score in database: ${student.registration_no} - ${mc.name} - Expected: ${excelScore.obtained_score}/${excelScore.max_score}`
              };
              
              auditResults.issues.push(issue);
              auditResults.by_term[term.name].issues.push(issue);
              auditResults.by_term[term.name].interventions[intervention.name].issues.push(issue);
              
              console.log(`    ❌ MISSING: ${student.registration_no} - ${mc.name}`);
            } else if (dbScore && !excelScore) {
              // Extra in database
              const issue = {
                type: 'EXTRA_SCORE',
                term: term.name,
                intervention: intervention.name,
                student: student.registration_no,
                microcompetency: mc.name,
                db_score: dbScore,
                message: `Extra score in database (not in Excel): ${student.registration_no} - ${mc.name} - DB: ${dbScore.obtained_score}/${dbScore.max_score}`
              };
              
              auditResults.issues.push(issue);
              auditResults.by_term[term.name].issues.push(issue);
              auditResults.by_term[term.name].interventions[intervention.name].issues.push(issue);
            } else if (dbScore && excelScore) {
              // Both exist - compare
              const diff = Math.abs(dbScore.percentage - excelScore.percentage);
              const tolerance = 0.01; // 0.01% tolerance
              
              if (diff <= tolerance) {
                auditResults.summary.matches++;
                auditResults.by_term[term.name].summary.matches++;
                auditResults.by_term[term.name].interventions[intervention.name].summary.matches++;
              } else {
                auditResults.summary.discrepancies++;
                auditResults.summary.incorrect_scores++;
                auditResults.by_term[term.name].summary.discrepancies++;
                auditResults.by_term[term.name].interventions[intervention.name].summary.discrepancies++;
                
                const issue = {
                  type: 'SCORE_MISMATCH',
                  term: term.name,
                  intervention: intervention.name,
                  student: student.registration_no,
                  microcompetency: mc.name,
                  db_score: dbScore,
                  excel_score: excelScore,
                  difference: diff,
                  message: `Score mismatch: ${student.registration_no} - ${mc.name} - DB: ${dbScore.obtained_score}/${dbScore.max_score} (${dbScore.percentage.toFixed(2)}%) vs Excel: ${excelScore.obtained_score}/${excelScore.max_score} (${excelScore.percentage.toFixed(2)}%) - Diff: ${diff.toFixed(2)}%`
                };
                
                auditResults.issues.push(issue);
                auditResults.by_term[term.name].issues.push(issue);
                auditResults.by_term[term.name].interventions[intervention.name].issues.push(issue);
                
                console.log(`    ⚠️  MISMATCH: ${student.registration_no} - ${mc.name} - DB: ${dbScore.percentage.toFixed(2)}% vs Excel: ${excelScore.percentage.toFixed(2)}%`);
              }
            }
          }
        }
      }
    }
    
    // Generate reports
    const reportPath = path.join(excelDataPath, 'comprehensive_score_audit_report.json');
    fs.writeFileSync(reportPath, JSON.stringify(auditResults, null, 2));
    console.log(`\n💾 Detailed report saved to: ${reportPath}`);
    
    // Generate markdown summary
    const markdownReport = generateMarkdownReport(auditResults);
    const markdownPath = path.join(excelDataPath, 'comprehensive_score_audit_report.md');
    fs.writeFileSync(markdownPath, markdownReport);
    console.log(`💾 Markdown report saved to: ${markdownPath}`);
    
    // Print summary
    console.log('\n\n📊 Audit Summary:');
    console.log('='.repeat(80));
    console.log(`Total Comparisons: ${auditResults.summary.total_comparisons}`);
    console.log(`✅ Matches: ${auditResults.summary.matches}`);
    console.log(`❌ Discrepancies: ${auditResults.summary.discrepancies}`);
    console.log(`⚠️  Missing Scores: ${auditResults.summary.missing_scores}`);
    console.log(`🔴 Incorrect Scores: ${auditResults.summary.incorrect_scores}`);
    
    console.log('\n\n📋 Issues by Type:');
    const issuesByType = {};
    auditResults.issues.forEach(issue => {
      if (!issuesByType[issue.type]) {
        issuesByType[issue.type] = 0;
      }
      issuesByType[issue.type]++;
    });
    Object.entries(issuesByType).forEach(([type, count]) => {
      console.log(`  ${type}: ${count}`);
    });
    
    return auditResults;
    
  } catch (error) {
    console.error('❌ Error in comprehensive score audit:', error);
    throw error;
  }
}

/**
 * Parse Wellness scores from Excel
 */
async function parseWellnessScores(excelPath, termName, studentsMap, microcomps) {
  const scoresMap = {};
  
  try {
    if (!fs.existsSync(excelPath)) {
      return scoresMap;
    }
    
    const workbook = XLSX.readFile(excelPath);
    const ws = workbook.Sheets['Wellness'];
    if (!ws) return scoresMap;
    
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    // Find registration number column (column 1)
    const regNoCol = 1;
    
    // Find microcompetency columns for the term
    // Level 0: columns 4-9
    const termStartCols = {
      'Level 0': 4,
      'Level 1': 11,
      'Level 2': 24,
      'Level 3': 31
    };
    
    const startCol = termStartCols[termName] || 4;
    const microcompCols = {};
    microcomps.forEach((mc, idx) => {
      microcompCols[mc.name] = startCol + idx;
    });
    
    // Parse scores (starting from row 4)
    for (let rowIdx = 4; rowIdx < data.length; rowIdx++) {
      const row = data[rowIdx];
      if (!row || !row[regNoCol]) continue;
      
      const regNo = row[regNoCol].toString().trim();
      const student = studentsMap[regNo];
      
      if (!student) continue;
      
      Object.entries(microcompCols).forEach(([mcName, colIdx]) => {
        const score = row[colIdx];
        if (score !== undefined && score !== null) {
          let scoreValue = null;
          
          if (typeof score === 'number') {
            scoreValue = score;
          } else if (typeof score === 'string') {
            const scoreStr = score.trim().toUpperCase();
            if (scoreStr === 'M' || scoreStr === 'NC') {
              scoreValue = 0;
            } else {
              const parsed = parseFloat(scoreStr);
              if (!isNaN(parsed)) {
                scoreValue = parsed;
              }
            }
          }
          
          if (scoreValue !== null && scoreValue >= 0) {
            // Normalize BCA and other values
            let normalizedScore = scoreValue;
            if (mcName === 'BCA' && scoreValue > 5) {
              normalizedScore = (scoreValue / 100) * 5;
            } else if (scoreValue > 5) {
              normalizedScore = Math.min(scoreValue, 5);
            }
            normalizedScore = Math.max(0, Math.min(5, normalizedScore));
            
            const key = `${regNo}_${mcName}`;
            scoresMap[key] = {
              obtained_score: normalizedScore,
              max_score: 5,
              percentage: (normalizedScore / 5) * 100
            };
          }
        }
      });
    }
  } catch (error) {
    console.error(`Error parsing Wellness scores: ${error.message}`);
  }
  
  return scoresMap;
}

/**
 * Parse Behavior scores from Excel
 */
async function parseBehaviorScores(excelPath, termName, studentsMap, microcomps) {
  const scoresMap = {};
  
  try {
    if (!fs.existsSync(excelPath)) {
      return scoresMap;
    }
    
    const workbook = XLSX.readFile(excelPath);
    const ws = workbook.Sheets['HPS'];
    if (!ws) return scoresMap;
    
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    const headers = data[1];
    const regNoCol = headers.findIndex(h => h && h.toString().toLowerCase().includes('rn'));
    
    // Find level positions
    const levelRow = data[0] || [];
    let levelStart = null;
    levelRow.forEach((col, idx) => {
      if (col && col.toString().toLowerCase().includes(termName.toLowerCase())) {
        levelStart = idx;
      }
    });
    
    if (levelStart === null) return scoresMap;
    
    // Find Behavior Score column (around levelStart + 9)
    let behaviorCol = null;
    for (let i = levelStart; i < levelStart + 15 && i < headers.length; i++) {
      const h = (headers[i] || '').toString().toLowerCase();
      if (h.includes('behavior')) {
        const subHeaders = data[2] || [];
        const sh = (subHeaders[i] || '').toString().toLowerCase();
        if (sh.includes('score')) {
          behaviorCol = i;
          break;
        }
      }
    }
    
    if (behaviorCol === null) return scoresMap;
    
    // Parse scores
    for (let rowIdx = 3; rowIdx < data.length; rowIdx++) {
      const row = data[rowIdx];
      if (!row || !row[regNoCol]) continue;
      
      const regNo = row[regNoCol].toString().trim();
      const student = studentsMap[regNo];
      
      if (!student) continue;
      
      const score = row[behaviorCol];
      if (score !== undefined && score !== null && !isNaN(score) && score > 0) {
        const mc = microcomps[0]; // Behavior has only one microcompetency
        if (mc) {
          const key = `${regNo}_${mc.name}`;
          scoresMap[key] = {
            obtained_score: score,
            max_score: 5,
            percentage: (score / 5) * 100
          };
        }
      }
    }
  } catch (error) {
    console.error(`Error parsing Behavior scores: ${error.message}`);
  }
  
  return scoresMap;
}

/**
 * Parse Capstone scores from Excel
 */
async function parseCapstoneScores(excelDataPath, termName, studentsMap, microcomps) {
  const scoresMap = {};
  
  try {
    const capstoneFile = path.join(excelDataPath, 'Level 0 Capstone(1).xlsx');
    if (!fs.existsSync(capstoneFile)) {
      return scoresMap;
    }
    
    const workbook = XLSX.readFile(capstoneFile);
    const ws = workbook.Sheets[workbook.SheetNames[0]];
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    // Find registration number column
    const headerRow = data[0] || [];
    const regNoCol = headerRow.findIndex(h => h && h.toString().toLowerCase().includes('rn'));
    
    if (regNoCol === -1) return scoresMap;
    
    // Find microcompetency columns
    const microcompCols = {};
    microcomps.forEach(mc => {
      const colIdx = headerRow.findIndex(h => h && h.toString().toLowerCase().includes(mc.name.toLowerCase()));
      if (colIdx !== -1) {
        microcompCols[mc.name] = colIdx;
      }
    });
    
    // Parse scores
    for (let rowIdx = 1; rowIdx < data.length; rowIdx++) {
      const row = data[rowIdx];
      if (!row || !row[regNoCol]) continue;
      
      const regNo = row[regNoCol].toString().trim();
      const student = studentsMap[regNo];
      
      if (!student) continue;
      
      Object.entries(microcompCols).forEach(([mcName, colIdx]) => {
        const score = row[colIdx];
        if (score !== undefined && score !== null && !isNaN(score) && score >= 0) {
          const key = `${regNo}_${mcName}`;
          scoresMap[key] = {
            obtained_score: score,
            max_score: 5,
            percentage: (score / 5) * 100
          };
        }
      });
    }
  } catch (error) {
    console.error(`Error parsing Capstone scores: ${error.message}`);
  }
  
  return scoresMap;
}

/**
 * Parse other intervention scores from Excel
 */
async function parseInterventionScores(excelFile, excelSheet, termName, interventionName, studentsMap, microcomps) {
  const scoresMap = {};
  
  try {
    if (!excelFile || !fs.existsSync(excelFile)) {
      return scoresMap;
    }
    
    const workbook = XLSX.readFile(excelFile);
    const ws = workbook.Sheets[excelSheet || workbook.SheetNames[0]];
    const data = XLSX.utils.sheet_to_json(ws, { header: 1 });
    
    // Implementation depends on Excel structure
    // This is a placeholder - would need to be customized per intervention type
    
  } catch (error) {
    console.error(`Error parsing intervention scores: ${error.message}`);
  }
  
  return scoresMap;
}

/**
 * Generate markdown report
 */
function generateMarkdownReport(auditResults) {
  let report = '# Comprehensive Score Audit Report\n\n';
  report += `Generated: ${new Date().toISOString()}\n\n`;
  
  report += '## Summary\n\n';
  report += `- **Total Comparisons**: ${auditResults.summary.total_comparisons}\n`;
  report += `- **✅ Matches**: ${auditResults.summary.matches}\n`;
  report += `- **❌ Discrepancies**: ${auditResults.summary.discrepancies}\n`;
  report += `- **⚠️ Missing Scores**: ${auditResults.summary.missing_scores}\n`;
  report += `- **🔴 Incorrect Scores**: ${auditResults.summary.incorrect_scores}\n\n`;
  
  report += '## Issues by Type\n\n';
  const issuesByType = {};
  auditResults.issues.forEach(issue => {
    if (!issuesByType[issue.type]) {
      issuesByType[issue.type] = [];
    }
    issuesByType[issue.type].push(issue);
  });
  
  Object.entries(issuesByType).forEach(([type, issues]) => {
    report += `### ${type} (${issues.length})\n\n`;
    issues.slice(0, 50).forEach(issue => {
      report += `- ${issue.message}\n`;
    });
    if (issues.length > 50) {
      report += `\n... and ${issues.length - 50} more\n`;
    }
    report += '\n';
  });
  
  report += '## Issues by Term\n\n';
  Object.entries(auditResults.by_term).forEach(([termName, termData]) => {
    report += `### ${termName}\n\n`;
    report += `- Total Comparisons: ${termData.summary.total_comparisons}\n`;
    report += `- Matches: ${termData.summary.matches}\n`;
    report += `- Discrepancies: ${termData.summary.discrepancies}\n`;
    report += `- Missing Scores: ${termData.summary.missing_scores}\n\n`;
    
    if (termData.issues.length > 0) {
      report += `**Issues (${termData.issues.length}):**\n\n`;
      termData.issues.slice(0, 20).forEach(issue => {
        report += `- ${issue.message}\n`;
      });
      if (termData.issues.length > 20) {
        report += `\n... and ${termData.issues.length - 20} more\n`;
      }
      report += '\n';
    }
  });
  
  return report;
}

// Run if executed directly
if (require.main === module) {
  comprehensiveScoreAudit()
    .then(() => {
      console.log('\n✅ Comprehensive score audit completed');
      process.exit(0);
    })
    .catch((error) => {
      console.error('\n❌ Comprehensive score audit failed:', error);
      process.exit(1);
    });
}

module.exports = { comprehensiveScoreAudit };

