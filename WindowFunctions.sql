/* ============================================================
   MYSQL WINDOW FUNCTIONS - LAB GUIDE
   Domain  : Employee Management
   Database: window_lab
   ============================================================ */


/* ============================================================
   1. CREATE DATABASE
   ============================================================ */

DROP DATABASE IF EXISTS window_lab;

CREATE DATABASE window_lab;

USE window_lab;


/* ============================================================
   2. CREATE EMPLOYEE TABLE
   ============================================================ */

CREATE TABLE employee (
    emp_id INT PRIMARY KEY,
    emp_name VARCHAR(50),
    department VARCHAR(30),
    job_title VARCHAR(50),
    salary DECIMAL(10,2),
    joining_date DATE
);


/* ============================================================
   3. INSERT SAMPLE DATA
   ============================================================ */

INSERT INTO employee
(emp_id, emp_name, department, job_title, salary, joining_date)
VALUES
(101, 'Rahul',  'IT',      'Developer',        60000,  '2021-01-15'),
(102, 'Priya',  'IT',      'Senior Developer', 85000,  '2020-06-10'),
(103, 'Arun',   'IT',      'Tester',           55000,  '2022-03-20'),
(104, 'Sneha',  'IT',      'Architect',       120000,  '2019-02-12'),

(105, 'Kiran',  'HR',      'HR Executive',     50000,  '2021-07-10'),
(106, 'Anita',  'HR',      'HR Manager',        90000,  '2018-05-15'),
(107, 'Vijay',  'HR',      'Recruiter',         55000,  '2022-01-20'),

(108, 'Ramesh', 'Finance', 'Accountant',        60000,  '2020-09-12'),
(109, 'Divya',  'Finance', 'Finance Manager',   95000,  '2017-04-18'),
(110, 'Suresh', 'Finance', 'Analyst',           70000,  '2021-11-05');


/* ============================================================
   4. VIEW ORIGINAL DATA
   ============================================================ */

SELECT *
FROM employee;


/* ============================================================
   WINDOW FUNCTIONS - BASIC CONCEPT
   ============================================================

   Definition:
   A window function performs a calculation across a set of
   related rows while keeping the individual rows in the result.

   General Syntax:

   FUNCTION_NAME(expression)
   OVER (
       [PARTITION BY column]
       [ORDER BY column]
       [ROWS/RANGE window_frame]
   );

   Important:
   Unlike GROUP BY, window functions do NOT combine multiple
   rows into a single result row.

   ============================================================ */


/* ============================================================
   5. ROW_NUMBER()
   ============================================================

   Function Name:
   ROW_NUMBER()

   Definition:
   Assigns a unique sequential number to every row.

   Usage:
   - Generate serial numbers
   - Find top N records
   - Find latest record
   - Remove duplicates

   Syntax:

   ROW_NUMBER() OVER (
       [PARTITION BY column]
       ORDER BY column
   );

   ============================================================ */

SELECT
    emp_id,
    emp_name,
    department,
    salary,

    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS row_number

FROM employee;


/* ============================================================
   6. ROW_NUMBER() WITH PARTITION BY
   ============================================================

   PARTITION BY divides the rows into logical groups.

   Here, employees are numbered separately within each
   department.

   ============================================================ */

SELECT
    emp_id,
    emp_name,
    department,
    salary,

    ROW_NUMBER() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_row_number

FROM employee;


/* ============================================================
   7. RANK()
   ============================================================

   Function Name:
   RANK()

   Definition:
   Assigns a rank to each row.

   If two rows have the same value, they receive the same rank.
   The next rank is skipped.

   Example:

   Salary     Rank
   120000       1
   95000        2
   95000        2
   85000        4

   Syntax:

   RANK() OVER (
       [PARTITION BY column]
       ORDER BY column
   );

   ============================================================ */

SELECT
    emp_name,
    department,
    salary,

    RANK() OVER (
        ORDER BY salary DESC
    ) AS salary_rank

