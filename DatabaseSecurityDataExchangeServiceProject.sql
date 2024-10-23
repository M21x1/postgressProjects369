
--1
SELECT rolname
FROM pg_roles;

--2
SELECT *
FROM pg_roles;

--3
SELECT current_role;

--4

CREATE ROLE abc_open_data WITH LOGIN;

-- 5
CREATE ROLE publishers WITH NOSUPERUSER
ROLE abc_open_data;

-- 6
GRANT USAGE ON SCHEMA analytics TO publishers;

-- 7

GRANT SELECT ON ALL TABLES IN SCHEMA analytics TO publishers;

-- 8
SELECT * FROM information_schema.table_privileges WHERE grantee = 'publishers';

-- 9

SET ROLE abc_open_data;
SELECT * FROM
analytics.downloads LIMIT 10;

SET ROLE ccuser;

-- 10

SELECT * FROM directory.datasets LIMIT 5; 

-- 11 

GRANT USAGE ON SCHEMA directory TO publishers;

-- 12

GRANT SELECT (id, create_date, hosting_path, publisher, src_size) ON directory.datasets TO publishers;

-- 13
SET ROLE abc_open_data;
SELECT id, publisher, hosting_path--, --data_checksum
FROM directory.datasets;

SET ROLE ccuser;

-- 14

CREATE POLICY publisher_policy 
ON analytics.downloads 
FOR SELECT 
TO publishers 
USING (current_user = publisher);

ALTER TABLE analytics.downloads ENABLE ROW LEVEL SECURITY;

-- 15 
SELECT * FROM analytics.downloads LIMIT 10;

SET ROLE abc_open_data;
SELECT * FROM analytics.downloads LIMIT 10;

-- Remember to set your role back to your original role
SET ROLE ccuser;

Query as superuser
SELECT * FROM analytics.downloads LIMIT 10;

-- Switch to abc_open_data role
SET ROLE abc_open_data;
SELECT * FROM analytics.downloads LIMIT 10;

-- Switch back to superuser or original role
SET ROLE ccuser;
