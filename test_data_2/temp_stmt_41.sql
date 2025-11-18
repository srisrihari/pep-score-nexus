-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  2.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
  obtained_score = EXCLUDED.obtained_score,
  max_score = EXCLUDED.max_score,
  scored_at = EXCLUDED.scored_at,
  status = EXCLUDED.status,
  term_id = EXCLUDED.term_id;

-- Statement 42 from batch processing