---
name: 'SQLite Embedded Database Instructions'
description: 'SQLite embedded database implementation guide covering lightweight database operations, file-based storage, performance optimization, integration patterns, production deployment strategies, and advanced troubleshooting for applications requiring zero-configuration database solutions.'
keywords: [deployment, desktop, agent, applications, docker, architecture, configuration, database, avoid, cli]
---


# SQLite Database Instructions

## AI Agent Implementation Guide

### Purpose

Provide comprehensive guidance for AI agents implementing SQLite solutions, emphasizing embedded database patterns, zero-configuration deployment, lightweight application integration, production deployment strategies, and advanced troubleshooting.

### When to Use SQLite

- **Embedded applications** requiring zero-configuration database
- **Desktop applications** with local data storage needs
- **Mobile applications** for on-device data persistence
- **Prototyping and development** for quick database setup
- **Small to medium datasets** (< 1TB) with simple concurrency needs
- **Edge computing** scenarios with limited infrastructure
- **Analytical workloads** requiring fast read performance

### When to Avoid SQLite

- **High-concurrency applications** with many simultaneous writers
- **Network-based applications** requiring client-server architecture
- **Large-scale applications** with complex user management needs
- **Distributed systems** requiring replication and clustering

## Production Deployment Patterns

### Docker Configuration for SQLite Applications

See [example-1](./examples/sqlite/example-1.dockerfile)

See [example-2](./examples/sqlite/example-2.yaml)

### Kubernetes Deployment for SQLite Applications

`See [example-3](./examples/sqlite/example-3.yaml)sql
-- Personal Finance Manager for Desktop Application
-- Optimized for single-user, high-performance local storage

-- Enable WAL mode and performance pragmas
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;
PRAGMA cache_size = 10000;
PRAGMA temp_store = memory;
PRAGMA mmap_size = 268435456; -- 256MB

-- Account categories with hierarchical structure
CREATE TABLE account_categories (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL UNIQUE,
    parent_id INTEGER REFERENCES account_categories(id),
    category_type TEXT NOT NULL CHECK (category_type IN ('asset', 'liability', 'income', 'expense')),
    is_active BOOLEAN DEFAULT 1,
    sort_order INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Financial accounts
CREATE TABLE accounts (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    category_id INTEGER NOT NULL REFERENCES account_categories(id),
    account_number TEXT,
    institution_name TEXT,
    opening_balance DECIMAL(15,2) DEFAULT 0.00,
    current_balance DECIMAL(15,2) DEFAULT 0.00,
    is_active BOOLEAN DEFAULT 1,
    currency_code TEXT DEFAULT 'USD',
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Transactions with full double-entry bookkeeping
CREATE TABLE transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    transaction_date DATE NOT NULL,
    description TEXT NOT NULL,
    reference_number TEXT,
    notes TEXT,
    is_reconciled BOOLEAN DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Transaction entries (double-entry system)
CREATE TABLE transaction_entries (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    transaction_id INTEGER NOT NULL REFERENCES transactions(id) ON DELETE CASCADE,
    account_id INTEGER NOT NULL REFERENCES accounts(id),
    debit_amount DECIMAL(15,2) DEFAULT 0.00,
    credit_amount DECIMAL(15,2) DEFAULT 0.00,
    entry_order INTEGER DEFAULT 0,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Budget planning
CREATE TABLE budgets (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    name TEXT NOT NULL,
    period_type TEXT NOT NULL CHECK (period_type IN ('monthly', 'quarterly', 'yearly')),
    start_date DATE NOT NULL,
    end_date DATE NOT NULL,
    is_active BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE budget_items (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    budget_id INTEGER NOT NULL REFERENCES budgets(id) ON DELETE CASCADE,
    account_id INTEGER NOT NULL REFERENCES accounts(id),
    planned_amount DECIMAL(15,2) NOT NULL,
    actual_amount DECIMAL(15,2) DEFAULT 0.00,
    variance_amount DECIMAL(15,2) GENERATED ALWAYS AS (actual_amount - planned_amount) STORED,
    notes TEXT
);

-- Investment tracking
CREATE TABLE investment_securities (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    symbol TEXT NOT NULL UNIQUE,
    name TEXT NOT NULL,
    security_type TEXT NOT NULL CHECK (security_type IN ('stock', 'bond', 'etf', 'mutual_fund', 'cryptocurrency')),
    exchange TEXT,
    currency_code TEXT DEFAULT 'USD',
    is_active BOOLEAN DEFAULT 1,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

CREATE TABLE investment_transactions (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    account_id INTEGER NOT NULL REFERENCES accounts(id),
    security_id INTEGER NOT NULL REFERENCES investment_securities(id),
    transaction_type TEXT NOT NULL CHECK (transaction_type IN ('buy', 'sell', 'dividend', 'split', 'merger')),
    transaction_date DATE NOT NULL,
    quantity DECIMAL(15,6) NOT NULL,
    price_per_share DECIMAL(15,4) NOT NULL,
    commission DECIMAL(15,2) DEFAULT 0.00,
    total_amount DECIMAL(15,2) GENERATED ALWAYS AS (quantity * price_per_share + commission) STORED,
    notes TEXT,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP
);

-- Performance indexes for financial queries
CREATE INDEX idx_transactions_date ON transactions(transaction_date);
CREATE INDEX idx_transactions_reconciled ON transactions(is_reconciled);
CREATE INDEX idx_transaction_entries_account ON transaction_entries(account_id);
CREATE INDEX idx_transaction_entries_transaction ON transaction_entries(transaction_id);
CREATE INDEX idx_accounts_category ON accounts(category_id);
CREATE INDEX idx_accounts_active ON accounts(is_active);
CREATE INDEX idx_investment_transactions_account ON investment_transactions(account_id);
CREATE INDEX idx_investment_transactions_security ON investment_transactions(security_id);
CREATE INDEX idx_investment_transactions_date ON investment_transactions(transaction_date);

-- Triggers for maintaining account balances
CREATE TRIGGER update_account_balance_insert
AFTER INSERT ON transaction_entries
BEGIN
    UPDATE accounts
    SET current_balance = current_balance + NEW.credit_amount - NEW.debit_amount,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.account_id;
END;

CREATE TRIGGER update_account_balance_update
AFTER UPDATE ON transaction_entries
BEGIN
    UPDATE accounts
    SET current_balance = current_balance + NEW.credit_amount - NEW.debit_amount - OLD.credit_amount + OLD.debit_amount,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = NEW.account_id;
END;

CREATE TRIGGER update_account_balance_delete
AFTER DELETE ON transaction_entries
BEGIN
    UPDATE accounts
    SET current_balance = current_balance - OLD.credit_amount + OLD.debit_amount,
        updated_at = CURRENT_TIMESTAMP
    WHERE id = OLD.account_id;
END;

-- Views for common financial reports
CREATE VIEW account_balances AS
SELECT
    a.id,
    a.name,
    ac.name AS category_name,
    ac.category_type,
    a.current_balance,
    a.currency_code,
    a.is_active
FROM accounts a
JOIN account_categories ac ON a.category_id = ac.id;

CREATE VIEW monthly_cash_flow AS
SELECT
    strftime('%Y-%m', t.transaction_date) AS month,
    ac.category_type,
    SUM(te.credit_amount - te.debit_amount) AS net_amount
FROM transactions t
JOIN transaction_entries te ON t.id = te.transaction_id
JOIN accounts a ON te.account_id = a.id
JOIN account_categories ac ON a.category_id = ac.id
WHERE ac.category_type IN ('income', 'expense')
GROUP BY strftime('%Y-%m', t.transaction_date), ac.category_type
ORDER BY month DESC, ac.category_type;

-- Full-text search for transactions
CREATE VIRTUAL TABLE transaction_search USING fts5(
    transaction_id UNINDEXED,
    description,
    notes,
    reference_number,
    account_name
);

-- Populate search index trigger
CREATE TRIGGER populate_transaction_search_insert
AFTER INSERT ON transactions
BEGIN
    INSERT INTO transaction_search (transaction_id, description, notes, reference_number)
    VALUES (NEW.id, NEW.description, NEW.notes, NEW.reference_number);
END;

-- Sample data for testing
INSERT INTO account_categories (name, category_type) VALUES
('Assets', 'asset'),
('Checking Accounts', 'asset'),
('Savings Accounts', 'asset'),
('Investment Accounts', 'asset'),
('Liabilities', 'liability'),
('Credit Cards', 'liability'),
('Income', 'income'),
('Salary', 'income'),
('Expenses', 'expense'),
('Food & Dining', 'expense'),
('Transportation', 'expense'),
('Entertainment', 'expense');
`See [example-4](./examples/sqlite/example-4.txt)sql
-- Task Management App with Offline-First Design
-- Optimized for mobile devices with sync capabilities

