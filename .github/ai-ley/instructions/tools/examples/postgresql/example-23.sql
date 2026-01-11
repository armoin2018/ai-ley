-- Use EXPLAIN ANALYZE to understand query execution
EXPLAIN (ANALYZE, BUFFERS)
SELECT * FROM posts p
JOIN users u ON p.user_id = u.id
WHERE u.is_active = true
AND p.published_at > NOW() - INTERVAL '30 days';

-- Optimize with proper WHERE clause ordering
SELECT * FROM posts
WHERE published_at IS NOT NULL  -- Most selective first
AND user_id = 1                 -- Then foreign key
AND title ILIKE '%search%'      -- Least selective last
ORDER BY published_at DESC
LIMIT 20;

-- Use EXISTS instead of IN for better performance
SELECT * FROM users u
WHERE EXISTS (
    SELECT 1 FROM posts p
    WHERE p.user_id = u.id
    AND p.published_at > NOW() - INTERVAL '30 days'
);