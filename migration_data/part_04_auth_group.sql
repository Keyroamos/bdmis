SET session_replication_role = 'replica';

-- auth_group (3 rows)
INSERT INTO "auth_group" ("id", "name") VALUES
  (1, 'Students'),
  (2, 'Teachers'),
  (3, 'Admin Staff')
ON CONFLICT DO NOTHING;

