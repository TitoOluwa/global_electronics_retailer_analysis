-- Query 1: Top stores by revenue

SELECT
    st.StoreKey,
    st.Country,
    st.State,
    st.`Square Meters`,
    COUNT(*) AS total_sales_lines,
    SUM(s.Quantity) AS total_units_sold,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`), 2
    ) AS estimated_revenue_usd
FROM sales AS s
JOIN stores AS st
    ON s.StoreKey = st.StoreKey
JOIN products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY
    st.StoreKey,
    st.Country,
    st.State,
    st.`Square Meters`
ORDER BY estimated_revenue_usd DESC
LIMIT 10;


-- Query 2: Online vs Physical Store Analysis

SELECT
    CASE
        WHEN s.StoreKey = 0 THEN 'Online'
        ELSE 'Physical Stores'
    END AS sales_channel,
    COUNT(*) AS total_sales_lines,
    SUM(s.Quantity) AS total_units_sold,
    COUNT(DISTINCT s.StoreKey) AS number_of_stores,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`), 2
    ) AS estimated_revenue_usd
FROM sales AS s
JOIN products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY sales_channel
ORDER BY estimated_revenue_usd DESC;


-- Query 3: Revenue per square metre (Are larger stores necessarily generating more revenue relative to their size?)

USE global_electronics;

SELECT
    st.StoreKey,
    st.Country,
    st.State,
    st.`Square Meters`,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`), 2
    ) AS estimated_revenue_usd,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`)
        / st.`Square Meters`, 2
    ) AS revenue_per_square_metre
FROM sales AS s
JOIN stores AS st
    ON s.StoreKey = st.StoreKey
JOIN products AS p
    ON s.ProductKey = p.ProductKey
WHERE st.StoreKey <> 0
    AND st.`Square Meters` IS NOT NULL
    AND st.`Square Meters` > 0
GROUP BY
    st.StoreKey,
    st.Country,
    st.State,
    st.`Square Meters`
ORDER BY revenue_per_square_metre DESC
LIMIT 10;