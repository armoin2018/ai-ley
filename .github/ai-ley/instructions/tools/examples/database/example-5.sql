-- Better performance: Specific columns, proper JOIN, indexed columns
SELECT
    u.id,
    u.username,
    u.email,
    COUNT(o.id) AS order_count
FROM users u
    INNER JOIN orders o ON u.id = o.user_id
WHERE
    o.created_at > '2025-01-01'
    AND u.status = 'active'
GROUP BY
    u.id,
    u.username,
    u.email
ORDER BY order_count DESC;

-- Ensure proper indexes exist:
-- CREATE INDEX idx_orders_user_created ON orders(user_id, created_at);
-- CREATE INDEX idx_users_status ON users(status);