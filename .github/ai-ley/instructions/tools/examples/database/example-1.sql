-- Good: Well-formatted query with comments
SELECT
    u.id,
    u.username,
    u.email,
    p.title AS profile_title,
    COUNT(o.id) AS total_orders
FROM users u
    INNER JOIN user_profiles p ON u.id = p.user_id
    LEFT JOIN orders o ON u.id = o.user_id
WHERE
    u.status = 'active'
    AND u.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
GROUP BY
    u.id,
    u.username,
    u.email,
    p.title
HAVING COUNT(o.id) > 0
ORDER BY
    u.created_at DESC,
    u.username ASC
LIMIT 50;