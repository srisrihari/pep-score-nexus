-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: E2
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: E4
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: L1
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: L2
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: N1
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: N3
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: T1
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: T2
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: T3
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: D3
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: D4
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Review 2 | Microcomp: D5
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: C1
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: C2
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: C3
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: C4
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: C5
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: E1
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: E2
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: E4
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: L1
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: L2
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: N1
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: N3
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: T1
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
  1 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: T2
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
  1 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: T3
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: D3
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: D4
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Review 2 | Microcomp: D5
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Review 2'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: C1
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: C2
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: C3
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: C4
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: C5
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: E1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: E2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: E4
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: L1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: L2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: N1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: N3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: T1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: T2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: T3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: D3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: D4
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Review 3 | Microcomp: D5
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: C1
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: C2
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: C3
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: C4
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: C5
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
  4 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: E1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: E2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: E4
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: L1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: L2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: N1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: N3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: T1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: T2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: T3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: D3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: D4
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Review 3 | Microcomp: D5
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: C1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: C2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: C3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: C4
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: C5
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: E1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: E2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: E4
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: L1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: L2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: N1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: N3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: T1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: T2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: T3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: D3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: D4
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Review 3 | Microcomp: D5
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00003'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: C1
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: C2
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: C3
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: C4
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
  3 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: C5
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
  2 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: E1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: E2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: E4
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'E4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: L1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: L2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'L2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: N1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: N3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'N3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: T1
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: T2
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: T3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'T3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Review 3 | Microcomp: D3
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
  0 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Review 3'
  AND i.term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
  AND mc.name = 'D3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;