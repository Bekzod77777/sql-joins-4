-- FUNCTIONS --

--! 1-Example !--
CREATE OR REPLACE FUNCTION CalculateSum(a int, b int)
RETURNS int AS $$
BEGIN 
    RETURN a + b;
END;
$$ LANGUAGE plpgsql;

SELECT CalculateSum(4, 5);

--! 2-Example !--
CREATE OR REPLACE FUNCTION GetTopPaidEmployees(n int)
RETURNS TABLE (employee_id int, employee_name text, salary numeric) AS $$
BEGIN
    RETURN Query
    SELECT employee_id, employee_name, salary
    FROM employees
    ORDER BY salary DESC
    LIMIT n;
END;
$$ LANGUAGE plpgsql

SELECT * FROM GetTopPaidEmployees(5);


-- PROSEDURA --

--! 1-Example !--
CREATE OR REPLACE PROCEDURE updateEmployeeSalary(
    IN employee_id int,
    IN new_salary numeric
)
LANGUAGE plpgsql AS $$
BEGIN
    UPDATE employees
    SET salary = new_salary
    WHERE id = employee_id

    COMMIT;
END;
$$;

CALL updateEmployeeSalary(123, 50000);

--! 2-Example !--
CREATE OR REPLACE PROCEDURE CalculateAvarageSalary(
    IN department_id int,
    OUT avarage_salary numeric
)
LANGUAGE plpgsql AS $$
BEGIN
    SELECT AVG(salary) INTO avarage_salary
    FROM employees
    WHERE department_id = department_id
END;
$$;

CALL CalculateAvarageSalary(123, avarage_salary);