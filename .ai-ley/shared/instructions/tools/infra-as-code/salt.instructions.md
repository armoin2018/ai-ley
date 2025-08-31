# Salt (SaltStack) — Configuration Management and Orchestration

## Overview
Salt provides event‑driven automation with remote execution (salt), configuration management (state
system), and orchestration across large fleets. Supports master/minion and salt‑ssh modes.

## Core concepts
- States (SLS), pillars (secure data), grains (host facts), beacons/reactors (event triggers)
- Jinja templating and YAML for states; execution modules for ad‑hoc tasks

## Best practices
- Immutable, idempotent states; parameterize via pillars; keep secrets out of git (use external pillar)
- Use environments and top.sls targeting; roles via grains/pillars
- Test states in lower envs; canary rollouts; use salt‑ssh for limited‑access hosts

## Orchestration
- Orchestrate multi‑host workflows with orchestration SLS; reactors to auto‑respond to events
- Integrate with cloud modules for provisioning; schedule periodic states

## Observability
- Returners to ship results to databases/queues; central logging; event bus metrics

## AI Assistant Guidelines
- Generate simple, parameterized SLS with Jinja; pillars for secrets; avoid plaintext secrets
- Include canary strategy and rollback; propose beacons/reactors for self‑healing where appropriate

