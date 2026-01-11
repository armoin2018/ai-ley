-- Simple select with optimization
SELECT id, email, username, created_at
FROM users
WHERE is_active = true
ORDER BY created_at DESC
LIMIT 50;

-- Complex query with joins and aggregation
SELECT
    u.username,
    u.email,
    COUNT(p.id) as post_count,
    MAX(p.published_at) as last_post_date
FROM users u
LEFT JOIN posts p ON u.id = p.user_id AND p.published_at IS NOT NULL
WHERE u.is_active = true
GROUP BY u.id, u.username, u.email
HAVING COUNT(p.id) > 0
ORDER BY post_count DESC, last_post_date DESC;

-- JSON/JSONB queries
SELECT username, profile_data->>'location' as location
FROM users
WHERE profile_data->'preferences'->>'theme' = 'dark';

-- Full-text search
SELECT title, content, ts_rank(to_tsvector('english', title || ' ' || content), query) as rank
FROM posts, plainto_tsquery('english', 'search terms') query
WHERE to_tsvector('english', title || ' ' || content) @@ query
ORDER BY rank DESC;