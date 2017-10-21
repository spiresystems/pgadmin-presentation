-- Updating existing records
UPDATE customers
SET credit_line = 5000
WHERE credit_line > 5000;

-- Adding new records
INSERT INTO salespeople (salesperson_no, name)
VALUES ('GEORGE', 'George Smith');