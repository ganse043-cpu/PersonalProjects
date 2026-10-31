USE users;

select * from user_events LIMIT 1000;

-- ============================================================
-- 1. SALES FUNNEL STAGE COUNTS
-- Counts distinct users at each stage independently.
-- Does not enforce a sequential journey.
-- ============================================================

SELECT
    COUNT(DISTINCT CASE
        WHEN event_type = 'page_view' THEN user_id
    END) AS stage_1_views,

    COUNT(DISTINCT CASE
        WHEN event_type = 'add_to_cart' THEN user_id
    END) AS stage_2_cart,

    COUNT(DISTINCT CASE
        WHEN event_type = 'checkout_start' THEN user_id
    END) AS stage_3_checkout,

    COUNT(DISTINCT CASE
        WHEN event_type = 'payment_info' THEN user_id
    END) AS stage_4_payment,

    COUNT(DISTINCT CASE
        WHEN event_type = 'purchase' THEN user_id
    END) AS stage_5_purchase
FROM user_events;


-- ============================================================
-- 2. OVERALL FUNNEL RATES
-- Ratios of independent stage counts.
-- ============================================================

WITH funnel_stages AS (
    SELECT
        COUNT(DISTINCT CASE
            WHEN event_type = 'page_view' THEN user_id
        END) AS views,

        COUNT(DISTINCT CASE
            WHEN event_type = 'add_to_cart' THEN user_id
        END) AS cart,

        COUNT(DISTINCT CASE
            WHEN event_type = 'checkout_start' THEN user_id
        END) AS checkout,

        COUNT(DISTINCT CASE
            WHEN event_type = 'payment_info' THEN user_id
        END) AS payment,

        COUNT(DISTINCT CASE
            WHEN event_type = 'purchase' THEN user_id
        END) AS purchases
    FROM user_events
)

SELECT
    ROUND(cart * 100.0 / NULLIF(views, 0), 2)
        AS view_to_cart_rate,

    ROUND(checkout * 100.0 / NULLIF(cart, 0), 2)
        AS cart_to_checkout_rate,

    ROUND(payment * 100.0 / NULLIF(checkout, 0), 2)
        AS checkout_to_payment_rate,

    ROUND(purchases * 100.0 / NULLIF(payment, 0), 2)
        AS payment_to_purchase_rate,

    ROUND(purchases * 100.0 / NULLIF(views, 0), 2)
        AS overall_conversion_rate
FROM funnel_stages;


-- ============================================================
-- 3. CONVERSION BY TRAFFIC SOURCE
-- Matches each user's first view from a source to later events.
-- Later cart and purchase events may have any traffic source.
-- Users may count under multiple sources.
-- ============================================================

WITH first_views AS (
    SELECT
        user_id,
        traffic_source,
        MIN(event_date) AS view_time
    FROM user_events
    WHERE event_type = 'page_view'
      AND user_id IS NOT NULL
    GROUP BY user_id, traffic_source
),

source_journeys AS (
    SELECT
        v.user_id,
        v.traffic_source,
        v.view_time,

        MIN(CASE
            WHEN e.event_type = 'add_to_cart'
            THEN e.event_date
        END) AS cart_time,

        MIN(CASE
            WHEN e.event_type = 'purchase'
            THEN e.event_date
        END) AS purchase_time

    FROM first_views AS v
    LEFT JOIN user_events AS e
        ON e.user_id = v.user_id
       AND e.event_date >= v.view_time
       AND e.event_type IN ('add_to_cart', 'purchase')
    GROUP BY
        v.user_id,
        v.traffic_source,
        v.view_time
)

SELECT
    traffic_source,
    COUNT(*) AS views,
    COUNT(cart_time) AS cart,
    COUNT(purchase_time) AS purchases,

    ROUND(
        COUNT(cart_time) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS cart_conversion_rate,

    ROUND(
        COUNT(purchase_time) * 100.0 / NULLIF(COUNT(*), 0),
        2
    ) AS purchase_conversion_rate

FROM source_journeys
GROUP BY traffic_source
ORDER BY purchase_conversion_rate DESC;


-- ============================================================
-- 4. REVENUE METRICS
-- Assumes each purchase event represents one order.
-- ============================================================

WITH revenue_summary AS (
    SELECT
        COUNT(DISTINCT CASE
            WHEN event_type = 'page_view' THEN user_id
        END) AS total_visitors,

        COUNT(DISTINCT CASE
            WHEN event_type = 'purchase' THEN user_id
        END) AS total_buyers,

        COUNT(CASE
            WHEN event_type = 'purchase' THEN 1
        END) AS total_orders,

        COALESCE(SUM(CASE
            WHEN event_type = 'purchase' THEN amount
        END), 0) AS total_revenue

    FROM user_events
)

SELECT
    total_visitors,
    total_buyers,
    total_orders,
    ROUND(total_revenue, 2) AS total_revenue,

    ROUND(total_revenue / NULLIF(total_orders, 0), 2)
        AS avg_order_value,

    ROUND(total_revenue / NULLIF(total_buyers, 0), 2)
        AS revenue_per_buyer,

    ROUND(total_revenue / NULLIF(total_visitors, 0), 2)
        AS revenue_per_visitor

FROM revenue_summary;


-- ============================================================
-- 5. TIME TO CONVERSION — ADDITIONAL ANALYSIS
-- Retained for analysis; not used in the current dashboard.
-- Uses each purchasing user's earliest event of each type.
-- Missing events are excluded from the corresponding average.
-- Review event order before interpreting these results.
-- ============================================================

WITH user_journey AS (
    SELECT
        user_id,

        MIN(CASE
            WHEN event_type = 'page_view' THEN event_date
        END) AS view_time,

        MIN(CASE
            WHEN event_type = 'add_to_cart' THEN event_date
        END) AS cart_time,

        MIN(CASE
            WHEN event_type = 'purchase' THEN event_date
        END) AS purchase_time

    FROM user_events
    WHERE user_id IS NOT NULL
    GROUP BY user_id
)

SELECT
    COUNT(*) AS converted_users,

    ROUND(AVG(
        TIMESTAMPDIFF(SECOND, view_time, cart_time) / 60.0
    ), 2) AS avg_view_to_cart_min,

    ROUND(AVG(
        TIMESTAMPDIFF(SECOND, cart_time, purchase_time) / 60.0
    ), 2) AS avg_cart_to_purchase_min,

    ROUND(AVG(
        TIMESTAMPDIFF(SECOND, view_time, purchase_time) / 60.0
    ), 2) AS avg_total_purchase_min

FROM user_journey
WHERE purchase_time IS NOT NULL;