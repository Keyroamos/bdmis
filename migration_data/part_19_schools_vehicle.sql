SET session_replication_role = 'replica';

-- schools_vehicle (1 rows)
INSERT INTO "schools_vehicle" ("id", "vehicle_number", "vehicle_type", "make", "model", "year", "capacity", "status", "insurance_expiry", "registration_expiry", "notes", "created_at", "updated_at", "driver_id", "location") VALUES
  (1, 'KDK', 'BUS', 'SCANIA', 'R-T', 2021, 33, 'ACTIVE', '2026-06-10', '2025-11-27', '', '2025-11-21 05:35:40.881403', '2025-11-21 05:35:40.881449', 13, 'MAIN')
ON CONFLICT DO NOTHING;

