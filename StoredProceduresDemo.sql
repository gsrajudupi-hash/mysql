#Stored Procedure

/*A stored procedure is a set of Structured Query Language (SQL) statements with an 
assigned name, which are stored in a relational database management system (RDBMS) 
as a group, so it can be reused and shared by multiple programs.

Stored procedures can access or modify data in a database, but it is not tied to a 
specific database or object, which offers a number of advantages.
*/

-- Normally Queries are not saved
-- If you want to save any query on the database server for execution later, one way 
-- to do it is to use a stored procedure.

USE classicmodels;

SELECT 
    customerName, 
    city, 
    state, 
    postalCode, 
    country
FROM
    customers
ORDER BY customerName;

/*The following CREATE PROCEDURE statement creates a new stored procedure that 
 wraps the query above: */

-- Create Stored Procedure










	
-- Invoke Stored Procedure


-- --------------------------------------------------
SELECT *  FROM employees;
SELECT * FROM offices;








-- Call Stored Procedure



-- 
/* IN parameters
IN is the default mode. When you define an IN parameter in a stored procedure, 
the calling program has to pass an argument to the stored procedure.*/

-- stored procedure that finds all offices that locate in a country 
-- specified by the input parameter countryName:






-- call SP with IN parameter





/*OUT parameters
The value of an OUT parameter can be changed inside the stored procedure 
and its new value is passed back to the calling program.

Notice that the stored procedure cannot access the initial value of the 
OUT parameter when it starts.*/

-- stored procedure returns the number of orders by order status.








-- call SP with IN & OUT Parameter



/*
 The stored procedure SetCounter() accepts one INOUT parameter ( counter ) 
 and one IN parameter ( inc ). 
 It increases the counter ( counter ) by the value specified by the inc parameter.*/
 
-- The INOUT parameter 




-- call the SetCounter stored procedure:




-- SP to Get Customer Credit Limit and Increase It




-- Calling the Procedure	

-- Listing Stored Procedures

-- Shows all stored procedures in the current MySQL server:
SHOW PROCEDURE STATUS;

-- lists all stored procedures in the sample database classicmodels:
SHOW PROCEDURE STATUS WHERE db = 'classicmodels';
