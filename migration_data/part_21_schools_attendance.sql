SET session_replication_role = 'replica';

-- schools_attendance (2 rows)
INSERT INTO "schools_attendance" ("id", "date", "status", "remarks", "term", "created_at", "updated_at", "recorded_by_id", "student_id") VALUES
  (65, '2026-01-21', 'PRESENT', '', '1', '2026-01-21 20:20:30.800405', '2026-01-21 20:28:13.429555', 226, 1314),
  (66, '2026-01-20', 'PRESENT', '', '1', '2026-01-21 20:23:18.142752', '2026-01-21 20:23:18.142782', 226, 1314)
ON CONFLICT DO NOTHING;

