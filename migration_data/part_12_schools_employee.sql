SET session_replication_role = 'replica';

-- schools_employee (14 rows)
INSERT INTO "schools_employee" ("id", "first_name", "last_name", "email", "phone", "national_id", "position", "date_of_birth", "date_joined", "address", "profile_picture", "basic_salary", "status", "gender", "religion", "marital_status", "nationality", "department_id", "location", "branch_id") VALUES
  (13, 'Pauline', 'Onyango', 'paulinefaith988@gmail.com', '0111844749', '39093654', 'ADMIN', '2002-01-11', '2025-02-11', 'PO BOX 6675-001000', 'employee_profiles/logo.jpg', 21000, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (35, 'BRIDGET', 'NYOKABI', 'virbridgetnyokabi@bdmis.co.ke', '0797965687', '39300841', 'TEACHER', '2000-12-07', '2025-12-23', '3101 Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (36, 'Dada', 'Rita', 'dadarita@bdmis.co.ke', '0701685360', '30700602', 'PRINCIPAL', '1992-12-06', '2025-12-23', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (37, 'Elizabeth', 'Barasa', 'elizabethbarasa@bdmis.co.ke', '0740436588', '37018780', 'TEACHER', '1999-12-16', '2025-12-23', '3101- Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (38, 'Esther', 'Waithera', 'estherwaithera@bdmis.co.ke', '0713069548', '29825106', 'TEACHER', '1993-12-05', '2024-01-19', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (39, 'FAITH', 'GICHERU', 'faithgicheru@bdmis.co.ke', '0722691981', '14714028', 'TEACHER', '1977-05-28', '2025-12-23', '3101 THIKA', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (40, 'Jackline', 'Nzisa', 'jacklinenzisa@bdmis.co.ke', '0708430101', '41407148', 'TEACHER', '2002-06-11', '2023-12-19', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (41, 'LILIAN', 'WAITHERA', 'lilianwaithira@bdmis.co.ke', '0723807730', '24649881', 'PRINCIPAL', '1985-01-01', '2025-12-19', '3101 THIKA', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (42, 'Nelly', 'Wanjiru', 'nellywanjiru@bdmis.co.ke', '0759457106', '37925422', 'TEACHER', '2000-10-31', '2022-12-19', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (43, 'ROSE', 'NJERI', 'rosenjeri@bdmis.co.ke', '0703331080', '33889045', 'TEACHER', '1995-10-12', '2025-12-19', '3101 THIKA', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (44, 'Salome', 'Ogai', 'salomeogai@bdmis.co.ke', '0706678821', '33206951', 'TEACHER', '1996-02-05', '2025-12-23', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'ANNEX', NULL),
  (45, 'Salome', 'Shivona', 'salomeshivona@bdmis.co.ke', '0792649368', '33771943', 'TEACHER', '1997-02-23', '2023-04-19', '3101-Thika', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'SINGLE', 'Kenyan', NULL, 'MAIN', NULL),
  (46, 'TERYY', 'TERYY', 'teryynyambura@bdmis.co.ke', '0703528458', '29294250', 'DEPUTY', '1990-11-14', '2025-12-19', '3101 THIKA', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'MAIN', NULL),
  (47, 'VIRGINIA', 'WANJA', 'virginiawanja@bdmis.co.ke', '0705592781', '33769634', 'TEACHER', '1996-12-23', '2025-12-23', '3101 THIKA', '', 0, 'ACTIVE', 'F', 'CHRISTIAN', 'MARRIED', 'Kenyan', NULL, 'ANNEX', NULL)
ON CONFLICT DO NOTHING;

