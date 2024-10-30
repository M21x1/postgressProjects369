-- Check the first 10 rows in each table
SELECT * FROM customers LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM books LIMIT 10;

-- Check existing indexes on each table
SELECT * FROM pg_indexes WHERE tablename = 'customers';
SELECT * FROM pg_indexes WHERE tablename = 'books';
SELECT * FROM pg_indexes WHERE tablename = 'orders';

-- Create individual indexes for customer_id and book_id in the orders table
CREATE INDEX orders_customer_id_idx ON orders(customer_id);
CREATE INDEX orders_book_id_idx ON orders(book_id);

-- Analyze the runtime for a specific query on the books table
EXPLAIN ANALYZE 
SELECT original_language, title, sales_in_millions
FROM books
WHERE original_language = 'French';

-- Check the size of the books table
SELECT pg_size_pretty(pg_total_relation_size('books'));

-- Re-run the same query to compare runtime after index changes
EXPLAIN ANALYZE 
SELECT original_language, title, sales_in_millions
FROM books
WHERE original_language = 'French';

-- Example of using EXPLAIN ANALYZE with an INSERT statement
-- Note: EXPLAIN ANALYZE doesn't usually apply directly to INSERT
INSERT INTO books (title, author, original_language, first_published, sales_in_millions, price)
VALUES ('Linkel', 'Franklin Tee', 'English', 1989, 101120, 15);

-- Drop the index on customer_id and book_id in orders if no longer needed
DROP INDEX IF EXISTS orders_customer_id_idx, orders_book_id_idx;

-- Log timestamps for bulk insert
SELECT NOW();

-- Perform a bulk insert from the specified file
\COPY orders FROM 'orders_add.txt' DELIMITER ',' CSV HEADER;

SELECT NOW();

-- Recreate indexes on the orders table after bulk insert if needed
CREATE INDEX orders_customer_id_idx ON orders(customer_id);
CREATE INDEX orders_book_id_idx ON orders(book_id);

-- Create a multicolumn index on customers for frequent contact information lookups
CREATE INDEX customers_first_name_email_address_idx ON customers (first_name, email_address);