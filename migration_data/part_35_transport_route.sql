SET session_replication_role = 'replica';

-- transport_route (5 rows)
INSERT INTO "transport_route" ("id", "name", "description", "cost_per_term", "cost_per_month", "pickup_points", "active", "created_at", "map_embed_code") VALUES
  (1, 'Route A - CBD', 'Covers Central Business District and surrounding areas', 15000, 5500, 'Kencom, Railways, GPO, Nation Centre, Hilton', FALSE, '2026-01-13 01:34:58.055731', '<iframe src="https://www.google.com/maps/embed?pb=!1m18!1m12!1m3!1d4103.408903701481!2d37.10383577509383!3d-1.059059498930755!2m3!1f0!2f0!3f0!3m2!1i1024!2i768!4f13.1!3m3!1m2!1s0x182f4f792ce44fcd%3A0xc9ef65bdca51508f!2sBishop%20Dr.%20Mando%20International%20School!5e1!3m2!1sen!2ske!4v1768297292204!5m2!1sen!2ske" width="600" height="450" style="border:0;" allowfullscreen="" loading="lazy" referrerpolicy="no-referrer-when-downgrade"></iframe>'),
  (2, 'Route B - Westlands', 'Westlands, Parklands, and Highridge areas', 18000, 6500, 'Sarit Centre, ABC Place, Westgate Mall, Parklands Mosque', FALSE, '2026-01-13 01:34:58.068099', NULL),
  (3, 'Route C - Eastlands', 'Eastlands estates including Umoja, Donholm, Buruburu', 12000, 4500, 'Buruburu Phase 5, Umoja 1, Donholm Phase 8, Makadara', FALSE, '2026-01-13 01:34:58.079780', NULL),
  (4, 'Route D - South B/C', 'South B, South C, Langata Road areas', 16000, 6000, 'South C Shopping Centre, Bellevue, Mugoya, Nairobi West', FALSE, '2026-01-13 01:34:58.089883', NULL),
  (5, 'Route E - Ngong Road', 'Ngong Road, Dagoretti, Karen areas', 20000, 7500, 'Adams Arcade, Prestige Plaza, Karen Shopping Centre, Junction Mall', FALSE, '2026-01-13 01:34:58.102145', NULL)
ON CONFLICT DO NOTHING;

