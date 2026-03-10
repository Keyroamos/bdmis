SET session_replication_role = 'replica';

-- food_foodstudentaccount (2 rows)
INSERT INTO "food_foodstudentaccount" ("id", "balance", "active", "total_billed", "total_paid", "updated_at", "student_id") VALUES
  (9, 0, TRUE, 0, 0, '2026-01-14 06:25:23.086779', 818),
  (10, -5000, TRUE, 0, 5000, '2026-01-22 07:48:26.341034', 798)
ON CONFLICT DO NOTHING;

