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