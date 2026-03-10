SET session_replication_role = 'replica';

-- finance_feecategory (4 rows)
INSERT INTO "finance_feecategory" ("id", "name", "description") VALUES
  (1, 'Tuition', NULL),
  (2, 'Transport', NULL),
  (3, 'Lunch', NULL),
  (4, 'Activities', NULL)
ON CONFLICT DO NOTHING;

