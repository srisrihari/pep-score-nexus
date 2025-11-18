-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Reflection -4 (6 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Reflection -4 (6 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Reflection -4 (6 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Reflection -4 (6 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 2 | Intervention: Reflection -4 (6 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 2 | Intervention: Reflection -4 (6 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 2 | Intervention: Reflection -4 (6 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 2 | Intervention: Reflection -4 (6 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Reflection -4 (6 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Reflection -4 (6 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Reflection -4' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00001 | Level: Level 2 | Intervention: Capstone (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 2 | Intervention: Capstone (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 2 | Intervention: Capstone (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 2 | Intervention: Capstone (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 2 | Intervention: Capstone (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 2 | Intervention: Capstone (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 2 | Intervention: Capstone (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 2 | Intervention: Capstone (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  2.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  2.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 2 | Intervention: Capstone (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 2 | Intervention: Capstone (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'b92e022b-078e-45ee-aff3-c1c6761fb17e'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;