/*SELECT * FROM customers LIMIT 10;
SELECT * FROM orders LIMIT 10;
SELECT * FROM books LIMIT 10;*/

SELECT *
FROM pg_indexes
WHERE tablename = 'books';

EXPLAIN ANALYZE SELECT *
FROM orders
WHERE quantity > 18;

CREATE INDEX orders_18books ON orders(quantity);

EXPLAIN ANALYZE SELECT *
FROM orders
WHERE quantity > 18;


EXPLAIN ANALYZE SELECT *
FROM customers
WHERE customer_id < 100;

-- adding a pkey
ALTER TABLE customers 
ADD CONSTRAINT customers_pkey
PRIMARY KEY (customer_id);


EXPLAIN ANALYZE SELECT *
FROM customers
WHERE customer_id < 100;

CLUSTER customers USING customers_pkey;


--CREATE INDEX orders_customer_id_book_id_idx ON orders(customer_id, book_id);

--DROP INDEX orders_customer_id_book_id_idx;


CREATE INDEX 
books_author_title_idx 
ON books(author, title);


EXPLAIN ANALYZE SELECT *
FROM orders
WHERE quantity*price_base > 100;

CREATE INDEX order_shipping_delay_idx
ON orders ((ship_date - order_date));

EXPLAIN ANALYZE SELECT *
FROM orders
WHERE quantity*price_base > 100;