-- Query optimization and indexing strategies
-- Analyze query performance
EXPLAIN EXTENDED
SELECT o.*, u.email, u.first_name, u.last_name
FROM orders o
JOIN users u ON o.user_id = u.id
WHERE o.created_at >= DATE_SUB(NOW(), INTERVAL 30 DAY)
    AND o.status = 'delivered'
ORDER BY o.created_at DESC;

-- Create composite indexes for common query patterns
CREATE INDEX idx_orders_status_created ON orders(status, created_at);
CREATE INDEX idx_orders_user_status ON orders(user_id, status, created_at);

-- Optimize for specific query patterns
CREATE INDEX idx_products_category_status_price ON products(category_id, status, price);
CREATE INDEX idx_order_items_product_order ON order_items(product_id, order_id);

-- Partition large tables by date
ALTER TABLE orders
PARTITION BY RANGE (YEAR(created_at)) (
    PARTITION p2022 VALUES LESS THAN (2023),
    PARTITION p2023 VALUES LESS THAN (2024),
    PARTITION p2024 VALUES LESS THAN (2025),
    PARTITION p_future VALUES LESS THAN MAXVALUE
);