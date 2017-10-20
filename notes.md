Introduction to pgAdmin
=======================

Warnings and Disclaimers
------------------------

* Back up your data before doing anything stupid
    * Create a snapshot using spiretray or backup via pgAdmin
* There are no training wheels; accidents may result in data loss!
* Spire support won't help you; Google is your friend
    * https://www.postgresql.org/docs/9.3/static/index.html

The pgAdmin User Interface
--------------------------

* Connecting to a server (local and remote)
* Exploring databases and their contents
* Modifying users (a.k.a. "roles" in PostgreSQL)
* Executing queries
    * Loading and saving queries
    * Recalling previously run queries
    * Executing only part of a query
* pgAdmin contains a utility to construct a SELECT statement graphically


Spire Database Overview
-----------------------

* The `spire` database contains a list of companies and associated information
    * `companies`
    * `backup_schedules`
    * `licenses`

* Spire company databases are separated into several possible schemas
    * `public`: regular database tables
    * `fulltext`: full text search index
    * `matviews`: materialized views
    * `legacy`: legacy views for legacy reports
    * `temp`: temporary views and tables

* Spire database dictionary: in the manual under "reporting"

    http://help.spiresystems.com/manual/2.7/en/topic/data-dictionary


Basic SQL Syntax
----------------

* String literals must be enclosed in single quotes
* Comments begin with two hyphens and extend to the end of line
    `-- This is a valid SQL comment`
* SQL treats all identifiers as lower case unless enclosed in double quotes

Querying Data (SELECT)
----------------------

* Basic structure of a SELECT statement

    ~~~
    SELECT <column list>
    FROM <table>
    WHERE <filter criteria>
    ORDER BY <column list> [DESC]
    ~~~

Selection Criteria
------------------

* Selection criteria at its most basic: single equality expression

    ~~~
    WHERE <column> = <value>
    ~~~

* Full suite of comparison operators are available
    * `=`: eqality
    * `<>`: not equals
    * `>`: greater than
    * `>=`: greater or equal
    * `<`: less than
    * `<=`: lesser or equal

* Multiple subexpressions can be connected with `AND`/`OR`

    ~~~
    WHERE <column1> = <value> AND <column2> = <value>
    ~~~

* Other filter expressions are available
    * `LIKE`: pattern matching


Joins
-----

* Without filter criteria SQL will generate the cartesian product of all tables
* Multiple tables can be linked correctly by specifying join criteria

    ~~~
    SELECT <column list>
    FROM <table>
    JOIN <table2> ON <table.id> = <table2.t1_id>
    ~~~

* Types of JOINS
    * INNER JOIN (default) requires that records exist for both tables
    * LEFT JOIN returns NULL for all joined columns where a record doesn't
      exist


Updating Data (INSERT/UPDATE/DELETE)
-----------------------------

* `INSERT` statements create additional rows

    ~~~
    INSERT INTO <table> (<column list>)
    VALUES (<value list>)
    ~~~

* `UPDATE` statements modify existing rows

    ~~~
    UPDATE <table>
    SET <value list>
    WHERE <filter criteria>
    ~~~

* `DELETE` statements remove existing rows

    ~~~
    DELETE FROM <table>
    WHERE <filter criteria>
    ~~~


PostgreSQL Specifics
--------------------

* HSTORE syntax

    ~~~
    udf_data -> 'field'
    ~~~

* Handle missing UDF fields
    * Missing UDF fields will be `NULL`, use `COALESCE` to get a default value

    ~~~
    COALESCE(udf_data->'field', 0)
    ~~~

* ARRAY syntax (NB: Arrays use 1-based indexing)

    ~~~
    array_field[1]
    ~~~


Creating Views
--------------

* Views can be used to build sophisticated queries that can be run using
  Crystal Reports or some other database tool.
* `CREATE VIEW <viewname> AS <select statement>`
* Views create a dependency relationship that can cause future database
  migrations to fail.
* Views created as stored procedures do not create a dependency, allowing
  database migrations to run normally.


Useful Queries
--------------

* Copying one user's password to another

    ~~~
    UPDATE users SET password = (
        SELECT password FROM users WHERE username = 'bob')
    WHERE username = 'sue'
    ~~~

* Removing record locks

    ~~~
    TRUNCATE TABLE system_record_locks
    ~~~

* Finding orphaned records

    ~~~
    SELECT id, order_no
    FROM sales_order_items AS item
    WHERE NOT EXISTS (
        SELECT * FROM sales_orders AS ord
        WHERE ord.order_no = item.order_no)
    ~~~

* List active database connections

    ~~~
    SELECT * FROM pg_stat_activity
    ~~~

* Terminate an active connection

    ~~~
    SELECT pg_terminate_backend(<pid>)
    ~~~


Useful Stored Procedures
------------------------

* `ap_aged_list(<date>)`
* `ap_aged_summary(<date>, <vendor_no>)`
* `ap_applied_amt(<txn_id>, <date>)`
* `ar_aged_list(<date>)`
* `ar_aged_summary(<date>, <customer_no>)`
* `ar_applied_amt(<txn_id>, <date>)`
* `convert_currency_from(<amount>, <method>, <rate>, <decimals>)`
* `convert_currency_to(<amount>, <method>, <rate>, <decimals>)`
* `format_phone_number(<kind>, <format#>, <digits>)`
* `format_segments(<account_no>)`
* `gl_period_balances(<date>)`
