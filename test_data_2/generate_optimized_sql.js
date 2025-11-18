const fs = require('fs');
const path = require('path');

// Generate optimized SQL with multiple VALUES per INSERT

const termMapping = {
  'Level 0': 'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8',
  'Level 1': 'ea9a7617-a53e-421f-bf8b-13a0fb908b55',
  'Level 2': 'b92e022b-078e-45ee-aff3-c1c6761fb17e',
  'Level 3': '4f49e30e-27df-47b8-bede-e0c0c2a988dc'
};

const teacherId = '1a1aa901-d33c-4cf5-adae-c205677c6bc3';
const maxScore = 5;

// Load filtered scores
const groupedScores = JSON.parse(
  fs.readFileSync(path.join(__dirname, 'filtered_scores_for_10_students.json'), 'utf8')
);

console.log(`📊 Generating optimized SQL for ${groupedScores.length} student-intervention combinations...`);

// Group by intervention for more efficient inserts
const byIntervention = {};
groupedScores.forEach(item => {
  const key = `${item.level}|${item.intervention}`;
  if (!byIntervention[key]) {
    byIntervention[key] = {
      level: item.level,
      intervention: item.intervention,
      students: {}
    };
  }
  byIntervention[key].students[item.registrationNo] = item.scores;
});

const sqlStatements = [];

Object.values(byIntervention).forEach(({ level, intervention, students }) => {
  // Generate one INSERT per student for this intervention
  Object.entries(students).forEach(([registrationNo, scores]) => {
    const values = [];
    Object.entries(scores).forEach(([microcompCode, scoreValue]) => {
      values.push(`(
  (SELECT id FROM students WHERE registration_no = '${registrationNo}'),
  (SELECT id FROM interventions WHERE name = '${intervention}' AND term_id = '${termMapping[level]}'::uuid),
  (SELECT id FROM microcompetencies WHERE name = '${microcompCode}'),
  ${scoreValue},
  ${maxScore},
  '${teacherId}'::uuid,
  NOW(),
  '',
  'Submitted',
  '${termMapping[level]}'::uuid
)`);
    });
    
    if (values.length > 0) {
      const sql = `-- Student: ${registrationNo} | Level: ${level} | Intervention: ${intervention} (${values.length} scores)
INSERT INTO microcompetency_scores (
  student_id,
  intervention_id,
  microcompetency_id,
  obtained_score,
  max_score,
  scored_by,
  scored_at,
  feedback,
  status,
  term_id
) VALUES
${values.join(',\n')}
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;`;
      
      sqlStatements.push(sql);
    }
  });
});

console.log(`\n✅ Generated ${sqlStatements.length} optimized SQL statements`);

// Save to file (split into batches of 20 - each statement handles one student-intervention)
const batchSize = 20;
const batches = [];
for (let i = 0; i < sqlStatements.length; i += batchSize) {
  batches.push(sqlStatements.slice(i, i + batchSize));
}

batches.forEach((batch, batchIndex) => {
  const batchFile = path.join(__dirname, `optimized_score_batch_${batchIndex + 1}.sql`);
  fs.writeFileSync(batchFile, batch.join('\n\n'));
});

console.log(`📄 Split into ${batches.length} batch files (${batchSize} statements each)`);
console.log(`\n📋 Ready to execute!`);