FROM employee;


/* ============================================================
   8. DENSE_RANK()
   ============================================================

   Function Name:
   DENSE_RANK()

   Definition:
   Assigns ranks like RANK(), but does NOT skip ranks after
   duplicate values.

   Example:

   Salary     Dense Rank
   120000         1
   95000          2
   95000          2
   85000          3

   Syntax:

   DENSE_RANK() OVER (
       [PARTITION BY column]
       ORDER BY column
   );

   ============================================================ */

SELECT
    emp_name,
    salary,

    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS dense_salary_rank

FROM employee;


/* ============================================================
   9. ROW_NUMBER vs RANK vs DENSE_RANK
   ============================================================

   This is an important demonstration.

   ROW_NUMBER():
       Always produces unique numbers.

   RANK():
       Same rank for ties and skips the next rank.

   DENSE_RANK():
       Same rank for ties but does not skip the next rank.

   ============================================================ */

SELECT
    emp_name,
    salary,

    ROW_NUMBER() OVER (
        ORDER BY salary DESC
    ) AS row_number,

    RANK() OVER (
        ORDER BY salary DESC
    ) AS rank_number,

    DENSE_RANK() OVER (
        ORDER BY salary DESC
    ) AS dense_rank_number

FROM employee;


/* ============================================================
   10. DEPARTMENT-WISE RANKING
   ============================================================ */

SELECT
    emp_name,
    department,
    salary,

    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_rank

FROM employee;


/* ============================================================
   11. NTILE()
   ============================================================

   Function Name:
   NTILE(n)

   Definition:
   Divides the rows into approximately equal-sized groups
   called buckets.

   Usage:
   - Quartiles
   - Salary bands
   - Customer segmentation
   - Performance groups

   Syntax:

   NTILE(number_of_buckets) OVER (
       ORDER BY column
   );

   ============================================================ */

SELECT
    emp_name,
    salary,

    NTILE(4) OVER (
        ORDER BY salary DESC
    ) AS salary_quartile

FROM employee;


/* ============================================================
   12. SUM() AS WINDOW FUNCTION
   ============================================================

   Function Name:
   SUM()

   Definition:
   Calculates the sum of values within a window.

   Usage:
   - Department total
   - Running total
   - Cumulative sales

   Syntax:

   SUM(expression) OVER (
       [PARTITION BY column]
       [ORDER BY column]
   );

   ============================================================ */

SELECT
    emp_name,
    department,
    salary,

    SUM(salary) OVER (
        PARTITION BY department
    ) AS department_total_salary

FROM employee;


/* ============================================================
   13. RUNNING TOTAL
   ============================================================

   A running total calculates the cumulative value from the
   first row up to the current row.

   ============================================================ */

SELECT
    emp_id,
    emp_name,
    salary,

    SUM(salary) OVER (
        ORDER BY emp_id
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND CURRENT ROW
    ) AS running_salary_total

FROM employee;


/* ============================================================
   14. AVG() AS WINDOW FUNCTION
   ============================================================

   Function Name:
   AVG()

   Definition:
   Calculates the average value within a window.

   Usage:
   - Department average salary
   - Average sales
   - Moving average

   Syntax:

   AVG(expression) OVER (
       [PARTITION BY column]
       [ORDER BY column]
   );

   ============================================================ */

SELECT
    emp_name,
    department,
    salary,

    AVG(salary) OVER (
        PARTITION BY department
    ) AS department_average_salary

FROM employee;


/* ============================================================
   15. MIN() AS WINDOW FUNCTION
   ============================================================

   Function Name:
   MIN()

   Definition:
   Returns the minimum value within the window.

   Syntax:

   MIN(expression) OVER (
       [PARTITION BY column]
   );

   ============================================================ */

SELECT
    emp_name,
    department,
    salary,

    MIN(salary) OVER (
        PARTITION BY department
    ) AS minimum_department_salary

FROM employee;


