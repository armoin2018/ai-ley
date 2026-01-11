-- Complete e-commerce schema with advanced features
CREATE EXTENSION IF NOT EXISTS "uuid-ossp";
CREATE EXTENSION IF NOT EXISTS "pg_trgm";
CREATE EXTENSION IF NOT EXISTS "btree_gin";

-- Audit table for tracking changes
CREATE TABLE audit_log (
    id BIGSERIAL PRIMARY KEY,
    table_name VARCHAR(50) NOT NULL,
    operation CHAR(1) NOT NULL CHECK (operation IN ('I', 'U', 'D')),
    old_values JSONB,
    new_values JSONB,
    user_id UUID,
    changed_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    session_id VARCHAR(100)
);

-- User management with partitioning
CREATE TABLE users (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    email VARCHAR(255) UNIQUE NOT NULL,
    username VARCHAR(50) UNIQUE NOT NULL,
    password_hash VARCHAR(255) NOT NULL,
    first_name VARCHAR(100),
    last_name VARCHAR(100),
    date_of_birth DATE,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    last_login TIMESTAMP WITH TIME ZONE,
    is_active BOOLEAN DEFAULT true,
    email_verified BOOLEAN DEFAULT false,
    profile_data JSONB DEFAULT '{}',
    preferences JSONB DEFAULT '{}',
    search_vector tsvector GENERATED ALWAYS AS (
        to_tsvector('english',
            COALESCE(first_name, '') || ' ' ||
            COALESCE(last_name, '') || ' ' ||
            COALESCE(username, '')
        )
    ) STORED
) PARTITION BY RANGE (created_at);

-- Create partitions for users by year
CREATE TABLE users_2024 PARTITION OF users
    FOR VALUES FROM ('2024-01-01') TO ('2025-01-01');
CREATE TABLE users_2025 PARTITION OF users
    FOR VALUES FROM ('2025-01-01') TO ('2026-01-01');

