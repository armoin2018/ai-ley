-- Create catalog and schema structure
CREATE CATALOG IF NOT EXISTS production;
CREATE SCHEMA IF NOT EXISTS production.sales;
CREATE SCHEMA IF NOT EXISTS production.marketing;

-- Grant permissions
GRANT USE CATALOG ON CATALOG production TO `data-engineers`;
GRANT CREATE SCHEMA ON CATALOG production TO `data-engineers`;
GRANT USE SCHEMA ON SCHEMA production.sales TO `sales-team`;