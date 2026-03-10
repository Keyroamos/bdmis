SET session_replication_role = 'replica';

-- schools_foodplan (1 rows)
INSERT INTO "schools_foodplan" ("id", "name", "description", "meal_type", "fee_per_term", "is_active", "created_at", "updated_at") VALUES
  (1, 'Fast Food', '', 'BREAKFAST', 3000, TRUE, '2025-11-21 12:25:16.056103', '2025-11-21 12:25:16.056280')
ON CONFLICT DO NOTHING;

