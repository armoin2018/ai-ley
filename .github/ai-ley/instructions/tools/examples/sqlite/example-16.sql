-- Problem: Missing indexes for common queries
-- Solution: Create appropriate indexes

-- Before: Slow full table scan
SELECT * FROM tasks WHERE user_id = 123 AND status = 'pending';

-- Create composite index
CREATE INDEX idx_tasks_user_status ON tasks(user_id, status);

-- After: Fast index lookup
EXPLAIN QUERY PLAN SELECT * FROM tasks WHERE user_id = 123 AND status = 'pending';
-- Uses: SEARCH tasks USING INDEX idx_tasks_user_status (user_id=? AND status=?)

-- Problem: Inefficient date queries
-- Solution: Use proper date indexing and functions

-- Inefficient date range query
SELECT * FROM events WHERE date(created_at) = '2023-12-01';

-- Better: Use datetime comparison with index
CREATE INDEX idx_events_created ON events(created_at);
SELECT * FROM events
WHERE created_at >= '2023-12-01 00:00:00'
AND created_at < '2023-12-02 00:00:00';

-- Problem: Large result sets consuming memory
-- Solution: Use LIMIT and pagination

-- Memory-intensive query
SELECT * FROM large_table ORDER BY created_at DESC;

-- Memory-efficient pagination
SELECT * FROM large_table
ORDER BY created_at DESC
LIMIT 50 OFFSET 0;

-- Better: Cursor-based pagination for large datasets
SELECT * FROM large_table
WHERE created_at < '2023-12-01 10:00:00'
ORDER BY created_at DESC
LIMIT 50;