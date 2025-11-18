-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Business Proposal Report (9 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Business Proposal Report' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
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
  (SELECT id FROM interventions WHERE name = 'Business Proposal Report' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
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
  (SELECT id FROM interventions WHERE name = 'Business Proposal Report' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
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
  (SELECT id FROM interventions WHERE name = 'Business Proposal Report' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Business Proposal Report' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
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
  (SELECT id FROM interventions WHERE name = 'Business Proposal Report' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Business Proposal Report' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Business Proposal Report' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D3'),
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
  (SELECT id FROM interventions WHERE name = 'Business Proposal Report' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
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