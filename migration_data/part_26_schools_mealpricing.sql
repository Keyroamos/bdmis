SET session_replication_role = 'replica';

-- schools_mealpricing (3 rows)
INSERT INTO "schools_mealpricing" ("id", "price_per_day", "is_active", "created_at", "updated_at", "location", "meal_type") VALUES
  (1, 20, TRUE, '2025-11-25 09:36:24.608855', '2025-12-02 13:42:54.056836', 'MAIN', 'TEA_BREAK'),
  (2, 50, TRUE, '2025-11-25 09:36:24.620816', '2025-12-02 13:42:54.071327', 'MAIN', 'LUNCH'),
  (3, 10, TRUE, '2025-11-25 09:36:24.633205', '2025-12-02 13:42:54.078958', 'MAIN', 'FRUITS')
ON CONFLICT DO NOTHING;

