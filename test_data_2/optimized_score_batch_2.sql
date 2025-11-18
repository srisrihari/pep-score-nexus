-- Student: 2024JULB00001 | Level: Level 1 | Intervention: Book Review Presentation (15 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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

-- Student: 2024JULB00002 | Level: Level 1 | Intervention: Book Review Presentation (15 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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

-- Student: 2024JULB00003 | Level: Level 1 | Intervention: Book Review Presentation (15 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  1,
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

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Book Review Presentation (15 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  1,
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

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Book Review Presentation (15 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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

-- Student: 2024JULB00006 | Level: Level 1 | Intervention: Book Review Presentation (15 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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

-- Student: 2024JULB00007 | Level: Level 1 | Intervention: Book Review Presentation (15 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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

-- Student: 2024JULB00008 | Level: Level 1 | Intervention: Book Review Presentation (15 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Student: 2024JULB00009 | Level: Level 1 | Intervention: Book Review Presentation (15 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Student: 2024JULB00012 | Level: Level 1 | Intervention: Book Review Presentation (15 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review Presentation' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Student: 2024JULB00001 | Level: Level 1 | Intervention: Interpersonal Role Play (4 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N2'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N3'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
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

-- Student: 2024JULB00002 | Level: Level 1 | Intervention: Interpersonal Role Play (4 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
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

-- Student: 2024JULB00003 | Level: Level 1 | Intervention: Interpersonal Role Play (4 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N2'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N3'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
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

-- Student: 2024JULB00004 | Level: Level 1 | Intervention: Interpersonal Role Play (4 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
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

-- Student: 2024JULB00005 | Level: Level 1 | Intervention: Interpersonal Role Play (4 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N2'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N3'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
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

-- Student: 2024JULB00006 | Level: Level 1 | Intervention: Interpersonal Role Play (4 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N3'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  1,
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

-- Student: 2024JULB00007 | Level: Level 1 | Intervention: Interpersonal Role Play (4 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N2'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N3'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  2,
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

-- Student: 2024JULB00008 | Level: Level 1 | Intervention: Interpersonal Role Play (4 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N2'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N3'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
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

-- Student: 2024JULB00009 | Level: Level 1 | Intervention: Interpersonal Role Play (4 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N2'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N3'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
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

-- Student: 2024JULB00012 | Level: Level 1 | Intervention: Interpersonal Role Play (4 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N1'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N2'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'N3'),
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
  (SELECT id FROM interventions WHERE name = 'Interpersonal Role Play' AND term_id = 'ea9a7617-a53e-421f-bf8b-13a0fb908b55'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
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