/* ============================================================
   16. MAX() AS WINDOW FUNCTION
   ============================================================

   Function Name:
   MAX()

   Definition:
   Returns the maximum value within the window.

   Syntax:

   MAX(expression) OVER (
       [PARTITION BY column]
   );

   ============================================================ */

SELECT
    emp_name,
    department,
    salary,

    MAX(salary) OVER (
        PARTITION BY department
    ) AS maximum_department_salary

FROM employee;


/* ============================================================
   17. COUNT() AS WINDOW FUNCTION
   ============================================================

   Function Name:
   COUNT()

   Definition:
   Counts rows within the specified window.

   Usage:
   - Number of employees per department
   - Number of orders per customer
   - Number of transactions per account

   Syntax:

   COUNT(*) OVER (
       [PARTITION BY column]
   );

   ============================================================ */

SELECT
    emp_name,
    department,

    COUNT(*) OVER (
        PARTITION BY department
    ) AS employees_in_department

FROM employee;


/* ============================================================
   18. LAG()
   ============================================================

   Function Name:
   LAG()

   Definition:
   Returns a value from a previous row.

   Usage:
   - Compare current value with previous value
   - Salary comparison
   - Monthly sales comparison
   - Previous transaction

   Syntax:

   LAG(
       expression
       [, offset]
       [, default_value]
   )
   OVER (
       ORDER BY column
   );

   ============================================================ */

SELECT
    emp_name,
    salary,

    LAG(salary) OVER (
        ORDER BY salary
    ) AS previous_salary

FROM employee;


/* ============================================================
   19. LAG() - SALARY DIFFERENCE
   ============================================================ */

SELECT
    emp_name,
    salary,

    LAG(salary) OVER (
        ORDER BY salary
    ) AS previous_salary,

    salary -
    LAG(salary) OVER (
        ORDER BY salary
    ) AS salary_difference

FROM employee;


/* ============================================================
   20. LEAD()
   ============================================================

   Function Name:
   LEAD()

   Definition:
   Returns a value from a following/next row.

   Usage:
   - Compare current value with next value
   - Future transaction
   - Next month's sales
   - Next employee salary

   Syntax:

   LEAD(
       expression
       [, offset]
       [, default_value]
   )
   OVER (
       ORDER BY column
   );

   ============================================================ */

SELECT
    emp_name,
    salary,

    LEAD(salary) OVER (
        ORDER BY salary
    ) AS next_salary

FROM employee;


/* ============================================================
   21. LAG() AND LEAD() TOGETHER
   ============================================================ */

SELECT
    emp_name,
    salary,

    LAG(salary) OVER (
        ORDER BY salary
    ) AS previous_salary,

    LEAD(salary) OVER (
        ORDER BY salary
    ) AS next_salary

FROM employee;


/* ============================================================
   22. FIRST_VALUE()
   ============================================================

   Function Name:
   FIRST_VALUE()

   Definition:
   Returns the value from the first row of the window.

   Usage:
   - Highest salary
   - Earliest transaction
   - First purchase
   - First employee

   Syntax:

   FIRST_VALUE(expression)
   OVER (
       [PARTITION BY column]
       ORDER BY column
   );

   ============================================================ */

SELECT
    emp_name,
    department,
    salary,

    FIRST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS highest_department_salary

FROM employee;


/* ============================================================
   23. LAST_VALUE()
   ============================================================

   Function Name:
   LAST_VALUE()

   Definition:
   Returns the value from the last row within the specified
   window frame.

   IMPORTANT:
   LAST_VALUE() should normally be used with an explicit
   window frame when we want the actual last row of the
   complete partition.

   Syntax:

   LAST_VALUE(expression)
   OVER (
       [PARTITION BY column]
       ORDER BY column
       ROWS BETWEEN UNBOUNDED PRECEDING
       AND UNBOUNDED FOLLOWING
   );

   ============================================================ */

