SET session_replication_role = 'replica';

-- transport_transportdriver (1 rows)
INSERT INTO "transport_transportdriver" ("id", "first_name", "last_name", "license_number", "status", "joined_at", "vehicle_id", "user_id", "phone_number") VALUES
  (1, 'Saidah', 'Hamisi', 'T68DJ34', 'ACTIVE', '2026-01-13', NULL, 241, '0749738248')
ON CONFLICT DO NOTHING;