-- Enable mobile-optimized settings
PRAGMA journal_mode = WAL;
PRAGMA synchronous = NORMAL;
PRAGMA cache_size = 2000;  -- Smaller cache for mobile
PRAGMA temp_store = memory;
PRAGMA auto_vacuum = INCREMENTAL;

-- User profiles with offline capability
CREATE TABLE users (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT NOT NULL UNIQUE,  -- For sync with server
    username TEXT NOT NULL UNIQUE,
    email TEXT NOT NULL UNIQUE,
    display_name TEXT,
    avatar_url TEXT,
    timezone TEXT DEFAULT 'UTC',
    is_premium BOOLEAN DEFAULT 0,
    sync_token TEXT,  -- For incremental sync
    last_sync_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    deleted_at DATETIME  -- Soft delete for sync
);

-- Projects with hierarchical structure
CREATE TABLE projects (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT NOT NULL UNIQUE,
    user_id INTEGER NOT NULL REFERENCES users(id),
    parent_id INTEGER REFERENCES projects(id),
    name TEXT NOT NULL,
    description TEXT,
    color_code TEXT DEFAULT '#3498db',
    sort_order INTEGER DEFAULT 0,
    is_archived BOOLEAN DEFAULT 0,
    sync_status TEXT DEFAULT 'synced' CHECK (sync_status IN ('synced', 'pending', 'conflict')),
    server_updated_at DATETIME,
    created_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    updated_at DATETIME DEFAULT CURRENT_TIMESTAMP,
    deleted_at DATETIME
);

-- Tasks with rich metadata
CREATE TABLE tasks (
    id INTEGER PRIMARY KEY AUTOINCREMENT,
    uuid TEXT NOT NULL UNIQUE,
    project_id INTEGER REFERENCES projects(id),
    user_id INTEGER NOT NULL REFERENCES users(id),
    parent_task_id INTEGER REFERENCES tasks(id),
    title TEXT NOT NULL,
    description TEXT,
    priority INTEGER DEFAULT 0 CHECK (priority BETWEEN 0 AND 4),

*Content optimized for conciseness. See source history or external references for full details.*

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 3.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
