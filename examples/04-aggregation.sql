-- Count all the results of an expression
SELECT count(*)
FROM sales_order_items

-- Rows can be aggregated using totals
SELECT order_no, count(*), sum(order_qty * unit_price)
FROM sales_order_items
GROUP BY order_no