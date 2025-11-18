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