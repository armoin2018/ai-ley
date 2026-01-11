-- Advanced analytics views and functions
CREATE MATERIALIZED VIEW daily_sales_summary AS
SELECT
    DATE_TRUNC('day', created_at) as sale_date,
    COUNT(*) as order_count,
    SUM(total_price) as total_revenue,
    AVG(total_price) as average_order_value,
    COUNT(DISTINCT user_id) as unique_customers,
    SUM(CASE WHEN status = 'cancelled' THEN 1 ELSE 0 END) as cancelled_orders,
    SUM(CASE WHEN status = 'delivered' THEN total_price ELSE 0 END) as delivered_revenue
FROM orders
WHERE created_at >= CURRENT_DATE - INTERVAL '2 years'
GROUP BY DATE_TRUNC('day', created_at)
ORDER BY sale_date;

CREATE UNIQUE INDEX ON daily_sales_summary(sale_date);

-- Customer lifetime value calculation
CREATE OR REPLACE VIEW customer_lifetime_value AS
WITH customer_metrics AS (
    SELECT
        user_id,
        COUNT(*) as total_orders,
        SUM(total_price) as total_spent,
        AVG(total_price) as average_order_value,
        MIN(created_at) as first_order_date,
        MAX(created_at) as last_order_date,
        EXTRACT(DAYS FROM MAX(created_at) - MIN(created_at)) as customer_lifespan_days
    FROM orders
    WHERE user_id IS NOT NULL AND status NOT IN ('cancelled', 'refunded')
    GROUP BY user_id
)
SELECT
    cm.*,
    CASE
        WHEN customer_lifespan_days > 0
        THEN total_spent / (customer_lifespan_days / 365.0)
        ELSE total_spent
    END as annual_value,
    CASE
        WHEN total_spent >= 1000 THEN 'High Value'
        WHEN total_spent >= 500 THEN 'Medium Value'
        ELSE 'Low Value'
    END as customer_segment,
    CASE
        WHEN last_order_date >= CURRENT_DATE - INTERVAL '30 days' THEN 'Active'
        WHEN last_order_date >= CURRENT_DATE - INTERVAL '90 days' THEN 'At Risk'
        ELSE 'Churned'
    END as customer_status
FROM customer_metrics;

-- Product performance analytics
CREATE OR REPLACE FUNCTION get_product_performance(
    p_start_date DATE DEFAULT CURRENT_DATE - INTERVAL '30 days',
    p_end_date DATE DEFAULT CURRENT_DATE
)
RETURNS TABLE (
    product_id UUID,
    product_name VARCHAR,
    category_name VARCHAR,
    total_quantity_sold BIGINT,
    total_revenue DECIMAL,
    average_price DECIMAL,
    profit_margin DECIMAL,
    inventory_turnover DECIMAL,
    performance_rank INTEGER
) AS $$
BEGIN
    RETURN QUERY
    WITH product_sales AS (
        SELECT
            p.id,
            p.name,
            c.name as category,
            SUM(oi.quantity) as qty_sold,
            SUM(oi.quantity * oi.price) as revenue,
            AVG(oi.price) as avg_price,
            AVG(p.cost) as avg_cost,
            AVG(p.inventory_quantity) as avg_inventory
        FROM products p
        LEFT JOIN categories c ON p.category_id = c.id
        LEFT JOIN order_items oi ON p.id = oi.product_id
        LEFT JOIN orders o ON oi.order_id = o.id
        WHERE o.created_at BETWEEN p_start_date AND p_end_date
            OR o.created_at IS NULL
        GROUP BY p.id, p.name, c.name
    )
    SELECT
        ps.id,
        ps.name::VARCHAR,
        ps.category::VARCHAR,
        COALESCE(ps.qty_sold, 0),
        COALESCE(ps.revenue, 0),
        ps.avg_price,
        CASE
            WHEN ps.avg_cost > 0 AND ps.avg_price > 0
            THEN ((ps.avg_price - ps.avg_cost) / ps.avg_price * 100)
            ELSE 0
        END,
        CASE
            WHEN ps.avg_inventory > 0
            THEN ps.qty_sold / ps.avg_inventory
            ELSE 0
        END,
        ROW_NUMBER() OVER (ORDER BY COALESCE(ps.revenue, 0) DESC)::INTEGER
    FROM product_sales ps
    ORDER BY revenue DESC;
END;
$$ LANGUAGE plpgsql;

## Enterprise PostgreSQL Management Framework

### Advanced High Availability Configuration

#### 1. PostgreSQL Streaming Replication with Automatic Failover