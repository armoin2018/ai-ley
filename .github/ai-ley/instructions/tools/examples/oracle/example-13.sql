-- B-tree indexes for equality and range queries
CREATE INDEX idx_emp_last_name ON employees(last_name);

-- Composite indexes for multi-column queries
CREATE INDEX idx_emp_dept_salary ON employees(department_id, salary);

-- Function-based indexes
CREATE INDEX idx_emp_upper_email ON employees(UPPER(email));