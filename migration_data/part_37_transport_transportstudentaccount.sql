SET session_replication_role = 'replica';

-- transport_transportstudentaccount (1 rows)
INSERT INTO "transport_transportstudentaccount" ("id", "balance", "active", "total_billed", "total_paid", "updated_at", "student_id") VALUES
  (5, -2000, TRUE, 0, 2000, '2026-01-22 07:30:34.719584', 798)
ON CONFLICT DO NOTHING;

-- ============================================================
