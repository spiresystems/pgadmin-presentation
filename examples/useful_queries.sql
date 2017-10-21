-- Copying one user's password to another
UPDATE users SET password = (
SELECT password FROM users WHERE username = 'bob')
WHERE username = 'sue';

-- Removing record locks
TRUNCATE TABLE system_record_locks;

-- Finding orphaned records
SELECT id, order_no
FROM sales_order_items AS item
WHERE NOT EXISTS (
SELECT * FROM sales_orders AS ord
WHERE ord.order_no = item.order_no);

-- List active database connections
SELECT * FROM pg_stat_activity;

-- Terminate active connection
SELECT pg_terminate_backend(123);