-- Statement 1 from batch processing
-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Book Review (16 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 2 from batch processing
-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Book Review (16 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  2,
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

-- Statement 3 from batch processing
-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Book Review (16 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 4 from batch processing
-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Book Review (16 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Book Review' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  4,
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

-- Statement 5 from batch processing
-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Debate (13 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  0.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  4,
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

-- Statement 6 from batch processing
-- Student: 2024JULB00002 | Level: Level 3 | Intervention: Debate (13 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  1.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 7 from batch processing
-- Student: 2024JULB00003 | Level: Level 3 | Intervention: Debate (13 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 8 from batch processing
-- Student: 2024JULB00004 | Level: Level 3 | Intervention: Debate (13 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 9 from batch processing
-- Student: 2024JULB00005 | Level: Level 3 | Intervention: Debate (13 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  1,
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

-- Statement 10 from batch processing
-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Debate (13 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  4,
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

-- Statement 11 from batch processing
-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Debate (13 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  2.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 12 from batch processing
-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Debate (13 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  2.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  4,
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

-- Statement 13 from batch processing
-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Debate (13 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3.25,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3.5,
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

-- Statement 14 from batch processing
-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Debate (13 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  1.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'L1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Debate' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  4,
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

-- Statement 15 from batch processing
-- Student: 2024JULB00001 | Level: Level 3 | Intervention: GD (5 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  2,
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

-- Statement 16 from batch processing
-- Student: 2024JULB00002 | Level: Level 3 | Intervention: GD (5 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  2,
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

-- Statement 17 from batch processing
-- Student: 2024JULB00003 | Level: Level 3 | Intervention: GD (5 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  3,
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

-- Statement 18 from batch processing
-- Student: 2024JULB00004 | Level: Level 3 | Intervention: GD (5 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  2,
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

-- Statement 19 from batch processing
-- Student: 2024JULB00005 | Level: Level 3 | Intervention: GD (5 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  1,
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

-- Statement 20 from batch processing
-- Student: 2024JULB00006 | Level: Level 3 | Intervention: GD (5 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  3,
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

-- Statement 21 from batch processing
-- Student: 2024JULB00007 | Level: Level 3 | Intervention: GD (5 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  3,
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

-- Statement 22 from batch processing
-- Student: 2024JULB00008 | Level: Level 3 | Intervention: GD (5 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  4,
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

-- Statement 23 from batch processing
-- Student: 2024JULB00009 | Level: Level 3 | Intervention: GD (5 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  3.5,
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

-- Statement 24 from batch processing
-- Student: 2024JULB00012 | Level: Level 3 | Intervention: GD (5 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'GD' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E1'),
  3,
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

-- Statement 25 from batch processing
-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Case study (17 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 26 from batch processing
-- Student: 2024JULB00002 | Level: Level 3 | Intervention: Case study (17 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 27 from batch processing
-- Student: 2024JULB00003 | Level: Level 3 | Intervention: Case study (17 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  4,
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

-- Statement 28 from batch processing
-- Student: 2024JULB00004 | Level: Level 3 | Intervention: Case study (17 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  2,
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

-- Statement 29 from batch processing
-- Student: 2024JULB00005 | Level: Level 3 | Intervention: Case study (17 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 30 from batch processing
-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Case study (17 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 31 from batch processing
-- Student: 2024JULB00007 | Level: Level 3 | Intervention: Case study (17 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00007'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 32 from batch processing
-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Case study (17 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3,
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

-- Statement 33 from batch processing
-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Case study (17 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  3.5,
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

-- Statement 34 from batch processing
-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Case study (17 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C5'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'T1'),
  3,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Case study' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D5'),
  4,
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

-- Statement 35 from batch processing
-- Student: 2024JULB00001 | Level: Level 3 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00001'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  5,
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

-- Statement 36 from batch processing
-- Student: 2024JULB00002 | Level: Level 3 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00002'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
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

-- Statement 37 from batch processing
-- Student: 2024JULB00003 | Level: Level 3 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00003'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
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

-- Statement 38 from batch processing
-- Student: 2024JULB00004 | Level: Level 3 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00004'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
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

-- Statement 39 from batch processing
-- Student: 2024JULB00005 | Level: Level 3 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  1,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  0,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00005'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  0,
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

-- Statement 40 from batch processing
-- Student: 2024JULB00006 | Level: Level 3 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  2,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00006'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  5,
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

-- Statement 41 from batch processing
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
-- Student: 2024JULB00008 | Level: Level 3 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  4.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00008'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4.5,
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

-- Statement 43 from batch processing
-- Student: 2024JULB00009 | Level: Level 3 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
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
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  3.5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00009'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  3,
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

-- Statement 44 from batch processing
-- Student: 2024JULB00012 | Level: Level 3 | Intervention: Capstone (11 scores)
INSERT INTO microcompetency_scores (
  student_id,
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
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A1'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'A3'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C2'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'C3'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'E2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P1'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P2'),
  4,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P3'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'P4'),
  5,
  5,
  '1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
  NOW(),
  '',
  'Submitted',
  '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid
),
(
  (SELECT id FROM students WHERE registration_no = '2024JULB00012'),
  (SELECT id FROM interventions WHERE name = 'Capstone' AND term_id = '4f49e30e-27df-47b8-bede-e0c0c2a988dc'::uuid),
  (SELECT id FROM microcompetencies WHERE name = 'D4'),
  4,
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

