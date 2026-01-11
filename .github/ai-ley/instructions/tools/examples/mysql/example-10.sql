-- Simple select with optimization
SELECT id, email, username, first_name, last_name, created_at
FROM users
WHERE is_active = 1
ORDER BY created_at DESC
LIMIT 50;

-- Complex query with joins and aggregation
SELECT
    u.username,
    u.email,
    COUNT(p.id) as post_count,
    MAX(p.published_at) as last_post_date,
    AVG(p.view_count) as avg_views
FROM users u
LEFT JOIN posts p ON u.id = p.user_id AND p.status = 'published'
WHERE u.is_active = 1
GROUP BY u.id, u.username, u.email
HAVING post_count > 0
ORDER BY post_count DESC, last_post_date DESC;

-- JSON queries (MySQL 5.7+)
SELECT username,
       JSON_EXTRACT(profile_data, '$.theme') as theme,
       JSON_EXTRACT(profile_data, '$.language') as language
FROM users
WHERE JSON_EXTRACT(profile_data, '$.notifications') = true;

-- Full-text search
SELECT title, content,
       MATCH(title, content) AGAINST('search terms' IN NATURAL LANGUAGE MODE) as relevance_score
FROM posts
WHERE MATCH(title, content) AGAINST('search terms' IN NATURAL LANGUAGE MODE)
  AND status = 'published'
ORDER BY relevance_score DESC;

-- Common Table Expression (MySQL 8.0+)
WITH RECURSIVE comment_tree AS (
    -- Base case: top-level comments
    SELECT id, post_id, user_id, parent_id, content, created_at, 0 as level
    FROM comments
    WHERE parent_id IS NULL AND post_id = 1

    UNION ALL

    -- Recursive case: child comments
    SELECT c.id, c.post_id, c.user_id, c.parent_id, c.content, c.created_at, ct.level + 1
    FROM comments c
    INNER JOIN comment_tree ct ON c.parent_id = ct.id
    WHERE ct.level < 5  -- Limit recursion depth
)
SELECT * FROM comment_tree ORDER BY level, created_at;