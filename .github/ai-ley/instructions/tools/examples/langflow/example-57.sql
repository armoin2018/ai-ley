-- Check database schema
SELECT table_name, column_name, data_type
FROM information_schema.columns
WHERE table_schema = 'langflow';

-- Verify indexes
SELECT indexname, indexdef
FROM pg_indexes
WHERE schemaname = 'langflow';

-- Check for missing migrations
SELECT version, dirty
FROM schema_migrations
ORDER BY version DESC
LIMIT 5;