SELECT
    emp_name,
    department,
    salary,

    LAST_VALUE(salary) OVER (
        PARTITION BY department
        ORDER BY salary
        ROWS BETWEEN UNBOUNDED PRECEDING
        AND UNBOUNDED FOLLOWING
    ) AS lowest_department_salary

FROM employee;


/* ============================================================
   24. PERCENT_RANK()
   ============================================================

   Function Name:
   PERCENT_RANK()

   Definition:
   Calculates the relative rank of a row.

   Result:
   0 to 1

   Formula:

   (Rank - 1) / (Number of Rows - 1)

   Syntax:

   PERCENT_RANK() OVER (
       ORDER BY column
   );

   ============================================================ */

SELECT
    emp_name,
    salary,

    PERCENT_RANK() OVER (
        ORDER BY salary
    ) AS salary_percent_rank

FROM employee;


/* ============================================================
   25. CUME_DIST()
   ============================================================

   Function Name:
   CUME_DIST()

   Definition:
   Calculates the cumulative distribution of a value.

   Result:
   Greater than 0 and less than or equal to 1.

   Syntax:

   CUME_DIST() OVER (
       ORDER BY column
   );

   ============================================================ */

SELECT
    emp_name,
    salary,

    CUME_DIST() OVER (
        ORDER BY salary
    ) AS cumulative_distribution

FROM employee;


/* ============================================================
   26. MOVING AVERAGE
   ============================================================

   Window Frame:

   ROWS BETWEEN 2 PRECEDING AND CURRENT ROW

   Means:

   Previous 2 rows + Current row

   ============================================================ */

SELECT
    emp_id,
    emp_name,
    salary,

    AVG(salary) OVER (
        ORDER BY emp_id
        ROWS BETWEEN 2 PRECEDING
        AND CURRENT ROW
    ) AS three_row_moving_average

FROM employee;


/* ============================================================
   27. COMBINED DEPARTMENT ANALYSIS
   ============================================================

   Demonstrates multiple window functions in one query.

   ============================================================ */

SELECT
    emp_id,
    emp_name,
    department,
    salary,

    COUNT(*) OVER (
        PARTITION BY department
    ) AS department_employee_count,

    SUM(salary) OVER (
        PARTITION BY department
    ) AS department_total_salary,

    AVG(salary) OVER (
        PARTITION BY department
    ) AS department_average_salary,

    MIN(salary) OVER (
        PARTITION BY department
    ) AS department_min_salary,

    MAX(salary) OVER (
        PARTITION BY department
    ) AS department_max_salary,

    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_salary_rank

FROM employee;


/* ============================================================
   28. ADVANCED EMPLOYEE ANALYSIS
   ============================================================

   Business Requirement:

   Display:

   - Employee
   - Department
   - Salary
   - Department Average
   - Salary Difference from Department Average
   - Department Rank
   - Previous Salary
   - Next Salary

   ============================================================ */

SELECT
    emp_id,
    emp_name,
    department,
    salary,

    ROUND(
        AVG(salary) OVER (
            PARTITION BY department
        ),
        2
    ) AS department_average,

    ROUND(
        salary -
        AVG(salary) OVER (
            PARTITION BY department
        ),
        2
    ) AS difference_from_department_average,

    RANK() OVER (
        PARTITION BY department
        ORDER BY salary DESC
    ) AS department_rank,

    LAG(salary) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS previous_salary,

    LEAD(salary) OVER (
        PARTITION BY department
        ORDER BY salary
    ) AS next_salary

FROM employee;


/* ============================================================
   29. TOP 2 HIGHEST-PAID EMPLOYEES PER DEPARTMENT
   ============================================================

   Important Concept:

   Window functions cannot normally be filtered directly
   in the WHERE clause of the same SELECT.

   Therefore, use a CTE/subquery.

   ============================================================ */

WITH ranked_employees AS (

    SELECT
        emp_id,
        emp_name,
        department,
        salary,

        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS row_num

    FROM employee
)

SELECT
    emp_id,
    emp_name,
    department,
    salary,
    row_num
