INSERT INTO microcompetency_scores (
student_id,
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
(SELECT id FROM interventions WHERE name = 'Fearless (Level 0)' AND term_id = 'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8'::uuid),
(SELECT id FROM microcompetencies WHERE name = 'D1'),
0,
5,
'1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
NOW(),
'',
'Submitted',
'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8'::uuid
),
(
(SELECT id FROM students WHERE registration_no = '2024JULB00001'),
(SELECT id FROM interventions WHERE name = 'Fearless (Level 0)' AND term_id = 'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8'::uuid),
(SELECT id FROM microcompetencies WHERE name = 'D2'),
0,
5,
'1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
NOW(),
'',
'Submitted',
'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8'::uuid
),
(
(SELECT id FROM students WHERE registration_no = '2024JULB00001'),
(SELECT id FROM interventions WHERE name = 'Fearless (Level 0)' AND term_id = 'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8'::uuid),
(SELECT id FROM microcompetencies WHERE name = 'D3'),
0,
5,
'1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
NOW(),
'',
'Submitted',
'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8'::uuid
),
(
(SELECT id FROM students WHERE registration_no = '2024JULB00001'),
(SELECT id FROM interventions WHERE name = 'Fearless (Level 0)' AND term_id = 'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8'::uuid),
(SELECT id FROM microcompetencies WHERE name = 'D4'),
2,
5,
'1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
NOW(),
'',
'Submitted',
'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8'::uuid
),
(
(SELECT id FROM students WHERE registration_no = '2024JULB00001'),
(SELECT id FROM interventions WHERE name = 'Fearless (Level 0)' AND term_id = 'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8'::uuid),
(SELECT id FROM microcompetencies WHERE name = 'D5'),
3,
5,
'1a1aa901-d33c-4cf5-adae-c205677c6bc3'::uuid,
NOW(),
'',
'Submitted',
'a83328b8-fad6-4e5b-b3d3-f0e6e11967d8'::uuid
)
ON CONFLICT (student_id, intervention_id, microcompetency_id)
DO UPDATE SET
obtained_score = EXCLUDED.obtained_score,
max_score = EXCLUDED.max_score,
scored_at = EXCLUDED.scored_at,
status = EXCLUDED.status,
term_id = EXCLUDED.term_id;