---
name: 'erd.instructions'
description: 'Development guidelines and best practices for Erd.Instructions'
keywords: [**erd, components**, erd.instructions, enterprise, **platform, capabilities**, examples**, architecture, database, cases]
---



# **ERD Enterprise Data Modeling & Database Architecture Platform**

## **Platform Overview**

The **ERD Enterprise Data Modeling & Database Architecture Platform** provides comprehensive Entity Relationship Diagram capabilities with advanced data modeling, automated schema generation, database optimization, team collaboration, and enterprise data architecture governance for large-scale database design, data governance, and enterprise data management initiatives.

### **🎯 Primary Capabilities**

- **Advanced Data Modeling**: Complete ERD support with enterprise data modeling patterns and best practices
- **Automated Schema Generation**: Multi-database schema generation with optimization and migration management
- **Data Governance & Compliance**: Automated data privacy compliance, audit trails, and regulatory adherence
- **Team Collaboration Platform**: Real-time collaborative data modeling with review workflows and change management
- **Database Optimization Engine**: Performance analysis, indexing recommendations, and query optimization insights
- **Integration Ecosystem**: Seamless integration with database systems, ORMs, and data management tools

### **🏗️ Architecture Components**

#### **1. ERD Modeling Core Engine**

- **Entity Management**: Comprehensive entity modeling with attributes, constraints, and business rules
- **Relationship Engine**: Complex relationship modeling including inheritance, composition, and aggregation
- **Data Type System**: Advanced data type support with custom types and domain constraints
- **Constraint Framework**: Primary keys, foreign keys, unique constraints, check constraints, and business rules

#### **2. Database Schema Generation**

- **Multi-Database Support**: PostgreSQL, MySQL, SQL Server, Oracle, MongoDB, and NoSQL databases
- **Migration Management**: Automated migration generation, versioning, and rollback capabilities
- **Performance Optimization**: Index recommendations, partitioning strategies, and query optimization
- **Schema Validation**: Comprehensive validation against database-specific constraints and best practices

#### **3. Data Governance Framework**

- **Privacy Compliance**: GDPR, CCPA, HIPAA data classification and privacy impact assessment
- **Data Lineage**: Complete data flow tracking and impact analysis across systems
- **Access Control**: Role-based data access modeling and security constraint generation
- **Audit Framework**: Comprehensive audit trail generation and regulatory reporting capabilities

### **📊 Enterprise Use Cases & Implementation Examples**

#### **Enterprise Customer Data Model**

