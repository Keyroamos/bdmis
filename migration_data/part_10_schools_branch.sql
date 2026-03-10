SET session_replication_role = 'replica';

-- schools_branch (1 rows)
INSERT INTO "schools_branch" ("id", "name", "address", "contact_phone", "is_active", "slug", "created_at", "updated_at") VALUES
  (2, 'Annex', '', '', TRUE, 'annex', '2026-01-14 05:34:41.574987', '2026-01-14 05:34:41.575038')
ON CONFLICT DO NOTHING;

