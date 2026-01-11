-- Enable encryption at rest (configure in postgresql.conf)
tls_cert_file = 'server.crt'
tls_key_file = 'server.key'
tls_ca_file = 'ca.crt'

-- Application-level encryption
CREATE EXTENSION IF NOT EXISTS pgcrypto;

-- Hash passwords
INSERT INTO users (email, password_hash)
VALUES ('user@example.com', crypt('password', gen_salt('bf', 12)));

-- Encrypt sensitive data
UPDATE users SET
    encrypted_ssn = pgp_sym_encrypt(ssn, 'encryption_key')
WHERE id = 1;