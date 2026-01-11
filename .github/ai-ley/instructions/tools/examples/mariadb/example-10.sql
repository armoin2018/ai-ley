-- Complex queries with CTEs and window functions
WITH monthly_sales AS (
    SELECT
        DATE_FORMAT(created_at, '%Y-%m') as month,
        COUNT(*) as order_count,
        SUM(total_amount) as revenue,
        AVG(total_amount) as avg_order_value
    FROM orders
    WHERE status IN ('delivered', 'shipped')
        AND created_at >= DATE_SUB(NOW(), INTERVAL 12 MONTH)
    GROUP BY DATE_FORMAT(created_at, '%Y-%m')
),
running_totals AS (
    SELECT
        month,
        order_count,
        revenue,
        avg_order_value,
        SUM(revenue) OVER (ORDER BY month) as cumulative_revenue,
        LAG(revenue) OVER (ORDER BY month) as prev_month_revenue,
        (revenue - LAG(revenue) OVER (ORDER BY month)) / LAG(revenue) OVER (ORDER BY month) * 100 as growth_rate
    FROM monthly_sales
)
SELECT
    month,
    order_count,
    FORMAT(revenue, 2) as revenue,
    FORMAT(avg_order_value, 2) as avg_order_value,
    FORMAT(cumulative_revenue, 2) as cumulative_revenue,
    ROUND(growth_rate, 2) as growth_rate_percent
FROM running_totals
ORDER BY month;

-- JSON queries for product attributes
SELECT
    p.name,
    p.price,
    JSON_EXTRACT(p.attributes, '$.color') as color,
    JSON_EXTRACT(p.attributes, '$.size') as size,
    JSON_EXTRACT(p.attributes, '$.material') as material
FROM products p
WHERE JSON_EXTRACT(p.attributes, '$.color') = 'blue'
    AND p.price BETWEEN 50 AND 200
    AND p.status = 'active';

-- Full-text search with relevance scoring
SELECT
    p.id,
    p.name,
    p.description,
    p.price,
    MATCH(p.name, p.description) AGAINST ('wireless bluetooth headphones' IN NATURAL LANGUAGE MODE) as relevance_score
FROM products p
WHERE MATCH(p.name, p.description) AGAINST ('wireless bluetooth headphones' IN NATURAL LANGUAGE MODE)
    AND p.status = 'active'
ORDER BY relevance_score DESC, p.price ASC
LIMIT 20;

-- Advanced aggregation with multiple dimensions
SELECT
    c.name as category,
    COUNT(DISTINCT p.id) as product_count,
    COUNT(DISTINCT o.id) as order_count,
    SUM(oi.quantity) as total_items_sold,
    SUM(oi.total_price) as total_revenue,
    AVG(p.price) as avg_product_price,
    MIN(p.price) as min_price,
    MAX(p.price) as max_price
FROM categories c
LEFT JOIN products p ON c.id = p.category_id
LEFT JOIN order_items oi ON p.id = oi.product_id
LEFT JOIN orders o ON oi.order_id = o.id
    AND o.status IN ('delivered', 'shipped')
    AND o.created_at >= DATE_SUB(NOW(), INTERVAL 6 MONTH)
GROUP BY c.id, c.name
HAVING total_revenue > 0
ORDER BY total_revenue DESC;