SET session_replication_role = 'replica';

-- food_mealitem (7 rows)
INSERT INTO "food_mealitem" ("id", "name", "description", "cost", "billing_cycle", "active", "created_at", "per_serving_cost") VALUES
  (1, 'Termly Lunch', 'Full lunch for the whole term', 15000, 'TERMLY', FALSE, '2026-01-13 00:33:22.433804', 0),
  (2, 'Daily Tea Break', 'Morning tea and snack', 50, 'DAILY', TRUE, '2026-01-13 00:33:22.445273', 0),
  (3, 'Termly Fruits', 'Fruit serving daily for the term', 3000, 'TERMLY', TRUE, '2026-01-13 00:33:22.458448', 0),
  (4, 'Monthly Special Diet', 'Special diet accommodations', 6000, 'MONTHLY', TRUE, '2026-01-13 00:33:22.473251', 0),
  (5, 'Tea', '', 20, 'ONE_OFF', TRUE, '2026-01-13 00:47:32.054056', 0),
  (6, 'Tea', '', 20, 'ONE_OFF', FALSE, '2026-01-13 00:47:56.778757', 0),
  (7, 'Tea', '', 20, 'ONE_OFF', FALSE, '2026-01-13 00:49:08.551387', 0)
ON CONFLICT DO NOTHING;

