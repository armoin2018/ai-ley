-- Check current connections
SELECT COUNT(*) as current_connections,
       setting::int as max_connections,
       COUNT(*) * 100.0 / setting::int as connection_usage_percent
FROM pg_stat_activity, pg_settings
WHERE name = 'max_connections';

-- Find long-running connections
SELECT pid, usename, datname, state,
       now() - state_change as idle_time,
       now() - query_start as query_duration
FROM pg_stat_activity
WHERE state != 'idle'
ORDER BY query_duration DESC NULLS LAST;