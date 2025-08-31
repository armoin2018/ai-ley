# Oracle Database Instructions

## Tool Overview
- **Tool Name**: Oracle Database
- **Version**: 19c+ (Latest LTS)
- **Category**: Enterprise Relational Database
- **Purpose**: High-performance, scalable database for enterprise applications
- **Prerequisites**: Oracle client libraries, appropriate licensing

## Installation & Setup

### Oracle Client Installation
```bash
# Download Oracle Instant Client
# For Ubuntu/Debian
wget https://download.oracle.com/otn_software/linux/instantclient/oracle-instantclient-basic.deb
sudo dpkg -i oracle-instantclient-basic.deb

# Python driver
pip install cx_Oracle

# Alternative Python driver
pip install oracledb
```

### Environment Configuration
```bash
# Set Oracle environment variables
export ORACLE_HOME=/opt/oracle/instantclient
export LD_LIBRARY_PATH=$ORACLE_HOME:$LD_LIBRARY_PATH
export PATH=$ORACLE_HOME:$PATH
```

## Configuration

### Connection Configuration
```python
# Python connection with cx_Oracle
import cx_Oracle

# Connection string format
dsn = cx_Oracle.makedsn("hostname", 1521, service_name="ORCL")
connection = cx_Oracle.connect(
    user="username",
    password="password",
    dsn=dsn,
    encoding="UTF-8"
)

# Connection pool for better performance
pool = cx_Oracle.SessionPool(
    user="username",
    password="password",
    dsn=dsn,
    min=2,
    max=10,
    increment=1,
    encoding="UTF-8"
)
```

## Core Features

### Schema and Object Management
```sql
-- Create tablespace
CREATE TABLESPACE app_data
DATAFILE '/path/to/app_data01.dbf'
SIZE 100M
AUTOEXTEND ON;

-- Create user/schema
CREATE USER app_user IDENTIFIED BY password
DEFAULT TABLESPACE app_data;

GRANT CREATE SESSION, CREATE TABLE TO app_user;

-- Create tables with Oracle-specific features
CREATE TABLE employees (
    employee_id NUMBER(10) PRIMARY KEY,
    first_name VARCHAR2(50) NOT NULL,
    last_name VARCHAR2(50) NOT NULL,
    email VARCHAR2(100) UNIQUE,
    hire_date DATE DEFAULT SYSDATE,
    salary NUMBER(10,2) CHECK (salary > 0)
);

-- Create sequence for primary keys
CREATE SEQUENCE emp_seq
START WITH 1
INCREMENT BY 1
CACHE 20;
```

### Advanced Query Features
```sql
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
```

### PL/SQL Programming
```sql
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
```

## Common Commands
```sql
-- Essential daily commands
SELECT * FROM user_tables;              -- List user tables
DESC table_name;                        -- Describe table structure
SELECT * FROM user_sequences;          -- List sequences
SELECT * FROM user_indexes;            -- List indexes

-- System queries
SELECT * FROM v$version;               -- Oracle version
SELECT * FROM v$instance;             -- Instance information
SELECT * FROM user_tab_privs;          -- User privileges
```

## Best Practices

### Performance Optimization
- Use bind variables to prevent SQL injection and improve performance
- Implement proper indexing strategies
- Use Oracle optimizer hints when necessary
- Monitor and tune SQL execution plans

### Index Strategy
```sql
-- B-tree indexes for equality and range queries
CREATE INDEX idx_emp_last_name ON employees(last_name);

-- Composite indexes for multi-column queries
CREATE INDEX idx_emp_dept_salary ON employees(department_id, salary);

-- Function-based indexes
CREATE INDEX idx_emp_upper_email ON employees(UPPER(email));
```

## Common Use Cases

### Enterprise Application Backend
```python
# Python application with Oracle
import cx_Oracle
from contextlib import contextmanager

class OracleManager:
    def __init__(self, connection_string):
        self.connection_string = connection_string
        self.pool = self.create_connection_pool()
    
    def create_connection_pool(self):
        return cx_Oracle.SessionPool(
            self.connection_string,
            min=2,
            max=10,
            increment=1,
            encoding="UTF-8"
        )
    
    @contextmanager
    def get_connection(self):
        connection = self.pool.acquire()
        try:
            yield connection
        except Exception as e:
            connection.rollback()
            raise
        else:
            connection.commit()
        finally:
            self.pool.release(connection)
```

## Security Considerations

### User Management and Privileges
```sql
-- Create application user with minimal privileges
CREATE USER app_user IDENTIFIED BY secure_password;
GRANT CREATE SESSION TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON hr.employees TO app_user;

-- Create role for grouped privileges
CREATE ROLE hr_reader;
GRANT SELECT ON hr.employees TO hr_reader;
GRANT hr_reader TO app_user;
```

## Troubleshooting

### Common Issues
#### Issue 1: ORA-00942 Table or View Does Not Exist
**Problem**: Table access permissions or wrong schema
**Solution**: Grant appropriate privileges and check schema references

#### Issue 2: Performance Issues
**Problem**: Slow query execution
**Solution**: Analyze execution plans and optimize indexes

```sql
-- Check execution plan
EXPLAIN PLAN FOR
SELECT * FROM employees WHERE department_id = 10;

SELECT * FROM TABLE(DBMS_XPLAN.DISPLAY);
```

## AI Assistant Guidelines
When helping with Oracle Database implementation:

1. **Always use bind variables** to prevent SQL injection and improve performance
2. **Leverage Oracle-specific features** like analytical functions and hierarchical queries
3. **Include proper exception handling** in PL/SQL code
4. **Recommend connection pooling** for application scalability
5. **Suggest appropriate indexing strategies** based on query patterns
6. **Include security best practices** for user management and data protection
7. **Provide performance optimization** guidance
8. **Reference Oracle documentation** for specific features and syntax

### Code Generation Rules
- Generate parameterized queries with proper bind variables
- Include comprehensive error handling for PL/SQL procedures
- Follow Oracle naming conventions and coding standards
- Implement proper transaction management
- Use Oracle-specific data types and features appropriately
- Include performance considerations in query design
- Generate secure, privilege-based access patterns