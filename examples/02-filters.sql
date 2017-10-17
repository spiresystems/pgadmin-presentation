-- Selection criteria can be used to filter results

-- Basic equality
SELECT order_no, cust_no, salesperson_no
FROM sales_orders
WHERE salesperson_no = 'JOHN';

-- Not equals...
SELECT order_no, cust_no, subtotal
FROM sales_orders
WHERE salesperson_no <> 'JOHN';

-- Inequalities are also supported: < <= > >=

-- LIKE expressions
SELECT order_no, cust_no
FROM sales_orders
WHERE cust_no LIKE 'A%'

-- Multiple expressions can be specified using AND/OR
SELECT order_no, cust_no, subtotal, order_date
FROM sales_orders
WHERE order_date > '2017-01-01' AND (cust_no LIKE 'A%' OR subtotal >= 500);