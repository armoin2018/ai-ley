-- Executive KPI Summary View
WITH revenue_metrics AS (
    SELECT 
        DATE_TRUNC('month', order_date) as month,
        SUM(total_amount) as monthly_revenue,
        COUNT(DISTINCT customer_id) as unique_customers,
        AVG(total_amount) as avg_order_value,
        LAG(SUM(total_amount)) OVER (ORDER BY DATE_TRUNC('month', order_date)) as prev_month_revenue
    FROM sales_transactions
    WHERE order_date >= DATE_SUB(CURRENT_DATE(), INTERVAL 13 MONTH)
    GROUP BY DATE_TRUNC('month', order_date)
),
growth_metrics AS (
    SELECT 
        month,
        monthly_revenue,
        unique_customers,
        avg_order_value,
        ROUND(((monthly_revenue - prev_month_revenue) / prev_month_revenue) * 100, 2) as revenue_growth_pct,
        CASE 
            WHEN monthly_revenue > prev_month_revenue THEN 'positive'
            WHEN monthly_revenue < prev_month_revenue THEN 'negative' 
            ELSE 'neutral'
        END as growth_trend
    FROM revenue_metrics
    WHERE prev_month_revenue IS NOT NULL
)
SELECT 
    month,
    monthly_revenue,
    unique_customers,
    avg_order_value,
    revenue_growth_pct,
    growth_trend,
    -- Rolling 3-month average for trend smoothing
    AVG(monthly_revenue) OVER (
        ORDER BY month 
        ROWS BETWEEN 2 PRECEDING AND CURRENT ROW
    ) as rolling_3month_avg
FROM growth_metrics
ORDER BY month DESC;