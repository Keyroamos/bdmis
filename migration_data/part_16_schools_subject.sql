SET session_replication_role = 'replica';

-- schools_subject (12 rows)
INSERT INTO "schools_subject" ("id", "name", "description", "code") VALUES
  (1, 'Mathematics', 'CBC Mathematics subject', 'MATH'),
  (2, 'English', 'CBC English subject', 'ENG'),
  (3, 'Kiswahili', 'CBC Kiswahili subject', 'KIS'),
  (4, 'Science & Technology', 'CBC Science & Technology subject', 'SCI'),
  (5, 'Social Studies', 'CBC Social Studies subject', 'SST'),
  (6, 'Christian Religious Education', 'CBC Christian Religious Education subject', 'CRE'),
  (7, 'Islamic Religious Education', 'CBC Islamic Religious Education subject', 'IRE'),
  (8, 'Hindu Religious Education', 'CBC Hindu Religious Education subject', 'HRE'),
  (9, 'Physical & Health Education', 'CBC Physical & Health Education subject', 'PHE'),
  (10, 'Art & Craft', 'CBC Art & Craft subject', 'ART'),
  (11, 'Music', 'CBC Music subject', 'MUS'),
  (12, 'Agriculture', 'CBC Agriculture subject', 'AGR')
ON CONFLICT DO NOTHING;

