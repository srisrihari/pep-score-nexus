-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: C1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: C2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: C3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: C5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: E1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'E1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: E3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'E3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: P1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: P2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: P3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: P4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: T1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: D4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: D5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: A1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: A2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: A3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: A4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: C1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: C2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: C3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: C5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: E1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'E1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: P1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: P2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: P4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: T1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: D4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: D5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Interpersonal Role Play | Microcomp: N1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Interpersonal Role Play'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'N1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Interpersonal Role Play | Microcomp: N2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Interpersonal Role Play'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'N2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Interpersonal Role Play | Microcomp: N3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Interpersonal Role Play'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'N3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Interpersonal Role Play | Microcomp: D4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Interpersonal Role Play'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Business Proposal Report | Microcomp: C4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Business Proposal Report'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Business Proposal Report | Microcomp: E1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Business Proposal Report'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'E1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Business Proposal Report | Microcomp: P1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Business Proposal Report'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Business Proposal Report | Microcomp: P2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Business Proposal Report'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Business Proposal Report | Microcomp: P3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Business Proposal Report'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Business Proposal Report | Microcomp: P4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Business Proposal Report'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Business Proposal Report | Microcomp: T1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Business Proposal Report'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Business Proposal Report | Microcomp: D3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Business Proposal Report'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Business Proposal Report | Microcomp: D4
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
  5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Business Proposal Report'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Email Writing | Microcomp: C1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Email Writing'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Email Writing | Microcomp: C2
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
  4.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Email Writing'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Email Writing | Microcomp: C3
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
  5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Email Writing'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Email Writing | Microcomp: C4
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
  4.375 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Email Writing'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: P1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: P2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: P3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: P4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: T1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: T2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: T3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: T4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: T5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: D4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis | Microcomp: D5
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
  5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Case Study Analysis'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: A3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: C2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: C3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: C5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: L1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'L1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: P1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: P2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: P4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: T1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: D4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Debating | Microcomp: D5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Debating'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: A3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: C2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: C3
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
  5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: C5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: L1
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
  5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'L1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: P1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: P2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: P4
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
  5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: T1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: D4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Capstone | Microcomp: D5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00004'
  AND i.name = 'Capstone'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: A1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: A2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: A3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: A4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: C1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: C2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: C3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: C5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: E1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'E1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: E3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'E3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: P1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: P2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: P3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: P4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: T1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: D4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Storytelling Presentation | Microcomp: D5
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Storytelling Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: A1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: A2
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: A3
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: A4
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'A4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Book Review Presentation | Microcomp: C1
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
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00005'
  AND i.name = 'Book Review Presentation'
  AND i.term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;