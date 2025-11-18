-- Student: 2024JULB00001 | Level: Level 1 | Intervention: Case Study Analysis (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  2.666666667,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T2'),
  2.666666667,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T3'),
  2.555555556,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T4'),
  2.777777778,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T5'),
  2.722222222,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00002 | Level: Level 1 | Intervention: Case Study Analysis (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00003 | Level: Level 1 | Intervention: Case Study Analysis (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Case Study Analysis (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Case Study Analysis (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00006 | Level: Level 1 | Intervention: Case Study Analysis (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00007 | Level: Level 1 | Intervention: Case Study Analysis (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00008 | Level: Level 1 | Intervention: Case Study Analysis (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00009 | Level: Level 1 | Intervention: Case Study Analysis (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Student: 2024JULB00012 | Level: Level 1 | Intervention: Case Study Analysis (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T5'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case Study Analysis' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;