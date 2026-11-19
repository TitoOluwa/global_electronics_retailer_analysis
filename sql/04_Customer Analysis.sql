-- Query 1: Top 10 customers by total units purchased

USE global_electronics;

SELECT
    s.CustomerKey,
    c.Name,
    c.Country,
    c.City,
    COUNT(*) AS total_sales_lines,
    SUM(s.Quantity) AS total_units_purchased
FROM sales AS s
JOIN customers AS c
    ON s.CustomerKey = c.CustomerKey
GROUP BY
    s.CustomerKey,
    c.Name,
    c.Country,
    c.City
ORDER BY total_units_purchased DESC
LIMIT 10;


-- Query 2: Top 10 customers by estimated revenue

USE global_electronics;

SELECT
    s.CustomerKey,
    c.Name,
    c.Country,
    c.City,
    SUM(s.Quantity) AS total_units_purchased,
    ROUND(SUM(s.Quantity * p.`Unit Price USD`), 2) AS estimated_revenue_usd
FROM sales AS s
JOIN customers AS c
    ON s.CustomerKey = c.CustomerKey
JOIN products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY
    s.CustomerKey,
    c.Name,
    c.Country,
    c.City
ORDER BY estimated_revenue_usd DESC
LIMIT 10;


-- Query 3: Customer Distribution and Estimated Revenue by Country.
USE global_electronics;

SELECT
    c.Country,
    COUNT(DISTINCT c.CustomerKey) AS total_customers,
    COUNT(*) AS total_sales_lines,
    SUM(s.Quantity) AS total_units_sold,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`), 2
    ) AS estimated_revenue_usd
FROM sales AS s
JOIN customers AS c
    ON s.CustomerKey = c.CustomerKey
JOIN products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY c.Country
ORDER BY estimated_revenue_usd DESC;


-- Query 4: Average revenue per customer by country
USE global_electronics;

SELECT
    c.Country,
    COUNT(DISTINCT c.CustomerKey) AS total_customers,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`), 2
    ) AS estimated_revenue_usd,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`)
        / COUNT(DISTINCT c.CustomerKey), 2
    ) AS average_revenue_per_customer
FROM sales AS s
JOIN customers AS c
    ON s.CustomerKey = c.CustomerKey
JOIN products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY c.Country
ORDER BY average_revenue_per_customer DESC;