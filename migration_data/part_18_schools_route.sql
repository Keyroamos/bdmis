SET session_replication_role = 'replica';

-- schools_route (3 rows)
INSERT INTO "schools_route" ("id", "name", "description", "start_location", "end_location", "distance", "estimated_time", "fee_per_term", "is_active", "created_at", "updated_at", "end_latitude", "end_longitude", "start_latitude", "start_longitude", "school_latitude", "school_longitude", "location") VALUES
  (1, 'Kisii Estate', '', 'Kamenu', 'Kisii Estate', 30, '40', 3500, TRUE, '2025-11-21 05:40:39.834163', '2025-11-21 05:40:39.834210', NULL, NULL, NULL, NULL, NULL, NULL, 'MAIN'),
  (2, 'Kisii Estatet', '', 'Bishop Dr. Mando International School Kamenu,BAT Kiganjo Road, Off Garissa Rd, Thika', 'Ananas Mall Thika', 50, '40', 6000, TRUE, '2025-11-26 07:29:42.493710', '2025-11-26 07:40:42.272186', NULL, NULL, NULL, NULL, NULL, NULL, 'MAIN'),
  (3, 'Kiganjo', '', 'Bishop Dr. Mando International School Kamenu,BAT Kiganjo Road, Off Garissa Rd, Thika', 'kiganjo', 30, '40', 3400, TRUE, '2025-12-02 13:38:03.988902', '2025-12-02 13:38:03.988925', NULL, NULL, NULL, NULL, NULL, NULL, 'MAIN')
ON CONFLICT DO NOTHING;

