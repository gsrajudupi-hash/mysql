# SQL Joins
-- A join is a method of linking data between one (self-join) or 
-- more tables based on values of the common column between the tables.

/* MySQL supports the following types of joins:

Inner join
Left join
Right join
Cross join */

-- Inner Join - Returns only matching records from 2 tables

/* SELECT
    select_list
FROM t1
INNER JOIN t2 ON join_condition1
INNER JOIN t3 ON join_condition2
...; */

-- Query to display employeeCode, firstName & city of employees
USE classicmodels;

SELECT * FROM employees;
SELECT * FROM offices;



		
-- Query to display productCode and productName from the products table.
-- and  textDescription of product lines from the productlines table.



-- USING clause -  If joined fields of both tables have same name --Natural Join



# Design a query to display custNo, custName, SalesRepName of the customer




-- Inner join with group by clause
SELECT * FROM orders;
SELECT * FROM orderdetails;



-- Join 3 Tables
USE classicmodels;



-- Joins with operators
-- The following query uses a less-than ( <) join to find sales price of the 
-- product whose code is S10_1678 that is less than the manufacturer’s 
-- suggested retail price (MSRP) for that product.




# lEFT OUTER JOIN
-- LEFT JOIN returns all rows from the left table regardless of whether a row 
-- from the left table has a matching row from the right table or not. 
-- If there is no match, the columns of the row from the right table will contain NULL.

-- This query uses the LEFT JOIN clause to find all customers and their orders:
SELECT * FROM customers;
SELECT * FROM orders;



-- Left Join to find customers who have no order


-- Query to display All OrderNumbers, and their matching
-- CustomerNo & Prdct Code of 10123



		
# RIGHT JOIN
-- RIGHT JOIN returns all rows from the right table regardless of 
-- having matching rows from the left table or not.

-- Query to display all Sales Rep , customer Id & Customer Name 





#Full Outer Join

-- returns all rows from the left table (table1) and from the 
-- right table (table2).
-- MY SQL DOESNOT SUPPORT FULL JOIN.. INSTEAD USE UNION WITH LEFT/RIGHT JOINS




#Self Join
-- The self join is often used to query hierarchical data or to compare a row 
-- with other rows within the same table.
-- Joining a table to Itself, by Creating a virtual copy of a Table
USE classicmodels;
SELECT * FROM employees;



# ***************************************************************************

#Sub Query

-- A MySQL subquery is a query that is nested inside another query.
-- A MySQL subquery is called an inner query while the query that contains the 
-- subquery is called an outer query.
-- Sub query acts a criteria for Outer query.
-- Syntax: SELECT * FROM t1 WHERE column1 = (SELECT column1 FROM t2);


# Display Employees who work in Offices located in USA

SELECT * FROM offices;
SELECT * FROM employees;


	

-- Find customers who have not placed any Orders

SELECT * FROM orders;
SELECT * FROM customers;




-- Display products with price greater than '1958 Setra Bus'

SELECT * FROM products;

SELECT buyPrice FROM products WHERE productName='1958 Setra Bus';




--  find customers whose payments are greater than the average payment

SELECT * FROM payments;

SELECT AVG(amount) FROM payments;


