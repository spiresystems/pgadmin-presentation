-- Related records from multiple tables can be combined using JOINs
SELECT ord.id, order_no, ord.cust_no, cust.name, ord.order_date, ord.salesperson_no, cust.present_bal
FROM sales_orders AS ord
JOIN customers AS cust ON ord.cust_no = cust.cust_no
WHERE ord.salesperson_no = 'JOHN'
ORDER BY ord.order_date DESC;

-- Sometimes the related record may not exist, an INNER JOIN will not
-- return the row in such a case, but a LEFT JOIN will
SELECT item.order_no, item.whse, item.part_no, inv.onhand_qty
FROM sales_order_items AS item
LEFT JOIN inventory AS inv ON (item.whse = inv.whse AND item.part_no = inv.part_no);
