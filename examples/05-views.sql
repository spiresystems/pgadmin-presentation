-- Views can save a SQL query for future use...
CREATE VIEW stale_orders AS
SELECT order_no, cust_no, cust_name, order_date, subtotal
FROM sales_orders
WHERE order_date < current_date - '3 months'::interval
AND status <> 'Q';

-- Views can be queried as if they were a table
SELECT * FROM stale_orders;

-- But they create a dependency relation that prevents some
-- database migrations from running
ALTER TABLE sales_orders
ALTER COLUMN cust_no SET DATA TYPE VARCHAR(40);
-- ERROR:  cannot alter type of a column used by a view or rule

-- Views can be created as stored procedures to bypass this problem
DROP VIEW stale_orders;

CREATE FUNCTION stale_orders() RETURNS TABLE (
   order_no VARCHAR, cust_no VARCHAR, cust_name VARCHAR, 
   order_date DATE, subtotal NUMERIC)
LANGUAGE sql
AS $$
SELECT order_no, cust_no, cust_name, order_date, subtotal
FROM sales_orders
WHERE order_date < current_date - '3 months'::interval
AND status <> 'Q'
$$;

-- Syntax to query stored procedures is similar to views
SELECT * FROM stale_orders();

-- Stored procedures can also be parameterized
CREATE FUNCTION stale_orders(older_than INTERVAL) RETURNS TABLE (
   order_no VARCHAR, cust_no VARCHAR, cust_name VARCHAR, 
   order_date DATE, subtotal NUMERIC)
LANGUAGE sql
AS $$
SELECT order_no, cust_no, cust_name, order_date, subtotal
FROM sales_orders
WHERE order_date < current_date - older_than
AND status <> 'Q'
$$;

-- ...which allows for some flexibility
SELECT * FROM stale_orders('6 months');