-- Products with hierarchical categories
CREATE TABLE categories (
    id SERIAL PRIMARY KEY,
    name VARCHAR(100) NOT NULL,
    slug VARCHAR(100) UNIQUE NOT NULL,
    parent_id INTEGER REFERENCES categories(id),
    path LTREE,
    level INTEGER GENERATED ALWAYS AS (nlevel(path)) STORED,
    description TEXT,
    is_active BOOLEAN DEFAULT true,
    display_order INTEGER DEFAULT 0,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

CREATE TABLE products (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    sku VARCHAR(100) UNIQUE NOT NULL,
    name VARCHAR(255) NOT NULL,
    slug VARCHAR(255) UNIQUE NOT NULL,
    description TEXT,
    short_description VARCHAR(500),
    category_id INTEGER REFERENCES categories(id),
    brand VARCHAR(100),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    compare_at_price DECIMAL(10,2) CHECK (compare_at_price >= price),
    cost DECIMAL(10,2) CHECK (cost >= 0),
    weight DECIMAL(8,3),
    dimensions JSONB, -- {length: x, width: y, height: z, unit: "cm"}
    inventory_quantity INTEGER DEFAULT 0 CHECK (inventory_quantity >= 0),
    track_inventory BOOLEAN DEFAULT true,
    allow_backorder BOOLEAN DEFAULT false,
    status VARCHAR(20) DEFAULT 'draft' CHECK (status IN ('draft', 'active', 'archived')),
    tags TEXT[] DEFAULT '{}',
    attributes JSONB DEFAULT '{}', -- Color, size, material, etc.
    seo_data JSONB DEFAULT '{}', -- SEO title, description, keywords
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    published_at TIMESTAMP WITH TIME ZONE,
    search_vector tsvector GENERATED ALWAYS AS (
        setweight(to_tsvector('english', COALESCE(name, '')), 'A') ||
        setweight(to_tsvector('english', COALESCE(description, '')), 'B') ||
        setweight(to_tsvector('english', COALESCE(brand, '')), 'C') ||
        setweight(to_tsvector('english', array_to_string(tags, ' ')), 'D')
    ) STORED
);

-- Product variants for size, color, etc.
CREATE TABLE product_variants (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    product_id UUID NOT NULL REFERENCES products(id) ON DELETE CASCADE,
    sku VARCHAR(100) UNIQUE NOT NULL,
    title VARCHAR(255),
    price DECIMAL(10,2),
    compare_at_price DECIMAL(10,2),
    cost DECIMAL(10,2),
    inventory_quantity INTEGER DEFAULT 0,
    weight DECIMAL(8,3),
    barcode VARCHAR(100),
    option1 VARCHAR(100), -- Size
    option2 VARCHAR(100), -- Color
    option3 VARCHAR(100), -- Material
    image_url TEXT,
    position INTEGER DEFAULT 1,
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Orders with complex state management
CREATE TYPE order_status AS ENUM (
    'pending', 'confirmed', 'processing', 'shipped',
    'delivered', 'cancelled', 'refunded', 'returned'
);

CREATE TABLE orders (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_number VARCHAR(50) UNIQUE NOT NULL,
    user_id UUID REFERENCES users(id),
    email VARCHAR(255) NOT NULL,
    status order_status DEFAULT 'pending',
    financial_status VARCHAR(20) DEFAULT 'pending',
    fulfillment_status VARCHAR(20) DEFAULT 'unfulfilled',

    -- Pricing
    subtotal_price DECIMAL(10,2) NOT NULL DEFAULT 0,
    tax_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    shipping_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    discount_amount DECIMAL(10,2) NOT NULL DEFAULT 0,
    total_price DECIMAL(10,2) NOT NULL DEFAULT 0,

    -- Addresses (stored as JSONB for flexibility)
    billing_address JSONB NOT NULL,
    shipping_address JSONB NOT NULL,

    -- Metadata
    notes TEXT,
    internal_notes TEXT,
    tags TEXT[] DEFAULT '{}',
    source_name VARCHAR(50) DEFAULT 'web',
    referring_site VARCHAR(255),

    -- Timestamps
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    updated_at TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    processed_at TIMESTAMP WITH TIME ZONE,
    shipped_at TIMESTAMP WITH TIME ZONE,
    delivered_at TIMESTAMP WITH TIME ZONE,

    CONSTRAINT positive_amounts CHECK (
        subtotal_price >= 0 AND tax_amount >= 0 AND
        shipping_amount >= 0 AND discount_amount >= 0 AND total_price >= 0
    )
) PARTITION BY RANGE (created_at);

-- Order partitions by month for better performance
CREATE TABLE orders_2024_12 PARTITION OF orders
    FOR VALUES FROM ('2024-12-01') TO ('2025-01-01');
CREATE TABLE orders_2025_01 PARTITION OF orders
    FOR VALUES FROM ('2025-01-01') TO ('2025-02-01');

-- Order line items
CREATE TABLE order_items (
    id UUID PRIMARY KEY DEFAULT uuid_generate_v4(),
    order_id UUID NOT NULL REFERENCES orders(id) ON DELETE CASCADE,
    product_id UUID REFERENCES products(id),
    variant_id UUID REFERENCES product_variants(id),
    quantity INTEGER NOT NULL CHECK (quantity > 0),
    price DECIMAL(10,2) NOT NULL CHECK (price >= 0),
    total_discount DECIMAL(10,2) DEFAULT 0 CHECK (total_discount >= 0),
    product_snapshot JSONB NOT NULL, -- Store product data at time of order
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
) PARTITION BY RANGE (created_at);

-- Inventory tracking with detailed logging
CREATE TABLE inventory_adjustments (
    id BIGSERIAL PRIMARY KEY,
    product_id UUID REFERENCES products(id),
    variant_id UUID REFERENCES product_variants(id),
    adjustment_type VARCHAR(20) NOT NULL CHECK (adjustment_type IN ('sale', 'return', 'adjustment', 'restock')),
    quantity_change INTEGER NOT NULL,
    reason VARCHAR(255),
    reference_id UUID, -- Order ID, return ID, etc.
    user_id UUID REFERENCES users(id),
    created_at TIMESTAMP WITH TIME ZONE DEFAULT NOW()
);

-- Performance indexes
CREATE INDEX idx_users_email_active ON users(email) WHERE is_active = true;
CREATE INDEX idx_users_search ON users USING gin(search_vector);
CREATE INDEX idx_users_created_at ON users(created_at);

CREATE INDEX idx_products_category ON products(category_id);
CREATE INDEX idx_products_status_published ON products(status, published_at) WHERE published_at IS NOT NULL;
CREATE INDEX idx_products_search ON products USING gin(search_vector);
CREATE INDEX idx_products_price_range ON products(price) WHERE status = 'active';
CREATE INDEX idx_products_tags ON products USING gin(tags);

CREATE INDEX idx_product_variants_product ON product_variants(product_id);
CREATE INDEX idx_product_variants_sku ON product_variants(sku);

CREATE INDEX idx_orders_user ON orders(user_id);
CREATE INDEX idx_orders_status ON orders(status);
CREATE INDEX idx_orders_created_at ON orders(created_at);
CREATE INDEX idx_orders_order_number ON orders(order_number);

CREATE INDEX idx_order_items_order ON order_items(order_id);
CREATE INDEX idx_order_items_product ON order_items(product_id);

-- Audit triggers
CREATE OR REPLACE FUNCTION audit_trigger_function()
RETURNS TRIGGER AS $$
BEGIN
    IF TG_OP = 'DELETE' THEN
        INSERT INTO audit_log (table_name, operation, old_values, user_id, session_id)
        VALUES (TG_TABLE_NAME, 'D', row_to_json(OLD),
                COALESCE(current_setting('app.current_user_id', true)::UUID, NULL),
                current_setting('app.session_id', true));
        RETURN OLD;
    ELSIF TG_OP = 'UPDATE' THEN
        INSERT INTO audit_log (table_name, operation, old_values, new_values, user_id, session_id)
        VALUES (TG_TABLE_NAME, 'U', row_to_json(OLD), row_to_json(NEW),
                COALESCE(current_setting('app.current_user_id', true)::UUID, NULL),
                current_setting('app.session_id', true));
        RETURN NEW;
    ELSIF TG_OP = 'INSERT' THEN
        INSERT INTO audit_log (table_name, operation, new_values, user_id, session_id)
        VALUES (TG_TABLE_NAME, 'I', row_to_json(NEW),
                COALESCE(current_setting('app.current_user_id', true)::UUID, NULL),
                current_setting('app.session_id', true));
        RETURN NEW;
    END IF;
    RETURN NULL;
END;
$$ LANGUAGE plpgsql;

-- Apply audit triggers to important tables
CREATE TRIGGER users_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON users
    FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();

CREATE TRIGGER orders_audit_trigger
    AFTER INSERT OR UPDATE OR DELETE ON orders
    FOR EACH ROW EXECUTE FUNCTION audit_trigger_function();