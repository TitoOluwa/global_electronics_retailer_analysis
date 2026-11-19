-- Query 1: How do sales vary by year?

SELECT
    YEAR(s.`Order Date`) AS sales_year,
    COUNT(*) AS total_sales_lines,
    SUM(s.Quantity) AS total_units_sold,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`),
        2
    ) AS estimated_revenue_usd
FROM sales AS s
JOIN products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY YEAR(s.`Order Date`)
ORDER BY sales_year;


-- Query 2: How do sales vary by month?

SELECT
    YEAR(s.`Order Date`) AS sales_year,
    MONTH(s.`Order Date`) AS sales_month,
    MONTHNAME(s.`Order Date`) AS month_name,
    COUNT(*) AS total_sales_lines,
    SUM(s.Quantity) AS total_units_sold,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`),
        2
    ) AS estimated_revenue_usd
FROM sales AS s
JOIN products AS p
    ON s.ProductKey = p.ProductKey
GROUP BY
    YEAR(s.`Order Date`),
    MONTH(s.`Order Date`),
    MONTHNAME(s.`Order Date`)
ORDER BY
    sales_year,
    sales_month;
    
    
-- Query 3: Which month is the strongest overall?

SELECT
    MONTH(s.`Order Date`) AS month_number,
    MONTHNAME(s.`Order Date`) AS month_name,
    ROUND(
        AVG(monthly_revenue),
        2
    ) AS average_monthly_revenue_usd
FROM (
    SELECT
        s.`Order Date`,
        SUM(s.Quantity * p.`Unit Price USD`) AS monthly_revenue
    FROM sales AS s
    JOIN products AS p
        ON s.ProductKey = p.ProductKey
    WHERE YEAR(s.`Order Date`) BETWEEN 2016 AND 2020
    GROUP BY
        YEAR(s.`Order Date`),
        MONTH(s.`Order Date`),
        s.`Order Date`
) AS monthly_sales
JOIN sales AS s
    ON s.`Order Date` = monthly_sales.`Order Date`
GROUP BY
    MONTH(s.`Order Date`),
    MONTHNAME(s.`Order Date`)
ORDER BY
    month_number;
    
    
-- Query 3: Cleaner method
SELECT
    month_number,
    month_name,
    ROUND(AVG(monthly_revenue_usd), 2) AS average_monthly_revenue_usd
FROM (
    SELECT
        YEAR(s.`Order Date`) AS sales_year,
        MONTH(s.`Order Date`) AS month_number,
        MONTHNAME(s.`Order Date`) AS month_name,
        SUM(s.Quantity * p.`Unit Price USD`) AS monthly_revenue_usd
    FROM sales AS s
    JOIN products AS p
        ON s.ProductKey = p.ProductKey
    WHERE YEAR(s.`Order Date`) BETWEEN 2016 AND 2020
    GROUP BY
        YEAR(s.`Order Date`),
        MONTH(s.`Order Date`),
        MONTHNAME(s.`Order Date`)
) AS monthly_totals
GROUP BY month_number, month_name
ORDER BY month_number;


-- Query 4: Investigate weak April sales

SELECT
    YEAR(s.`Order Date`) AS sales_year,
    MONTHNAME(s.`Order Date`) AS month_name,
    COUNT(*) AS total_sales_lines,
    SUM(s.Quantity) AS total_units_sold,
    ROUND(
        SUM(s.Quantity * p.`Unit Price USD`),
        2
    ) AS estimated_revenue_usd
FROM sales AS s
JOIN products AS p
    ON s.ProductKey = p.ProductKey
WHERE MONTH(s.`Order Date`) IN (3, 4, 5)
  AND YEAR(s.`Order Date`) BETWEEN 2016 AND 2020
GROUP BY
    YEAR(s.`Order Date`),
    MONTH(s.`Order Date`),
    MONTH(s.`Order Date`),
    MONTHNAME(s.`Order Date`)
ORDER BY
    sales_year,
    MONTH(s.`Order Date`);
