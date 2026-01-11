-- Poor performance: No indexes, SELECT *, unnecessary subquery
SELECT * FROM users
WHERE id IN (
    SELECT user_id FROM orders
    WHERE created_at > '2025-01-01'
);