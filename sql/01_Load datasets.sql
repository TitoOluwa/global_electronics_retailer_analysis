-- (1)
-- Create the database for the Global Electronics project
CREATE DATABASE IF NOT EXISTS global_electronics;

-- Select the database for subsequent SQL operations
USE global_electronics;

-- Confirm the selected database
SELECT DATABASE();


-- (2)
-- Verify datasets import 
USE global_electronics;
SELECT COUNT(*) AS total_products
FROM products;

SELECT *
FROM products
LIMIT 5;

-- (3)
-- Verify all five tables
SELECT 'customers' AS table_name, COUNT(*) AS total_rows
FROM customers

UNION ALL

SELECT 'sales', COUNT(*)
FROM sales

UNION ALL

SELECT 'products', COUNT(*)
FROM products

UNION ALL

SELECT 'stores', COUNT(*)
FROM stores

UNION ALL

SELECT 'exchange_rates', COUNT(*)
FROM exchange_rates;