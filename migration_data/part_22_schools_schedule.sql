SET session_replication_role = 'replica';

-- schools_schedule (1 rows)
INSERT INTO "schools_schedule" ("id", "grade_id", "subject_id", "teacher_id", "day", "end_time", "term", "start_time") VALUES
  (11, 1, 6, 35, 'MONDAY', '09:00:00', NULL, '08:00:00')
ON CONFLICT DO NOTHING;

