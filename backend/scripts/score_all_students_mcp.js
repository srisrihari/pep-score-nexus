const fs = require('fs');
const path = require('path');

// Read the student scores JSON
const scoresData = JSON.parse(
  fs.readFileSync(path.join(__dirname, '../../test_data_2/student_scores_final.json'), 'utf8')
);

// Get all IDs
const termId = '033dad1c-da84-4e90-b867-f7f0b3b2f664';
const teacherId = '1a1aa901-d33c-4cf5-adae-c205677c6bc3';

// Student IDs mapping
const studentIds = {
  '2024JULB00001': '613b4e1d-331f-4b0a-b6ff-941198610cfb',
  '2024JULB00002': '4a4fff20-6685-4331-8db8-091471ad98fa',
  '2024JULB00003': 'a2d12128-3445-4f49-a757-54a4e723fad1',
  '2024JULB00004': '9fa5d66f-23db-4f14-87bf-815e6249ce10',
  '2024JULB00005': '725bb3df-3cfb-4b10-a9c1-a48875a6c8c2',
  '2024JULB00006': 'b294952f-dd1f-45d3-a814-0dc1d0c7b625',
  '2024JULB00007': 'd852a168-d8ce-440d-8de5-8b189a567388',
  '2024JULB00008': 'a98a3174-4877-487a-aeb2-d508339707b1',
  '2024JULB00009': '65e8800b-9eed-4990-9b21-b1a8cd7583ea',
  '2024JULB00012': '32b6f5d2-4c03-409e-87f4-da87ca94dab3'
};

// Intervention IDs mapping
const interventionIds = {
  'Storytelling Presentation': 'dbc6f3c2-2737-4fc7-80aa-6009d17ba80a',
  'Book Review Presentation': '6fccc505-a3b7-473c-aa75-d6a4cab0d9d5',
  'Interpersonal Role Play': '945a777b-ab7c-420f-8458-cd7a68e0754c',
  'Case Study Analysis': '557cd127-32eb-4a8a-ae46-d3ebfa77c835',
  'Business Proposal Report': 'b7f45a4d-de81-464d-8214-f9835b42e0a4',
  'Email Writing': '7aa4585b-7c48-45f0-a3ca-f8143d1ef547',
  'Debating': 'e2a08f20-d6f7-4e32-afd9-7d96eb146ef4'
};

// Microcompetency IDs mapping (will be fetched from DB)
const microcompIds = {};

// Generate SQL for all scores
const generateSQL = () => {
  const sqlStatements = [];
  
  scoresData.students.forEach((studentData, studentIdx) => {
    const studentId = studentIds[studentData.registration_no];
    if (!studentId) {
      console.warn(`⚠️ Student ${studentData.registration_no} not found`);
      return;
    }
    
    studentData.interventions.forEach((interventionData, intIdx) => {
      const interventionId = interventionIds[interventionData.intervention_name];
      if (!interventionId) {
        console.warn(`⚠️ Intervention ${interventionData.intervention_name} not found`);
        return;
      }
      
      // Generate INSERT statement for this student-intervention combination
      const values = [];
      Object.entries(interventionData.microcompetency_scores).forEach(([microcompName, score]) => {
        values.push(
          `('${studentId}', '${interventionId}', ` +
          `(SELECT id FROM microcompetencies WHERE name = '${microcompName}'), ` +
          `${score}, 5, '${teacherId}', NOW(), '', 'Submitted', '${termId}')`
        );
      });
      
      if (values.length > 0) {
        const sql = `INSERT INTO microcompetency_scores (
  student_id, intervention_id, microcompetency_id, obtained_score, max_score,
  scored_by, scored_at, feedback, status, term_id
) VALUES
${values.join(',\n')}
ON CONFLICT (student_id, intervention_id, microcompetency_id, term_id) 
DO UPDATE SET 
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status;`;
        
        sqlStatements.push({
          student: studentData.registration_no,
          studentName: studentData.name,
          intervention: interventionData.intervention_name,
          sql: sql,
          scoreCount: values.length
        });
      }
    });
  });
  
  return sqlStatements;
};

const sqlStatements = generateSQL();

// Write SQL to file for manual execution
const outputPath = path.join(__dirname, '../../test_data_2/all_scores_sql.sql');
const sqlContent = sqlStatements.map((stmt, idx) => {
  return `-- Student: ${stmt.studentName} (${stmt.student}) - Intervention: ${stmt.intervention} (${stmt.scoreCount} scores)\n${stmt.sql};\n`;
}).join('\n\n');

fs.writeFileSync(outputPath, sqlContent);
console.log(`✅ Generated ${sqlStatements.length} SQL statements`);
console.log(`📄 Saved to: ${outputPath}`);

// Print summary
console.log('\n📊 Summary:');
const summary = {};
sqlStatements.forEach(stmt => {
  if (!summary[stmt.student]) {
    summary[stmt.student] = { name: stmt.studentName, interventions: 0, scores: 0 };
  }
  summary[stmt.student].interventions++;
  summary[stmt.student].scores += stmt.scoreCount;
});

Object.values(summary).forEach(student => {
  console.log(`  ${student.name}: ${student.interventions} interventions, ${student.scores} scores`);
});

console.log(`\n✅ Total: ${sqlStatements.length} student-intervention combinations, ${sqlStatements.reduce((sum, s) => sum + s.scoreCount, 0)} scores`);

