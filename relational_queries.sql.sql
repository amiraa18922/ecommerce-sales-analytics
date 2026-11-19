-- =========================================================================
-- PROJECT: E-Commerce Sales Performance & Analytics Pipeline (Production Ready)
-- PURPOSE: End-to-end SQL backend providing executive KPIs, monthly trend lines,
--          category distribution, customer segmentation, and operational metrics.
-- DATABASE: ecommerce_db
-- =========================================================================

CREATE DATABASE IF NOT EXISTS ecommerce_db;
USE ecommerce_db;

-- -------------------------------------------------------------------------
-- PART 1: HIGH-LEVEL EXECUTIVE SUMMARY KPIS
-- Purpose: Populate top-level summary cards (Total Revenue, Total Orders, 
--          Average Order Value, Overall Rating, and Average Discount Rate).
-- Dashboard Use: KPI cards placed in the top banner for instant health check.
-- -------------------------------------------------------------------------

SELECT 
    COUNT(order_id) AS total_orders,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(revenue), 2) AS avg_order_value,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating,
    ROUND(AVG(discount) * 100, 2) AS avg_discount_percentage
FROM ecommerce_sales;


-- -------------------------------------------------------------------------
-- PART 2: MONTHLY TIME INTELLIGENCE & MOM REVENUE GROWTH
-- Purpose: Aggregate revenue by calendar month and calculate Month-over-Month 
--          (MoM) percentage growth using the LAG() window function.
-- Dashboard Use: Primary line/area chart showing revenue trajectory over time.
-- -------------------------------------------------------------------------

WITH MonthlySales AS (
    SELECT 
        -- Standardize date string into YYYY-MM format for monthly grouping
        LEFT(order_date, 7) AS sales_month,
        COUNT(order_id) AS monthly_orders,
        SUM(revenue) AS monthly_revenue
    FROM ecommerce_sales
    GROUP BY sales_month
)
SELECT 
    sales_month,
    monthly_orders,
    ROUND(monthly_revenue, 2) AS monthly_revenue,
    -- Fetch previous month's revenue to evaluate trend
    ROUND(LAG(monthly_revenue, 1) OVER (ORDER BY sales_month), 2) AS prev_month_revenue,
    -- Compute MoM growth percentage: ((Current - Previous) / Previous) * 100
    ROUND(
        ((monthly_revenue - LAG(monthly_revenue, 1) OVER (ORDER BY sales_month)) 
        / LAG(monthly_revenue, 1) OVER (ORDER BY sales_month)) * 100, 2
    ) AS mom_revenue_growth_pct
FROM MonthlySales
ORDER BY sales_month;


-- -------------------------------------------------------------------------
-- PART 3: PRODUCT CATEGORY PERFORMANCE & SHARE OF REVENUE
-- Purpose: Combine a Common Table Expression (CTE) with window functions 
--          to rank categories by revenue and calculate their percentage share.
-- Dashboard Use: Horizontal bar chart or donut chart showing revenue split.
-- -------------------------------------------------------------------------

WITH CategorySummary AS (
    SELECT 
        product_category,
        COUNT(order_id) AS total_orders,
        SUM(revenue) AS category_revenue,
        AVG(revenue) AS avg_revenue_per_order
    FROM ecommerce_sales
    GROUP BY product_category
)
SELECT 
    product_category,
    total_orders,
    ROUND(category_revenue, 2) AS category_revenue,
    ROUND(avg_revenue_per_order, 2) AS avg_revenue_per_order,
    -- Rank categories from highest to lowest total revenue
    RANK() OVER (ORDER BY category_revenue DESC) AS revenue_rank,
    -- Calculate share of total company revenue: (Category Rev / Global Rev) * 100
    ROUND((category_revenue / SUM(category_revenue) OVER ()) * 100, 2) AS percentage_of_total_revenue
FROM CategorySummary
ORDER BY category_revenue DESC;


-- -------------------------------------------------------------------------
-- PART 4: REGIONAL PERFORMANCE BREAKDOWN
-- Purpose: Analyze sales volume and total revenue across geographic regions.
-- Dashboard Use: Map visual or regional bar chart to identify key markets.
-- -------------------------------------------------------------------------

SELECT 
    region,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(revenue), 2) AS total_revenue,
    ROUND(AVG(revenue), 2) AS avg_order_value
FROM ecommerce_sales
GROUP BY region
ORDER BY total_revenue DESC;


-- -------------------------------------------------------------------------
-- PART 5: CUMULATIVE (RUNNING) REVENUE OVER TIME
-- Purpose: Track revenue accumulation order-by-order using SUM() OVER().
-- Dashboard Use: Detailed trend analysis or cumulative milestone tracking.
-- -------------------------------------------------------------------------

SELECT 
    order_id,
    order_date,
    revenue,
    -- Running total sorted chronologically by order date and ID
    ROUND(
        SUM(revenue) OVER (ORDER BY STR_TO_DATE(order_date, '%m/%d/%Y'), order_id), 
        2
    ) AS cumulative_revenue
FROM ecommerce_sales;


-- -------------------------------------------------------------------------
-- PART 6: CUSTOMER VALUE SEGMENTATION (RFM-Lite)
-- Purpose: Group customers into spend tiers (VIP, Mid-Tier, Standard) 
--          to identify high-value accounts and order frequency.
-- Dashboard Use: Customer loyalty breakdown card or table visual.
-- -------------------------------------------------------------------------

SELECT 
    customer_id,
    COUNT(order_id) AS order_count,
    ROUND(SUM(revenue), 2) AS total_customer_spend,
    ROUND(AVG(revenue), 2) AS avg_order_value,
    -- Categorize customers based on total spend thresholds
    CASE 
        WHEN SUM(revenue) >= 5000 THEN 'VIP Tier'
        WHEN SUM(revenue) >= 2500 THEN 'Mid-Tier'
        ELSE 'Standard Tier'
    END AS customer_tier
FROM ecommerce_sales
GROUP BY customer_id
ORDER BY total_customer_spend DESC;


-- -------------------------------------------------------------------------
-- PART 7: OPERATIONAL IMPACT: DISCOUNT & DELIVERY VS. SATISFACTION
-- Purpose: Evaluate operational trade-offs—how discounting levels impact 
--          average delivery speed, customer ratings, and order values.
-- Dashboard Use: Operational matrix or scatter chart for strategy reviews.
-- -------------------------------------------------------------------------

SELECT 
    -- Segment discounts into low, medium, and high brackets
    CASE 
        WHEN discount < 0.10 THEN 'Low Discount (<10%)'
        WHEN discount BETWEEN 0.10 AND 0.25 THEN 'Medium Discount (10-25%)'
        ELSE 'High Discount (>25%)'
    END AS discount_bracket,
    COUNT(order_id) AS order_count,
    ROUND(AVG(delivery_days), 1) AS avg_delivery_days,
    ROUND(AVG(customer_rating), 2) AS avg_customer_rating,
    ROUND(AVG(revenue), 2) AS avg_revenue
FROM ecommerce_sales
GROUP BY discount_bracket
ORDER BY avg_revenue DESC;



