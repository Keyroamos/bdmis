SET session_replication_role = 'replica';

-- schools_syncstatus (1 rows)
INSERT INTO "schools_syncstatus" ("id", "is_online", "last_sync_attempt", "last_successful_sync", "pending_count", "failed_count", "auto_sync_enabled", "sync_interval_minutes", "max_retry_attempts", "sync_on_startup") VALUES
  (1, TRUE, NULL, NULL, 0, 0, TRUE, 5, 3, TRUE)
ON CONFLICT DO NOTHING;