FROM ranked_employees
WHERE row_num <= 2;


/* ============================================================
   30. HIGHEST-PAID EMPLOYEE IN EACH DEPARTMENT
   ============================================================ */

WITH ranked_employees AS (

    SELECT
        emp_id,
        emp_name,
        department,
        salary,

        ROW_NUMBER() OVER (
            PARTITION BY department
            ORDER BY salary DESC
        ) AS row_num

    FROM employee
)

SELECT
    emp_id,
    emp_name,
    department,
    salary
FROM ranked_employees
WHERE row_num = 1;


/* ============================================================
   31. WINDOW FUNCTION CHEAT SHEET
   ============================================================

   ROW_NUMBER()
   -------------------------
   Purpose:
   Unique sequential number

   Syntax:
   ROW_NUMBER() OVER (
       ORDER BY column
   );


   RANK()
   -------------------------
   Purpose:
   Ranking with gaps

   Syntax:
   RANK() OVER (
       ORDER BY column
   );


   DENSE_RANK()
   -------------------------
   Purpose:
   Ranking without gaps

   Syntax:
   DENSE_RANK() OVER (
       ORDER BY column
   );


   NTILE()
   -------------------------
   Purpose:
   Divide rows into buckets

   Syntax:
   NTILE(4) OVER (
       ORDER BY column
   );


   LAG()
   -------------------------
   Purpose:
   Access previous row

   Syntax:
   LAG(column) OVER (
       ORDER BY column
   );


   LEAD()
   -------------------------
   Purpose:
   Access next row

   Syntax:
   LEAD(column) OVER (
       ORDER BY column
   );


   FIRST_VALUE()
   -------------------------
   Purpose:
   First value in window

   Syntax:
   FIRST_VALUE(column) OVER (
       ORDER BY column
   );


   LAST_VALUE()
   -------------------------
   Purpose:
   Last value in specified window frame

   Syntax:
   LAST_VALUE(column) OVER (
       ORDER BY column
       ROWS BETWEEN UNBOUNDED PRECEDING
       AND UNBOUNDED FOLLOWING
   );


   SUM()
   -------------------------
   Purpose:
   Windowed sum / running total

   Syntax:
   SUM(column) OVER (
       PARTITION BY column
       ORDER BY column
   );


   AVG()
   -------------------------
   Purpose:
   Windowed average

   Syntax:
   AVG(column) OVER (
       PARTITION BY column
   );


   MIN()
   -------------------------
   Purpose:
   Minimum value in window

   Syntax:
   MIN(column) OVER (
       PARTITION BY column
   );


   MAX()
   -------------------------
   Purpose:
   Maximum value in window

   Syntax:
   MAX(column) OVER (
       PARTITION BY column
   );


   COUNT()
   -------------------------
   Purpose:
   Count rows in window

   Syntax:
   COUNT(*) OVER (
       PARTITION BY column
   );


   PERCENT_RANK()
   -------------------------
   Purpose:
   Relative ranking between 0 and 1

   Syntax:
   PERCENT_RANK() OVER (
       ORDER BY column
   );


   CUME_DIST()
   -------------------------
   Purpose:
   Cumulative distribution

   Syntax:
   CUME_DIST() OVER (
       ORDER BY column
   );

   ============================================================ */


/* ============================================================
   32. IMPORTANT WINDOW FUNCTION CONCEPTS
   ============================================================

   OVER()
       Defines the window.

   PARTITION BY
       Divides rows into logical groups.

   ORDER BY
       Defines the order within the window.

   ROWS
       Defines a physical row-based window.

   RANGE
       Defines a value-based window.

   UNBOUNDED PRECEDING
       Starts from the first row.

   CURRENT ROW
       Refers to the current row.

   UNBOUNDED FOLLOWING
       Extends to the last row.

   ============================================================ */


/* ============================================================
   END OF MYSQL WINDOW FUNCTIONS LAB
   ============================================================ */