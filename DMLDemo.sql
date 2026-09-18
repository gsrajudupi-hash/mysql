# DML Operations - INSERT , UPDATE , DELETE

-- The INSERT statement allows you to insert one or more rows into a table. 
-- The following illustrates the syntax of the INSERT statement:

/*INSERT INTO table(c1,c2,...)
VALUES (v1,v2,...); */

desc departments;

-- Insert demo without specifying column names
USE classicmodels;




USE coforgedb;
SELECT * FROM departments;



-- Insert demo specifying columns fields

DESC department;

INSERT INTO department(deptName,fees,email) VALUES('Mech',75000,'mech@vtu.ac.in');



SELECT * FROM department;



/*
The UPDATE statement updates data in a table. 
It allows you to change the values in one or more columns of a single row or multiple rows.

 syntax of the UPDATE statement:

UPDATE  table_name 
SET 
    column_name1 = expr1,
    column_name2 = expr2,
    ...
[WHERE
    condition];
*/

USE college;

SELECT * from department;

-- Update department fees of cse to 1,20,000



SELECT * from department;

USE classicmodels;

SELECT * FROM employees WHERE employeeNumber=1401;

-- Update lastName, emailid of Pamela



SELECT * FROM employees WHERE employeeNumber=1401;

-- Update email domain of all Sales Reps with office code 6
--  to @sydneyclassicmodelcars.com

SELECT * FROM employees WHERE officeCode=6;
SELECT * FROM offices WHERE officeCode=6;



			
SELECT * FROM employees WHERE officeCode=6;

# DELETE statement
 /*To delete data from a table, you use the MySQL DELETE statement. 
 
 syntax of the DELETE statement:

DELETE FROM table_name
WHERE condition;  */

USE college;

SELECT * FROM departments;

-- Delete Travel department



SELECT * FROM departments;

USE classicmodels;

SELECT * FROM customersbackup2025;  -- 123 records



SELECT count(*) FROM customersbackup2025; -- 118  records

-- delete all records

DELETE FROM customersbackup2025; -- caution don't execute

-- Using LIMIT clause in delete

CREATE TABLE customersbackup2022 AS SELECT * FROM customers;

SELECT * FROM customersbackup2022;

SELECT * FROM customersbackup2022  WHERE country='France'; -- 12 customers

-- Delete customers from France with low 5 Credit Limit



-- Deleting Table

# Drop statement removes the table permanently from database



SHOW TABLES;

--
CREATE TABLE customers_france AS SELECT * FROM customers WHERE country='France' ;

SELECT * FROM customers_france;

-- use sonic;
-- Update Book Price (Single Record)
UPDATE books
SET price = 600.00
WHERE book_id = 1;

SELECT * FROM books;

-- Update Book Availability Status
UPDATE books
SET availability_status = 'Issued'
WHERE book_id = 2;

-- Update Author Name
UPDATE books
SET author = 'Robert C. Mike'
WHERE book_title = 'Clean Code';

-- Update Multiple Columns
UPDATE books
SET price = 600.00,
    availability_status = 'Reserved'
WHERE book_id = 3;

SELECT * FROM books;
-- Update All Books of a Particular Library
UPDATE books
SET availability_status = 'Unavailable'
WHERE library_id = 1;

-- Update Multiple Columns Using JOIN
-- For libraries established before 2010,
-- set book status to Reserved and increase price by 50.
UPDATE books b JOIN library l
	ON b.library_id = l.library_id
		SET b.availability_status = 'Reserved',b.price = b.price + 50
					WHERE l.established_year < 2010;

SELECT * FROM books;

-- Conditional Update Using CHECK Logic
UPDATE books
SET price = price + 50
WHERE published_year < 2010;

-- Delete a Specific Book (Safe Delete)
DELETE FROM books
WHERE book_id = 4;

-- Delete Books with High Price
DELETE FROM books
WHERE price > 750;

SELECT * FROM library;
DESC library;
UPDATE library SET STATUS='Closed' WHERE library_id BETWEEN 2 AND 4;

-- Delete Books from Closed Libraries using Sub Query
DELETE FROM books
WHERE library_id IN (
    SELECT library_id
    FROM library
    WHERE status = 'Closed'
);

SELECT * FROM books;


-- Delete All Records (Use Carefully)
DELETE FROM books;



