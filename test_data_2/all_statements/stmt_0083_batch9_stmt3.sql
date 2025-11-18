-- Student: 2024JULB00003 | Level: Level 1 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  4,
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