-- The following examples are meant to be run individually
-- Running all these queries at once will only display results
-- from the last query. To run a single query, highlight it in
-- pgAdmin and click "Execute query" or press F5

-- SELECT statements at their most basic can calculate the results of expressions
SELECT 'test';
SELECT 3 + 4;
SELECT CURRENT_DATE;

-- SELECT all columns and all records from some table
SELECT * FROM sales_orders;

-- Specifying which columns to retrieve:
SELECT id, order_no, cust_no, order_date, salesperson_no
FROM sales_orders;

-- Sorting results
SELECT id, order_no, cust_no, order_date, salesperson_no
FROM sales_orders
ORDER BY order_date DESC;

-- Filtering results
SELECT id, order_no, cust_no, order_date, salesperson_no
FROM sales_orders
WHERE salesperson_no = 'JOHN'
ORDER BY order_date DESC;