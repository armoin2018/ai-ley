-- Stored procedure
CREATE OR REPLACE PROCEDURE update_employee_salary(
    p_employee_id IN NUMBER,
    p_percentage IN NUMBER,
    p_result OUT VARCHAR2
) AS
    v_current_salary NUMBER;
    v_new_salary NUMBER;
BEGIN
    SELECT salary INTO v_current_salary
    FROM employees
    WHERE employee_id = p_employee_id;

    v_new_salary := v_current_salary * (1 + p_percentage/100);

    UPDATE employees
    SET salary = v_new_salary
    WHERE employee_id = p_employee_id;

    p_result := 'Salary updated from ' || v_current_salary || ' to ' || v_new_salary;

    COMMIT;
EXCEPTION
    WHEN NO_DATA_FOUND THEN
        p_result := 'Employee not found';
        ROLLBACK;
    WHEN OTHERS THEN
        p_result := 'Error: ' || SQLERRM;
        ROLLBACK;
END;
/