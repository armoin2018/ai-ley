-- Data classification and governance
CREATE TABLE data_governance.data_classification (
    table_name VARCHAR(255) PRIMARY KEY,
    schema_name VARCHAR(255) NOT NULL,
    classification ENUM('public', 'internal', 'confidential', 'restricted'),
    retention_period INTERVAL,
    compliance_requirements TEXT[],
    data_owner VARCHAR(255),
    created_at TIMESTAMP DEFAULT NOW()
);

-- Audit trail table
CREATE TABLE data_governance.audit_log (
    id BIGSERIAL PRIMARY KEY,
    table_name VARCHAR(255) NOT NULL,
    operation VARCHAR(50) NOT NULL,
    user_id VARCHAR(255) NOT NULL,
    old_values JSONB,
    new_values JSONB,
    timestamp TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    ip_address INET,
    application VARCHAR(255)
);

-- Data quality monitoring
CREATE TABLE data_governance.quality_checks (
    id SERIAL PRIMARY KEY,
    table_name VARCHAR(255) NOT NULL,
    column_name VARCHAR(255),
    check_type VARCHAR(100) NOT NULL,
    check_rule TEXT NOT NULL,
    threshold_value NUMERIC,
    last_run TIMESTAMP,
    status VARCHAR(50),
    error_count BIGINT DEFAULT 0
);