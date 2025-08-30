# Teradata (Vantage) — Enterprise Data Warehouse Guidance

## Overview
Teradata Vantage is a massively parallel processing (MPP) enterprise data warehouse optimized for large-scale analytics, mixed workloads, and ANSI SQL with extensions. It excels at high-concurrency, complex joins, and long-running analytical queries with robust workload management.

- Core strengths: parallelism, join performance, workload management (TASM/WLM), SQL analytics, time-series/temporal tables.
- Typical use cases: enterprise BI, large fact/dimension models, cross-domain analytics, governed data sharing, mixed workloads.
- Alternatives: Snowflake/BigQuery (cloud-first elastic), PostgreSQL (OLTP + medium analytics), Presto/Trino (federated), Spark SQL (compute-centric).

## When to use vs. avoid
- Use Teradata when: you need predictable performance under heavy concurrency, complex joins on very large datasets, strong governance and workload isolation, and existing Teradata ops expertise.
- Avoid/consider alternatives when: highly elastic bursty compute is the priority (serverless cloud DWs), heavy un/semi-structured data processing dominates (data lake engines), or team lacks Teradata operational skillset.

## Setup and tooling
- Clients/Drivers: ODBC/JDBC, Python `teradatasql`/`teradata`, CLI `bteq`, `tdload`/TPT for bulk loads.
- Access patterns: standard SQL over JDBC/ODBC; for bulk loads prefer TPT/`tdload`; for admin/DDL use BTEQ.
- Environments: Vantage (on-prem/appliance/cloud); for dev, leverage shared lower envs or vendor-provided developer editions when available.

## Data modeling and distribution
- Primary Index (PI): determines row distribution across AMPs; choose columns with high cardinality and even distribution to avoid skew. Consider Non-Unique PI for balanced spread.
- Secondary Indexes (SI/JI/NUSI/USI): use sparingly; they consume space and can affect loads. Favor join planning and statistics first.
- Partitioned Primary Index (PPI): improve pruning for time/range filters; ensure partition boundaries align with access patterns.
- Collect Statistics: on join columns, PI, and frequently filtered columns to guide the optimizer; schedule regular refreshes.

## Query patterns and performance
- Use EXPLAIN: validate plans, ensure joins use appropriate redistribution/duplication, and check for spool space risks.
- QUALIFY: filter on windowed results without subqueries.
- SAMPLE/TOP: use with care; document determinism requirements.
- Set session parameters thoughtfully (date/format/timezone) for consistency across clients.
- Common anti-patterns: unqualified cross joins, broad SELECT *, excessive volatile tables, overuse of secondary indexes, uncontrolled temporary tables.

## Loading and unloading data
- Bulk load: TPT/`tdload` with error tables and restartable scripts; validate row counts and error tables after each run.
- Staging: land to a staging schema with permissive types, then transform into conformed schemas with typed columns and keys.
- Unload/Export: BTEQ to CSV with explicit formats; or JDBC/ODBC with fetch sizing; document character set/locale.

## Security and governance
- Authentication: integrate with enterprise identity (LDAP/Kerberos) where possible.
- Authorization: roles and profiles; least privilege on schemas, tables, views; prefer views for governed exposure.
- Data protection: mask sensitive columns via views; use row-level/column-level security patterns as needed.
- Audit: enable DBQL and access logs; forward to SIEM; retain according to policy.

## Workload management
- Classify workloads with priorities, throttles, and time slicing; isolate ETL vs. ad-hoc analytics.
- Use query banding to tag requests by app/user; leverage for routing and attribution.
- Establish guardrails: max spool space per profile, query time limits, and resource caps.

## Backup, recovery, and change management
- Backups: use BAR/DSA per enterprise RPO/RTO; test restores quarterly.
- Schema changes: use versioned DDL with approvals; apply in off-peak windows; capture EXPLAIN before and after.
- Migrations: validate statistics and recalibrate workload rules post-change.

## Monitoring and observability
- Key metrics: AMP CPU/IO, skew percentage, spool usage, blocked sessions, aborted queries, error table growth.
- Sources: DBQL, ResUsage, Viewpoint/analytics tools; export to your monitoring stack (e.g., textfile exporter → Prometheus scrape).
- SLOs: e.g., P95 dashboard query < 5s; ETL success rate > 99.9%; skew < 10% on critical joins.

## CI/CD and automation
- SQL as code: store DDL/DML/TPT scripts in VCS; review with linters and SQL formatters.
- Migrations: idempotent, retry-safe scripts; preflight EXPLAIN; post-deploy stats refresh and plan drift checks.
- Testing: unit test with a representative lower env; add smoke tests (count checksums, explain plan assertions, row sampling).
- Data contracts: define schemas with compatibility rules; automate contract tests for producers/consumers.

## Integration examples
- Python (teradatasql): connect with DSNless strings; set session params; use parameterized queries and chunked fetch.
- Java (JDBC): configure fetch size and autocommit; control transaction boundaries; use connection pools.
- BI tools: prefer views for governed access; cache strategy documented per tool.

## Troubleshooting
- Skewed queries: check distribution keys; consider PI change or temporary redistribution.
- Spool space exceeded: reduce intermediate result size; add filters earlier; ensure stats are current.
- Locking/contention: review transaction scope; use rowhash/partitioning strategies; separate ETL windows.
- Failed loads: inspect error tables; implement restartable loads with checkpoints.

## AI Assistant Guidelines
- Default to EXPLAIN-driven, statistics-aware SQL; call out PI/partition considerations in generated DDL.
- Prefer views for exposure; avoid suggesting secondary indexes unless justified by access patterns and measured benefit.
- For bulk loads, generate TPT/`tdload` templates with error tables and restart logic; validate row counts.
- Avoid vendor-internal features not confirmed in the environment; stick to ANSI SQL + documented Vantage extensions.
- Include observability hooks: query band tags, DBQL sampling, and basic health checks post-deploy.

---

### Quick snippets
- Example: create table with PPI and stats

```
CREATE MULTISET TABLE sales_fact (
	sale_id BIGINT NOT NULL,
	store_id INTEGER NOT NULL,
	sale_ts TIMESTAMP(0) NOT NULL,
	amount DECIMAL(12,2) NOT NULL
)
PRIMARY INDEX (store_id)
PARTITION BY RANGE_N(sale_ts BETWEEN DATE '2024-01-01' AND DATE '2026-12-31' EACH INTERVAL '1' MONTH);

COLLECT STATISTICS COLUMN(store_id) ON sales_fact;
COLLECT STATISTICS COLUMN(sale_ts) ON sales_fact;
```

- Example: query with QUALIFY

```
SELECT store_id, sale_ts, amount,
			 ROW_NUMBER() OVER (PARTITION BY store_id ORDER BY sale_ts DESC) AS rn
FROM sales_fact
QUALIFY rn <= 3;
```

