#Functions in MySQL
/*
A stored function is a specialized type of stored program designed to return a single value. 
Typically, you use stored functions to encapsulate common formulas or business rules, 
making them reusable across SQL statements or other stored programs.

Unlike a stored procedure, you can use a stored function in SQL statements wherever you use an expression. 
This enhances the readability and maintainability of the procedural code.

*/

/*
DELIMITER $$

CREATE FUNCTION function_name(
    param1,
    param2,…
)
RETURNS datatype
[NOT] DETERMINISTIC
BEGIN
 -- statements
END $$

DELIMITER ;

A deterministic function always returns the same result for the same input parameters, 
while a non-deterministic function produces different results for the same input parameters.

If you don’t use DETERMINISTIC or NOT DETERMINISTIC, MySQL defaults to the NOT DETERMINISTIC option.

*/

/*
CREATE FUNCTION statement creates a function that returns the customer level based on credit
*/

DELIMITER $$

CREATE FUNCTION CustomerLevel(
	credit DECIMAL(10,2)
) 
RETURNS VARCHAR(20)
DETERMINISTIC
BEGIN
    DECLARE customerLevel VARCHAR(20);

    IF credit > 50000 THEN
		SET customerLevel = 'PLATINUM';
    ELSEIF (credit >= 50000 AND 
			credit <= 10000) THEN
        SET customerLevel = 'GOLD';
    ELSEIF credit < 10000 THEN
        SET customerLevel = 'SILVER';
    END IF;
	-- return the customer level
	RETURN (customerLevel);
END$$

DELIMITER ;

SHOW FUNCTION STATUS WHERE db = 'classicmodels';


-- Calling a stored function in an SQL statement 

SELECT 
    customerName, 
    CustomerLevel(creditLimit)
FROM
    customers
ORDER BY 
    customerName;

-- Function to get FullName
DELIMITER $$
CREATE FUNCTION get_employee_name(p_employeeNumber INT)
RETURNS VARCHAR(100) DETERMINISTIC

BEGIN
DECLARE v_name VARCHAR(100);
SELECT CONCAT(firstName, ' ', lastName)
INTO v_name
FROM employees
WHERE employeeNumber = p_employeeNumber;

RETURN v_name;

END$$
DELIMITER ;

-- call functions
SELECT employeeNumber,
get_employee_name(employeeNumber) AS employee_name
FROM employees;


--- Function for EMI calculation 

DELIMITER $$

CREATE FUNCTION calculate_emi(
    p_amount DECIMAL(15,2),
    p_annual_rate DECIMAL(5,2),
    p_months INT
)
RETURNS DECIMAL(15,2)
DETERMINISTIC
BEGIN
    DECLARE v_monthly_rate DECIMAL(15,10);
    DECLARE v_emi DECIMAL(15,2);

    -- Convert annual interest rate to monthly rate
    SET v_monthly_rate = p_annual_rate / 12 / 100;

    -- Calculate EMI
    SET v_emi =
        p_amount * v_monthly_rate *
        POW(1 + v_monthly_rate, p_months)
        /
        (POW(1 + v_monthly_rate, p_months) - 1);

    RETURN ROUND(v_emi, 2);
END$$
DELIMITER ;

-- call function

SELECT calculate_emi(500000, 8.5, 60) AS EMI;


/*
A stored function is a reusable and encapsulated piece of code in a database that performs a specific task and returns a single value.
Use the CREATE FUNCTION statement to create a stored function.
Use stored functions to enhance the modularity and efficiency of SQL statements.
*/