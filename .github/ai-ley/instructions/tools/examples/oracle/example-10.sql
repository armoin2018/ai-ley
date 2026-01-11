-- Analytical functions
SELECT
    employee_id,
    first_name,
    last_name,
    salary,
    RANK() OVER (PARTITION BY department_id ORDER BY salary DESC) as salary_rank,
    LAG(salary) OVER (PARTITION BY department_id ORDER BY hire_date) as prev_salary
FROM employees;

-- Hierarchical queries
SELECT
    LEVEL,
    employee_id,
    first_name || ' ' || last_name as full_name,
    manager_id
FROM employees
START WITH manager_id IS NULL
CONNECT BY PRIOR employee_id = manager_id
ORDER SIBLINGS BY last_name;