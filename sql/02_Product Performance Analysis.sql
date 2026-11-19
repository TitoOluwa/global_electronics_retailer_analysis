-- Query 1: Overall Sales Performance

SELECT
    COUNT(*) AS total_sales_lines,
    SUM(s.Quantity) AS total_units_sold,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`),
        2
    ) AS estimated_gross_revenue_usd
FROM sales AS s
JOIN products AS p
    ON s.ProductKey = p.ProductKey;
    
    
-- Query 2: Which Product Category Generate the Most Revenue?

SELECT
    p.Category,
    COUNT(*) AS total_sales_lines,
    SUM(s.Quantity) AS total_units_sold,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`),
        2
    ) AS estimated_gross_revenue_usd
FROM sales AS s
JOIN products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY estimated_gross_revenue_usd DESC;


-- Query 3: Calculate each Category Revenue Contribution

SELECT
    p.Category,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`),
        2
    ) AS estimated_revenue_usd,
    ROUND(
        100.0 * SUM(s.Quantity * p.`Unit Price USD`)
        / (
            SELECT SUM(s2.Quantity * p2.`Unit Price USD`)
            FROM sales AS s2
            JOIN products AS p2
                ON s2.ProductKey = p2.ProductKey
        ),
        2
    ) AS revenue_contribution_pct
FROM sales AS s
JOIN products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY p.Category
ORDER BY estimated_revenue_usd DESC;