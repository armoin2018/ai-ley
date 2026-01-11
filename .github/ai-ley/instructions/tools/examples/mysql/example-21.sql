-- Enable encryption at rest (MySQL 8.0+)
-- In my.cnf:
-- early-plugin-load=keyring_file.so
-- keyring_file_data=/var/lib/mysql-keyring/keyring

-- Create encrypted table
CREATE TABLE sensitive_data (
    id INT AUTO_INCREMENT PRIMARY KEY,
    ssn VARBINARY(255),
    credit_card_hash VARCHAR(64),
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP
) ENCRYPTION='Y';

-- Application-level encryption functions
SELECT AES_ENCRYPT('sensitive_data', 'encryption_key') as encrypted;
SELECT AES_DECRYPT(encrypted_column, 'encryption_key') as decrypted
FROM sensitive_data;