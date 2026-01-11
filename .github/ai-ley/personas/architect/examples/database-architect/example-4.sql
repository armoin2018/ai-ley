-- Tenant isolation with row-level security
CREATE SCHEMA IF NOT EXISTS tenant_data;

CREATE TABLE tenant_data.organizations (
    id UUID PRIMARY KEY DEFAULT gen_random_uuid(),
    tenant_id UUID NOT NULL,
    name VARCHAR(255) NOT NULL,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Row-level security policy
CREATE POLICY tenant_isolation_policy ON tenant_data.organizations
    FOR ALL TO application_role
    USING (tenant_id = current_setting('app.current_tenant_id')::UUID);

ALTER TABLE tenant_data.organizations ENABLE ROW LEVEL SECURITY;

-- Indexes for performance
CREATE INDEX CONCURRENTLY idx_organizations_tenant_id 
    ON tenant_data.organizations (tenant_id);
CREATE INDEX CONCURRENTLY idx_organizations_name_tenant 
    ON tenant_data.organizations (tenant_id, name);