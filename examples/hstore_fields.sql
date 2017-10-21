-- PostgreSQL specific features


-- HSTORE (UDF) fields
SELECT order_no, udf_data FROM sales_orders;

-- Access a single field
SELECT order_no, udf_data, udf_data->'Carrier' FROM sales_orders;

-- HSTORE values are stored as strings, cast to other data types
SELECT order_no, udf_data, (udf_data->'Date')::DATE as dt
FROM sales_orders
ORDER BY dt;

-- Missing values are treated as NULL
-- Use COALESCE() to provide a "default" result for missing data
SELECT order_no, udf_data, COALESCE((udf_data->'Complete')::Boolean, False) AS complete
FROM sales_orders
ORDER BY complete DESC;