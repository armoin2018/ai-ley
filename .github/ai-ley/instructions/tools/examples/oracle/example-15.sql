-- Create application user with minimal privileges
CREATE USER app_user IDENTIFIED BY secure_password;
GRANT CREATE SESSION TO app_user;
GRANT SELECT, INSERT, UPDATE, DELETE ON hr.employees TO app_user;

-- Create role for grouped privileges
CREATE ROLE hr_reader;
GRANT SELECT ON hr.employees TO hr_reader;
GRANT hr_reader TO app_user;