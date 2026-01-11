---
name: 'Tradier.Instructions'
description: 'Purpose: Integrate with Tradier brokerage for account data and order routing with safety, compliance, and observability.'
keywords: [compliance, guidelines, gui, api, frameworks, safety, (broker, assistant, rules, rest]
---



# Tradier — AI Assistant Guidelines (Broker API)

Purpose: Integrate with Tradier brokerage for account data and order routing with safety, compliance, and observability.

## When to use
- Equities/options trading via REST/streaming with paper/live modes.

## Safety and compliance
- Use read-only keys in dev; segregate paper vs. live; permission scopes minimal.
- Validate orders; add price/size sanity checks; throttle requests; handle rate limits.

## Testing
- Mock API responses; deterministic order simulations; reconcile fills.

## AI Assistant rules
- Never embed API keys; provide env var templates; include a rollback plan and alerts.

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
