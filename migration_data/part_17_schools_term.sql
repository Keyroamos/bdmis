SET session_replication_role = 'replica';

-- schools_term (1 rows)
INSERT INTO "schools_term" ("id", "number", "year", "end_date", "is_current", "created_at", "updated_at", "start_date") VALUES
  (1, 1, 2025, '2025-04-30', TRUE, '2025-02-05 09:35:27.532406', '2025-02-05 09:35:27.532421', '2025-01-01')
ON CONFLICT DO NOTHING;

