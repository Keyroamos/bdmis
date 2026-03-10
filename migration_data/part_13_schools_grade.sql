SET session_replication_role = 'replica';

-- schools_grade (15 rows)
INSERT INTO "schools_grade" ("id", "name", "description", "is_active", "class_teacher_id", "term1_fees", "term2_fees", "term3_fees") VALUES
  (1, 'PG', 'CBC Playgroup', TRUE, 35, 5500, 5500, 5000),
  (2, 'PP1', 'CBC PP1', TRUE, 47, 6500, 6500, 6000),
  (3, 'PP2', 'CBC PP2', TRUE, 44, 1000, 6500, 6000),
  (4, 'G1', 'CBC Grade 1', TRUE, 46, 5000, 3000, 2599),
  (5, 'G2', 'CBC Grade 2', TRUE, 43, 7000, 7000, 6500),
  (6, 'G3', 'CBC Grade 3', TRUE, 38, 7000, 7000, 6500),
  (7, 'G4', 'CBC Grade 4', TRUE, 36, 8000, 8000, 7500),
  (8, 'G5', 'CBC Grade 5', TRUE, NULL, 8000, 8000, 7500),
  (9, 'G6', 'CBC Grade 6', TRUE, NULL, 0, 0, 0),
  (10, 'G7', 'CBC Grade 7', TRUE, NULL, 7500, 6500, 6500),
  (11, 'G8', 'CBC Grade 8', TRUE, NULL, 0, 0, 0),
  (12, 'G9', 'CBC Grade 9', TRUE, NULL, 0, 0, 0),
  (13, 'G10', 'CBC Grade 10', TRUE, NULL, 0, 0, 0),
  (14, 'G11', 'CBC Grade 11', TRUE, NULL, 0, 0, 0),
  (15, 'G12', 'CBC Grade 12', TRUE, NULL, 0, 0, 0)
ON CONFLICT DO NOTHING;

