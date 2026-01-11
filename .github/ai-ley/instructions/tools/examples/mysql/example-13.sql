-- Primary key (automatically created)
-- Already defined in table creation

-- Composite index for common query patterns
CREATE INDEX idx_user_status_date ON posts(user_id, status, created_at);

-- Partial index (functional index in MySQL 8.0+)
CREATE INDEX idx_active_users ON users((CASE WHEN is_active = 1 THEN id END));

-- Covering index to avoid key lookups
CREATE INDEX idx_post_list_covering ON posts(status, published_at, id, title, user_id);

-- Analyze index usage
SHOW INDEX FROM posts;
EXPLAIN SELECT * FROM posts WHERE user_id = 1 AND status = 'published';