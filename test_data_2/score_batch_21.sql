-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: A1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: A2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: A3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: A4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: C1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: C2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: C3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: C4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: C5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: E2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: P1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: P2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: P4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: T1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: D4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Book Review | Microcomp: D5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00006'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: A1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: A2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: A3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: A4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: C1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: C2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: C3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: C4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: C5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: E2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: P1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: P2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: P4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: T1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: D4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review | Microcomp: D5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00007'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: A1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: A2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: A3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: A4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: C1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: C2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: C3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: C4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: C5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: E2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: P1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: P2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: P4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: T1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: D4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review | Microcomp: D5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00008'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: A1
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: A2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: A3
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: A4
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: C1
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: C2
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: C3
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: C4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: C5
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: E2
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: P1
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: P2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: P4
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: T1
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
  3.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: D4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review | Microcomp: D5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00009'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: A1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: A2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: A3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: A4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: C1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: C2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: C3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: C4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: C5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: E2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'E2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: P1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: P2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: P4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: T1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: D4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review | Microcomp: D5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00012'
  AND i.name = 'Book Review'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: A3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: C1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: C2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: C3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: C4
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
  0.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: C5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: L1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'L1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: P1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: P2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: P4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'P4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: T1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'T1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: D4
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate | Microcomp: D5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00001'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'D5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 3 | Intervention: Debate | Microcomp: A3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'A3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 3 | Intervention: Debate | Microcomp: C1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 3 | Intervention: Debate | Microcomp: C2
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C2'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 3 | Intervention: Debate | Microcomp: C3
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C3'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 3 | Intervention: Debate | Microcomp: C4
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
  1.5 as obtained_score,
  5 as max_score,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid as scored_by,
  NOW() as scored_at,
  '' as feedback,
  'Submitted' as status,
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C4'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 3 | Intervention: Debate | Microcomp: C5
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'C5'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 3 | Intervention: Debate | Microcomp: L1
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
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid as term_id
FROM students s
CROSS JOIN interventions i
CROSS JOIN microcompetencies mc
WHERE s.registration_no = '2024JULB00002'
  AND i.name = 'Debate'
  AND i.term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
  AND mc.name = 'L1'
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;