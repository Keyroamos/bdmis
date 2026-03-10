SET session_replication_role = 'replica';

-- config_schoolconfig (1 rows)
INSERT INTO "config_schoolconfig" ("id", "school_name", "school_code", "school_email", "school_phone", "admission_number_format", "admission_counter", "current_term", "current_year", "default_currency", "school_address", "school_logo") VALUES
  (1, 'Bishop Dr. Mando International School', '', '', '', '70000', 1386511, 'TERM_1', 2024, 'KES', '', 'school_logos/logom.jpg')
ON CONFLICT DO NOTHING;

