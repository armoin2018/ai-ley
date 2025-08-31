# QuantRocket — AI Assistant Guidelines

Purpose: Research and live trading on IBKR and other data sources via containerized services with reproducible pipelines.

## When to use
- Need integrated data ingestion (IBKR, vendor datasets), research, and deployment in Docker.
- Prefer a managed stack with Moonshot strategies and Zipline/Alphalens integration.

## When to avoid
- Ultra-low-latency strategies requiring custom infra.
- No access to supported brokers/data feeds.

## Architecture
- Services: flightlog, houston, launchpad, jupyter, moonshot, ibg, zipline, etc.
- Orchestrate with docker-compose; pin image tags and configs; keep persistent volumes backed up.

## Data and calendars
- Use exchange calendars; normalize to session-based time; adjust prices.
- Document vendor, license, and retention; enforce purge per policy.

## Strategy workflows
- Moonshot: vectorized backtesting; define params and sids; export tearsheets.
- Zipline: pipelines with factors; strict split-leakage prevention and slippage/commission models.

## Compliance and ops
- Log with correlation IDs; redact PII; never store credentials in logs.
- Secrets via env/secret store; IBKR sessions monitored with alerts.
- Change management: config hashes, migration scripts, and DR runbooks.

## Testing
- Smoke: services up, health endpoints OK.
- Deterministic backtests on sample bundle; assert metrics within tolerance.
- Data contract tests: schema, missingness, timezone alignment.

## AI Assistant rules
- Provide docker-compose templates with minimal perms and explicit volumes.
- Add monitoring dashboards and alerts; include recovery procedures for IBKR disconnections.
