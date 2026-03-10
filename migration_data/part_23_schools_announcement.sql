SET session_replication_role = 'replica';

-- schools_announcement (1 rows)
INSERT INTO "schools_announcement" ("id", "title", "content", "priority", "created_at", "updated_at", "expires_at", "is_active", "author_id", "specific_grade_id", "recipient_type") VALUES
  (22, 'Closing', 'Closing', 'HIGH', '2025-07-31 08:41:58.891915', '2025-07-31 08:41:58.891943', '2025-08-01 12:40:00', TRUE, 1, NULL, 'STUDENTS')
ON CONFLICT DO NOTHING;

