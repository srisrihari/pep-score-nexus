const fs = require('fs');
const path = require('path');

// Read the scores JSON file
const scoresFile = path.join(__dirname, '../../test_data_2/student_scores_final.json');
const scoresData = JSON.parse(fs.readFileSync(scoresFile, 'utf8'));

// Database mappings (will be populated from queries)
const termId = 'bb915766-7519-4d94-8ced-d4905c9316ea';
const teacherId = '3043b298-2936-454e-a0ef-c8b011902ffb';

// Student mapping: registration_no -> student_id
const studentMap = {
  '2024JULB00001': 'ae2afe58-e93d-407e-8fc4-aaf872c8f01c',
  '2024JULB00002': 'a50551ab-dec7-45ad-a9b1-e074ec566e3e',
  '2024JULB00003': '92b206e1-6a4a-4d41-bd60-0c5147c1bc8a',
  '2024JULB00004': 'c6c2f32c-656e-4892-93e0-d6b2d2d603d7',
  '2024JULB00005': '9f613098-7296-4bbd-83e6-462eae1361e1',
  '2024JULB00006': '2f88e965-24b7-4447-ba70-e09eb9ff91d4',
  '2024JULB00007': 'c2757959-f9cc-4664-b7d6-c29f2de4f499',
  '2024JULB00008': '99572083-d161-4ac0-b40f-55c42a355ae0',
  '2024JULB00009': '9736b503-e456-450f-a627-96b94cca1188',
  '2024JULB00012': '327fa1e3-b55d-4d7e-81b2-310305a2b206'
};

// Intervention mapping: name -> intervention_id
const interventionMap = {
  'Storytelling Presentation': '10592226-5c71-4347-98d1-bef3f268c3e6',
  'Book Review Presentation': 'e3333bcf-0063-4695-953d-c265841e70ef',
  'Interpersonal Role Play': '2afd5445-be87-42ce-81fb-2d336589e1c1',
  'Business Proposal Report': '0d049f75-7f7a-47a6-bec2-4ca28aa65032',
  'Email Writing': '9ffaa769-b766-4f79-ad27-3856a93864d2',
  'Case Study Analysis': '188785d1-0099-46d8-aee2-e68ef52677f5',
  'Debating': '662c0bb2-b01f-4cf0-a8e7-2ceaf0439e0d',
  'Capstone': null // Capstone is not in our interventions, will skip
};

// Microcompetency mapping: code -> microcompetency_id
// Regular microcompetencies (without (C) suffix)
const microcompMap = {
  'A1': '4476c3a6-58da-4c43-9b8a-b1da70172072',
  'A2': '31a4c844-6a46-4b57-a23d-91d9a5ff7382',
  'A3': '4d6b4184-d62e-427a-ba00-16ff3f4e4f10',
  'A4': '06947927-aab0-4d24-b5fe-b42c0b83050c',
  'C1': '7e8983cd-5a94-49cc-9b80-64358a9d48f9',
  'C2': '685d23ad-eadc-47ac-9f91-8f741ae4211f',
  'C3': '2e599a1f-e34d-436c-98f9-01f019cb29bd',
  'C4': '1b63c6c1-36b6-49b5-a61f-1c3f2b85bdb1',
  'C5': '44a43cc4-8d2e-4ce5-b437-2b76a205ea84',
  'D3': '0322c72d-2fbf-462d-9a59-76e1550b30d9',
  'D4': 'ec97e568-30d6-4e8f-acb3-b74d1b4b5436',
  'D5': '41ab0a41-f16e-4bd5-961e-5b070acd6410',
  'E1': '08314805-8508-4254-997b-a035415747d5',
  'E3': '76e855c0-ec81-4eae-a010-0e23b76426f1',
  'L1': '2d2976b5-f9bb-42e8-aca0-d6e6b6e6de77',
  'N1': 'adbc17f9-6f88-4144-afe1-e29f3a0bd21e',
  'N2': 'bcb48067-c6be-4c39-87bc-08618f18ef4e',
  'N3': '955efb94-7eac-4392-969a-732f19143f89',
  'P1': '88fad813-46ed-4601-a334-ae77df797be3',
  'P2': '9358b2c4-aebc-480a-9eff-6873c156da12',
  'P3': 'd5760d32-ce61-48fd-988e-9bd16cc52ca1',
  'P4': '7022a346-204b-472a-b46b-b801f07e8853',
  'T1': '6852ffde-5e9e-4faa-be78-93d194b1f8b7',
  'T2': 'de38ca59-7d04-4de2-acfd-6daf46162a07',
  'T3': '6350fa4f-4163-42b7-a37a-16be275b9418',
  'T4': '7453ffe7-e829-4f52-a16b-44efbc183640',
  'T5': 'fbd8f3d7-1bbe-4e3c-955f-c370b9f7f680'
};

// Generate SQL INSERT statements
const sqlStatements = [];
let totalScores = 0;
let skippedScores = 0;

console.log('📊 Generating SQL INSERT statements for student scores...\n');

scoresData.students.forEach((student) => {
  const studentId = studentMap[student.registration_no];
  if (!studentId) {
    console.log(`⚠️  Student ${student.registration_no} not found in mapping`);
    return;
  }

  student.interventions.forEach((intervention) => {
    const interventionId = interventionMap[intervention.intervention_name];
    
    // Skip Capstone as it's not in our interventions
    if (!interventionId || intervention.intervention_name === 'Capstone') {
      if (intervention.intervention_name === 'Capstone') {
        skippedScores += Object.keys(intervention.microcompetency_scores).length;
      }
      return;
    }

    Object.keys(intervention.microcompetency_scores).forEach((mcCode) => {
      const score = intervention.microcompetency_scores[mcCode];
      const microcompId = microcompMap[mcCode];
      
      if (!microcompId) {
        console.log(`⚠️  Microcompetency ${mcCode} not found in mapping`);
        skippedScores++;
        return;
      }

      // Calculate percentage (assuming max_score is 5, adjust if needed)
      const maxScore = 5;
      const percentage = (score / maxScore) * 100;

      sqlStatements.push(
        `INSERT INTO microcompetency_scores (` +
        `student_id, intervention_id, microcompetency_id, obtained_score, max_score, ` +
        `percentage, scored_by, scored_at, feedback, status, term_id` +
        `) VALUES (` +
        `'${studentId}', '${interventionId}', '${microcompId}', ${score}, ${maxScore}, ` +
        `${percentage}, '${teacherId}', NOW(), '', 'Submitted', '${termId}'` +
        `) ON CONFLICT (student_id, intervention_id, microcompetency_id, term_id) ` +
        `DO UPDATE SET ` +
        `obtained_score = EXCLUDED.obtained_score, ` +
        `percentage = EXCLUDED.percentage, ` +
        `scored_at = EXCLUDED.scored_at, ` +
        `status = EXCLUDED.status;`
      );
      
      totalScores++;
    });
  });
});

console.log(`✅ Generated ${sqlStatements.length} SQL INSERT statements`);
console.log(`📊 Total scores to insert: ${totalScores}`);
console.log(`⚠️  Skipped scores: ${skippedScores} (Capstone and unmapped microcompetencies)\n`);

// Write SQL to file
const sqlFile = path.join(__dirname, '../../test_data_2/import_student_scores.sql');
fs.writeFileSync(sqlFile, sqlStatements.join('\n'));

console.log(`💾 SQL file written to: ${sqlFile}`);
console.log(`\n⚠️  NOTE: You need to set teacherId in the SQL file before executing!`);

