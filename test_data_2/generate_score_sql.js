const fs = require('fs');
const path = require('path');

// Our 10 students
const ourStudents = [
  '2024JULB00001', '2024JULB00002', '2024JULB00003', '2024JULB00004', '2024JULB00005',
  '2024JULB00006', '2024JULB00007', '2024JULB00008', '2024JULB00009', '2024JULB00012'
];

// Term and intervention mappings
const termMapping = {
  'Level 0': 'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8',
  'Level 1': 'ea9a7617-a53e-421f-bf8b-13a0fb908b55',
  'Level 2': 'b92e022b-078e-45ee-aff3-c1c6761fb17e',
  'Level 3': '4f49e30e-27df-47b8-bede-e0c0c2a988dc'
};

const interventionMapping = {
  'Level 0': {
    'Fearless (Level 0)': 'Fearless (Level 0)'
  },
  'Level 1': {
    'Storytelling Presentation': 'Storytelling Presentation',
    'Book Review Presentation': 'Book Review Presentation',
    'Interpersonal Role Play': 'Interpersonal Role Play',
    'Business Proposal Report': 'Business Proposal Report',
    'Email Writing': 'Email Writing',
    'Case Study Analysis': 'Case Study Analysis',
    'Problem Solving': 'Case Study Analysis', // Map Problem Solving to Case Study Analysis
    'Debating': 'Debating',
    'Capstone': 'Capstone'
  },
  'Level 2': {
    'Review 1': 'Review 1',
    'Review 2': 'Review 2',
    'Review 3': 'Review 3',
    'Review 4': 'Review 4',
    'Reflection -1 ': 'Reflection -1 ',
    'Reflection -2': 'Reflection -2',
    'Reflection -3': 'Reflection -3',
    'Reflection -4': 'Reflection -4',
    'Capstone': 'Capstone'
  },
  'Level 3': {
    'Book Review': 'Book Review',
    'Debate': 'Debate',
    'GD': 'GD',
    'Case study': 'Case study',
    'Capstone': 'Capstone'
  }
};

const teacherId = '1a1aa901-d33c-4cf5-adae-c205677c6bc3';
const maxScore = 5;

// Load parsed scores
const allScores = JSON.parse(fs.readFileSync(path.join(__dirname, 'all_levels_scores.json'), 'utf8'));

// Filter to only our 10 students
const filteredScores = allScores.filter(score => ourStudents.includes(score.registrationNo));

console.log(`📊 Filtered scores: ${filteredScores.length} scores for our 10 students`);
console.log(`   (from ${allScores.length} total scores)`);

// Group by student, level, intervention
const groupedScores = {};
filteredScores.forEach(score => {
  const key = `${score.registrationNo}|${score.level}|${score.intervention}`;
  if (!groupedScores[key]) {
    groupedScores[key] = {
      registrationNo: score.registrationNo,
      level: score.level,
      intervention: score.intervention,
      scores: {}
    };
  }
  groupedScores[key].scores[score.microcompetency] = score.score;
});

console.log(`\n📋 Grouped into ${Object.keys(groupedScores).length} student-intervention combinations`);

// Save filtered and grouped scores
fs.writeFileSync(
  path.join(__dirname, 'filtered_scores_for_10_students.json'),
  JSON.stringify(Object.values(groupedScores), null, 2)
);

console.log('\n✅ Filtered scores saved to: filtered_scores_for_10_students.json');

// Summary
const summary = {};
Object.values(groupedScores).forEach(item => {
  if (!summary[item.level]) summary[item.level] = {};
  if (!summary[item.level][item.intervention]) summary[item.level][item.intervention] = 0;
  summary[item.level][item.intervention]++;
});

console.log('\n📊 Summary by Level (for our 10 students):');
Object.keys(summary).sort().forEach(level => {
  console.log(`\n${level}:`);
  Object.entries(summary[level]).forEach(([intervention, count]) => {
    console.log(`  ${intervention}: ${count} students`);
  });
});

