const fs = require('fs');
const path = require('path');

// This script generates SQL INSERT statements for all scores
// Then we'll execute them via Supabase MCP

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

console.log(`📊 Generating SQL for ${groupedScores.length} student-intervention combinations...`);

// We'll need to fetch IDs from database first
// For now, generate SQL template with placeholders
const sqlStatements = [];

groupedScores.forEach((item, index) => {
  const { registrationNo, level, intervention, scores } = item;
  
  // Generate SQL for each microcompetency score
  Object.entries(scores).forEach(([microcompCode, scoreValue]) => {
    const sql = `-- Student: ${registrationNo} | Level: ${level} | Intervention: ${intervention} | Microcomp: ${microcompCode}
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
)
SELECT 
  s.id as student_id,
  i.id as intervention_id,
  mc.id as microcompetency_id,
  ${scoreValue} as obtained_score,
  ${maxScore} as max_score,
  '${teacherId}'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '${termMapping[level]}'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '${registrationNo}'
  AND i.name = '${intervention}'
  AND i.term_id = '${termMapping[level]}'::uuid
  AND mc.name = '${microcompCode}'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;`;
    
    sqlStatements.push(sql);
  });
});

console.log(`\n✅ Generated ${sqlStatements.length} SQL statements`);

// Save to file (split into batches of 100)
const batchSize = 100;
const batches = [];
for (let i = 0; i < sqlStatements.length; i += batchSize) {
  batches.push(sqlStatements.slice(i, i + batchSize));
}

batches.forEach((batch, batchIndex) => {
  const batchFile = path.join(__dirname, `score_batch_${batchIndex + 1}.sql`);
  fs.writeFileSync(batchFile, batch.join('\n\n'));
});

console.log(`📄 Split into ${batches.length} batch files (${batchSize} statements each)`);
console.log(`\n📋 Files created:`);
batches.forEach((batch, index) => {
  console.log(`   score_batch_${index + 1}.sql (${batch.length} statements)`);
});

