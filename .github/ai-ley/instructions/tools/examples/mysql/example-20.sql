-- Principle of least privilege
CREATE USER 'app_read'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT ON myapp.* TO 'app_read'@'localhost';

CREATE USER 'app_write'@'localhost' IDENTIFIED BY 'secure_password';
GRANT SELECT, INSERT, UPDATE, DELETE ON myapp.* TO 'app_write'@'localhost';

-- Revoke dangerous privileges
REVOKE FILE, PROCESS, SUPER ON *.* FROM 'app_user'@'localhost';

-- Regular security audit
SELECT user, host, account_locked, password_expired
FROM mysql.user;

-- Remove unused accounts
DROP USER 'unused_user'@'localhost';