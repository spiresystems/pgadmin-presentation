-- Aged AP totals
SELECT * FROM ap_aged_summary('2016-08-01');
SELECT * FROM ap_aged_summary('2016-08-01', 'FORFOO');

-- Aged AR totals
SELECT * FROM ar_aged_summary('2016-08-01');
SELECT * FROM ar_aged_summary('2016-08-01', 'ACCE668');

-- Currency conversion functions
SELECT convert_currency_from(125, '/', 1.5, 2);
SELECT convert_currency_to(187.5, '/', 1.5, 2);

-- Phone/fax number formatting
SELECT format_phone_number('P', 1::smallint, '6045552501');
SELECT format_phone_number('F', 1::smallint, '6045554715');

-- GL account balance by period
SELECT * FROM gl_period_balances('2016-08-01');
