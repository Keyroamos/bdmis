SET session_replication_role = 'replica';

-- schools_department (6 rows)
INSERT INTO "schools_department" ("id", "name", "description", "created_at", "updated_at", "is_active", "head_id", "branch_id") VALUES
  (1, 'Games and Sports', '', '2025-07-15 14:27:17.246200', '2025-07-15 14:27:17.246229', TRUE, NULL, NULL),
  (2, 'Debate', '', '2025-07-15 14:27:47.749383', '2025-07-15 14:27:47.749412', TRUE, NULL, NULL),
  (3, 'Guidance and Councelling', '', '2025-07-15 14:28:30.674373', '2025-07-15 14:28:30.674403', TRUE, NULL, NULL),
  (4, 'Academics Upper', '', '2025-07-15 14:28:57.835533', '2025-07-15 14:28:57.835566', TRUE, NULL, NULL),
  (5, 'Academics Lower', '', '2025-07-15 14:30:10.515919', '2025-07-15 14:30:10.515949', TRUE, NULL, NULL),
  (6, 'Chapel', '', '2025-07-15 14:33:42.916606', '2025-07-15 14:33:42.916634', TRUE, NULL, NULL)
ON CONFLICT DO NOTHING;

