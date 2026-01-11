-- Add missing indexes based on query patterns
-- Example: Add composite index for common WHERE clauses
CREATE INDEX idx_tasks_status_assignee_due
ON tasks (status, assignee_id, due_date);

-- Optimize queries to use existing indexes
-- Before: Full table scan
SELECT * FROM tasks WHERE title LIKE '%urgent%';

-- After: Use full-text index
ALTER TABLE tasks ADD FULLTEXT(title, description);
SELECT * FROM tasks WHERE MATCH(title, description) AGAINST('urgent' IN BOOLEAN MODE);