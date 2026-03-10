SET session_replication_role = 'replica';

-- schools_smsmessage (16 rows)
INSERT INTO "schools_smsmessage" ("id", "message", "recipient_type", "status", "sent_at", "response_data", "created_at", "sent_by_id", "specific_grade_id", "specific_student_id", "location", "recipients_count") VALUES
  (1, 'vdbgdrgf devr', 'ALL', 'PENDING', NULL, NULL, '2025-01-30 21:09:54.468243', 1, NULL, NULL, NULL, 0),
  (2, 'vdbgdrgf devr', 'ALL', 'SENT', '2025-01-30 21:11:11.473605', '{"status": "success", "message": "SMS would be sent to 1 recipients", "recipients": ["+254713428517"]}', '2025-01-30 21:11:11.462618', 1, NULL, NULL, NULL, 0),
  (3, 'hgtfcrv', 'GRADE', 'SENT', '2025-01-30 21:13:16.820061', '{"status": "success", "message": "SMS would be sent to 1 recipients", "recipients": ["+254720990929"]}', '2025-01-30 21:13:16.809409', 1, 3, NULL, NULL, 0),
  (4, 'jghhgv', 'GRADE', 'PENDING', NULL, NULL, '2025-01-30 21:22:36.605216', 1, 3, NULL, NULL, 0),
  (5, 'jghhgv', 'GRADE', 'PENDING', NULL, NULL, '2025-01-30 21:23:15.079288', 1, 3, NULL, NULL, 0),
  (6, 'jghhgv', 'GRADE', 'FAILED', NULL, '"The supplied authentication is invalid"', '2025-01-30 21:24:48.956613', 1, 3, NULL, NULL, 0),
  (7, 'hugyfghuj', 'GRADE', 'FAILED', NULL, '"Invalid API credentials. Please check your Africa''s Talking settings."', '2025-01-30 21:25:53.437126', 1, 3, NULL, NULL, 0),
  (8, 'edededed', 'ALL', 'FAILED', NULL, '"Invalid API credentials. Please check your Africa''s Talking settings."', '2025-02-02 11:41:37.299721', 1, NULL, NULL, NULL, 0),
  (9, 'dc', 'ALL', 'FAILED', NULL, '"Invalid API credentials. Please check your Africa''s Talking settings."', '2025-02-02 11:43:19.407344', 1, NULL, NULL, NULL, 0),
  (10, 'rggrg', 'ALL', 'FAILED', NULL, '"Invalid API credentials. Please check your Africa''s Talking settings."', '2025-02-02 11:49:44.244574', 1, NULL, NULL, NULL, 0),
  (11, 'Hello, i am just testing', 'INDIVIDUAL', 'PENDING', NULL, NULL, '2025-11-27 09:15:22.186553', 226, NULL, NULL, NULL, 0),
  (12, 'Hello, i am just testing', 'INDIVIDUAL', 'FAILED', NULL, '"Invalid API credentials. Please check your Africa''s Talking settings."', '2025-11-27 09:19:38.301614', 226, NULL, NULL, NULL, 1),
  (13, 'Hello, i am just testing', 'INDIVIDUAL', 'FAILED', NULL, '"Invalid API credentials: The supplied authentication is invalid. Please verify your username ''BDMIS'' and API key in settings.py match your Africa''s Talking dashboard."', '2025-11-27 09:31:10.683291', 226, NULL, NULL, NULL, 1),
  (14, 'hello jus', 'INDIVIDUAL', 'FAILED', NULL, '"Failed to send SMS: ''Settings'' object has no attribute ''SMS_SENDER_ID''"', '2025-11-27 09:32:24.821743', 226, NULL, NULL, NULL, 1),
  (15, 'Hello, testing hh', 'INDIVIDUAL', 'FAILED', NULL, '"Invalid API credentials: The supplied authentication is invalid. Please verify your username ''BDMIS'' and API key in settings.py match your Africa''s Talking dashboard."', '2025-11-27 09:37:20.283887', 226, NULL, NULL, NULL, 1),
  (16, 'testing', 'INDIVIDUAL', 'FAILED', NULL, '"Invalid API credentials: The supplied authentication is invalid. Please verify your username ''BDMIS'' and API key in settings.py match your Africa''s Talking dashboard."', '2025-11-27 09:54:30.656388', 226, NULL, NULL, NULL, 1)
ON CONFLICT DO NOTHING;

