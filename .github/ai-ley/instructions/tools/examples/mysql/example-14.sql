-- Use EXPLAIN to understand query execution
EXPLAIN FORMAT=JSON
SELECT p.*, u.username
FROM posts p
JOIN users u ON p.user_id = u.id
WHERE p.status = 'published'
AND p.created_at > DATE_SUB(NOW(), INTERVAL 30 DAY)
ORDER BY p.created_at DESC
LIMIT 20;

-- Optimize pagination with cursor-based approach
SELECT * FROM posts
WHERE status = 'published'
  AND id > 12345  -- cursor from previous page
ORDER BY id
LIMIT 20;

-- Avoid SELECT * in production queries
SELECT id, title, created_at, user_id
FROM posts
WHERE status = 'published'
ORDER BY created_at DESC
LIMIT 20;

-- Use EXISTS instead of IN for better performance
SELECT * FROM users u
WHERE EXISTS (
    SELECT 1 FROM posts p
    WHERE p.user_id = u.id
    AND p.status = 'published'
    AND p.created_at > DATE_SUB(NOW(), INTERVAL 30 DAY)
);