`See [example-1](./examples/erd/example-1.python)sql
-- Generated PostgreSQL Schema with Enterprise Features
-- Model: Customer Data Platform
-- Generated at: 2024-01-15T10:30:00Z
-- Compliance: GDPR, CCPA, HIPAA

-- Enable required extensions
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_stat_statements";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";

-- Create schema with proper permissions
CREATE SCHEMA IF NOT EXISTS customer_data;
GRANT USAGE ON SCHEMA customer_data TO app_role;
GRANT CREATE ON SCHEMA customer_data TO app_admin;

-- =====================================================
-- Entity: Customer (PII Data - Enhanced Security)
-- =====================================================
CREATE TABLE customer_data.customers (
    -- Primary Key
    customer_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- Business Identifier
    customer_number VARCHAR(20) NOT NULL UNIQUE,

    -- Personal Information (PII - Encrypted)
    first_name VARCHAR(100) NOT NULL,
    last_name VARCHAR(100) NOT NULL,
    email_address VARCHAR(255) NOT NULL UNIQUE,
    phone_number VARCHAR(20),
    date_of_birth DATE,

    -- Address Information (PII)
    address_line1 VARCHAR(255),
    address_line2 VARCHAR(255),
    city VARCHAR(100),
    state_province VARCHAR(50),
    postal_code VARCHAR(20),
    country_code CHAR(2) DEFAULT 'US',

    -- Business Attributes
    customer_type VARCHAR(20) NOT NULL DEFAULT 'INDIVIDUAL'
        CHECK (customer_type IN ('INDIVIDUAL', 'BUSINESS', 'ENTERPRISE')),
    customer_status VARCHAR(20) NOT NULL DEFAULT 'ACTIVE'
        CHECK (customer_status IN ('ACTIVE', 'INACTIVE', 'SUSPENDED', 'CLOSED')),
    credit_limit DECIMAL(15,2) DEFAULT 0.00,
    risk_score INTEGER CHECK (risk_score >= 0 AND risk_score <= 1000),

    -- Compliance and Governance
    consent_marketing BOOLEAN NOT NULL DEFAULT FALSE,
    consent_analytics BOOLEAN NOT NULL DEFAULT FALSE,
    data_retention_date DATE,
    gdpr_consent_date TIMESTAMP WITH TIME ZONE,
    ccpa_opt_out BOOLEAN DEFAULT FALSE,

    -- Audit Fields
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(100) NOT NULL,
    version_number INTEGER NOT NULL DEFAULT 1,

    -- Soft Delete
    deleted_at TIMESTAMP WITH TIME ZONE,
    deleted_by VARCHAR(100)
);

-- Row Level Security for GDPR Compliance
ALTER TABLE customer_data.customers ENABLE ROW LEVEL SECURITY;

-- Policy for data access based on consent
CREATE POLICY customer_data_access ON customer_data.customers
    FOR ALL
    TO app_role
    USING (
        deleted_at IS NULL
        AND (
            current_setting('app.user_role', true) = 'ADMIN'
            OR gdpr_consent_date IS NOT NULL
        )
    );

-- Indexes for Performance Optimization
CREATE INDEX CONCURRENTLY idx_customers_email
    ON customer_data.customers USING btree(email_address)
    WHERE deleted_at IS NULL;

CREATE INDEX CONCURRENTLY idx_customers_customer_number
    ON customer_data.customers USING btree(customer_number)
    WHERE deleted_at IS NULL;

CREATE INDEX CONCURRENTLY idx_customers_status
    ON customer_data.customers USING btree(customer_status)
    WHERE deleted_at IS NULL;

CREATE INDEX CONCURRENTLY idx_customers_created_at
    ON customer_data.customers USING btree(created_at DESC);

-- Performance index for risk analysis
CREATE INDEX CONCURRENTLY idx_customers_risk_score
    ON customer_data.customers USING btree(risk_score DESC)
    WHERE risk_score IS NOT NULL AND deleted_at IS NULL;

-- Full-text search index for customer search
CREATE INDEX CONCURRENTLY idx_customers_fulltext
    ON customer_data.customers USING gin(
        to_tsvector('english',
            COALESCE(first_name, '') || ' ' ||
            COALESCE(last_name, '') || ' ' ||
            COALESCE(email_address, '')
        )
    ) WHERE deleted_at IS NULL;

-- Partial index for active customers
CREATE INDEX CONCURRENTLY idx_customers_active
    ON customer_data.customers USING btree(customer_id)
    WHERE customer_status = 'ACTIVE' AND deleted_at IS NULL;

-- =====================================================
-- Entity: Orders (Business Critical Data)
-- =====================================================
CREATE TABLE customer_data.orders (
    -- Primary Key
    order_id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),

    -- Business Identifier
    order_number VARCHAR(50) NOT NULL UNIQUE,

    -- Foreign Key to Customer
    customer_id UUID NOT NULL REFERENCES customer_data.customers(customer_id)
        ON DELETE RESTRICT ON UPDATE CASCADE,

    -- Order Details
    order_date TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    order_status VARCHAR(20) NOT NULL DEFAULT 'PENDING'
        CHECK (order_status IN ('PENDING', 'CONFIRMED', 'PROCESSING', 'SHIPPED', 'DELIVERED', 'CANCELLED', 'RETURNED')),

    -- Financial Information
    subtotal_amount DECIMAL(15,2) NOT NULL DEFAULT 0.00 CHECK (subtotal_amount >= 0),
    tax_amount DECIMAL(15,2) NOT NULL DEFAULT 0.00 CHECK (tax_amount >= 0),
    shipping_amount DECIMAL(15,2) NOT NULL DEFAULT 0.00 CHECK (shipping_amount >= 0),
    discount_amount DECIMAL(15,2) NOT NULL DEFAULT 0.00 CHECK (discount_amount >= 0),
    total_amount DECIMAL(15,2) GENERATED ALWAYS AS (subtotal_amount + tax_amount + shipping_amount - discount_amount) STORED,

    -- Shipping Information
    shipping_address_line1 VARCHAR(255),
    shipping_address_line2 VARCHAR(255),
    shipping_city VARCHAR(100),
    shipping_state VARCHAR(50),
    shipping_postal_code VARCHAR(20),
    shipping_country VARCHAR(2) DEFAULT 'US',
    shipping_method VARCHAR(50),
    tracking_number VARCHAR(100),

    -- Business Context
    sales_channel VARCHAR(50) NOT NULL DEFAULT 'ONLINE'
        CHECK (sales_channel IN ('ONLINE', 'STORE', 'PHONE', 'MOBILE_APP', 'MARKETPLACE')),
    promotion_code VARCHAR(50),

    -- Dates
    expected_delivery_date DATE,
    actual_delivery_date DATE,

    -- Audit Fields
    created_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    created_by VARCHAR(100) NOT NULL,
    updated_at TIMESTAMP WITH TIME ZONE NOT NULL DEFAULT CURRENT_TIMESTAMP,
    updated_by VARCHAR(100) NOT NULL,
    version_number INTEGER NOT NULL DEFAULT 1,

    -- Soft Delete
    deleted_at TIMESTAMP WITH TIME ZONE,
    deleted_by VARCHAR(100),

    -- Constraints
    CONSTRAINT chk_delivery_dates CHECK (
        expected_delivery_date IS NULL
        OR actual_delivery_date IS NULL
        OR actual_delivery_date >= order_date
    )
);

-- Partitioning for Performance (monthly partitions)
-- This would typically be done during table creation in real implementation
-- CREATE TABLE customer_data.orders (...)
-- PARTITION BY RANGE (order_date);

-- Indexes for Orders
CREATE INDEX CONCURRENTLY idx_orders_customer_id
    ON customer_data.orders USING btree(customer_id)
    WHERE deleted_at IS NULL;

CREATE INDEX CONCURRENTLY idx_orders_order_date
    ON customer_data.orders USING btree(order_date DESC);

CREATE INDEX CONCURRENTLY idx_orders_status
    ON customer_data.orders USING btree(order_status)
    WHERE deleted_at IS NULL;

CREATE INDEX CONCURRENTLY idx_orders_total_amount
    ON customer_data.orders USING btree(total_amount DESC)
    WHERE deleted_at IS NULL;

-- Composite index for common queries
CREATE INDEX CONCURRENTLY idx_orders_customer_date
    ON customer_data.orders USING btree(customer_id, order_date DESC)
    WHERE deleted_at IS NULL;

-- =====================================================
-- Audit Triggers for Compliance
-- =====================================================

-- Function to update the updated_at timestamp
CREATE OR REPLACE FUNCTION customer_data.update_updated_at_column()
RETURNS TRIGGER AS $$
BEGIN
    NEW.updated_at = CURRENT_TIMESTAMP;
    NEW.version_number = OLD.version_number + 1;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Trigger for customers table
CREATE TRIGGER trigger_customers_updated_at
    BEFORE UPDATE ON customer_data.customers
    FOR EACH ROW
    EXECUTE FUNCTION customer_data.update_updated_at_column();

-- Trigger for orders table
CREATE TRIGGER trigger_orders_updated_at
    BEFORE UPDATE ON customer_data.orders
    FOR EACH ROW
    EXECUTE FUNCTION customer_data.update_updated_at_column();

-- =====================================================
-- Data Archival and Retention Policies
-- =====================================================

-- Function to archive old data based on retention policies
CREATE OR REPLACE FUNCTION customer_data.archive_expired_data()
RETURNS INTEGER AS $$
DECLARE
    archived_count INTEGER := 0;
BEGIN
    -- Archive customers with expired retention dates
    UPDATE customer_data.customers
    SET deleted_at = CURRENT_TIMESTAMP,
        deleted_by = 'SYSTEM_ARCHIVAL'
    WHERE data_retention_date IS NOT NULL
      AND data_retention_date < CURRENT_DATE
      AND deleted_at IS NULL;

    GET DIAGNOSTICS archived_count = ROW_COUNT;

*Content optimized for conciseness. See external references for additional details.*

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
