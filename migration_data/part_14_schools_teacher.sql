SET session_replication_role = 'replica';

-- schools_teacher (13 rows)
INSERT INTO "schools_teacher" ("employee_ptr_id", "tsc_number", "years_of_experience", "qualifications", "certificate", "is_class_teacher", "grade_id", "user_id") VALUES
  (35, NULL, 3, 'CERT', '', TRUE, 1, 1327),
  (36, '982734', 7, 'CERT', '', TRUE, 7, 1328),
  (37, '979047', 1, 'DIP', '', TRUE, 5, 1329),
  (38, NULL, 5, 'CERT', '', TRUE, 6, 1330),
  (39, NULL, 20, 'CERT', '', TRUE, 3, 1331),
  (40, NULL, 2, 'DEG', '', TRUE, 3, 1332),
  (41, NULL, 0, 'DEG', '', TRUE, 4, 1333),
  (42, NULL, 4, 'CERT', '', TRUE, 2, 1334),
  (43, NULL, 5, 'CERT', '', TRUE, 5, 1335),
  (44, '810334', 8, 'DIP', '', TRUE, 3, 1336),
  (45, '1064982', 3, 'DEG', '', TRUE, 4, 1337),
  (46, '864586', 7, 'DIP', '', TRUE, 4, 1338),
  (47, NULL, 8, 'CERT', '', TRUE, 2, 1339)
ON CONFLICT DO NOTHING;

