# Puppet — Declarative Configuration Management

## Overview
Puppet provides declarative infrastructure management with manifests (DSL), classes, modules, and
Hiera for configuration data. It supports agent/master or Puppet Bolt for agentless tasks.

## Core concepts
- Resources, classes, defined types; modules for reuse; roles/profiles pattern for composition
- Hiera for data separation; environment/branch‑per‑env; r10k/code‑manager for deployments

## Best practices
- Roles/Profiles pattern: profiles combine modules; roles assign profiles to nodes
- Keep logic in Puppet code minimal; rely on parameters and Hiera data
- Separate secrets; integrate with Vault/SSM; do not store secrets in Hiera plain text
- Enforce strict types; use PDK to scaffold and test modules

## CI/CD
- Lint with puppet‑lint; unit tests with rspec‑puppet; integration with Litmus/Beaker
- r10k to deploy environments from git; code review before environment promotions

## Observability
- PuppetDB for facts/catalogs/reports; dashboards and drift detection; alert on failed runs and catalog time

## AI Assistant Guidelines
- Propose roles/profiles structure with clear module boundaries; prefer Hiera for data
- Include PDK scaffolding, tests, and r10k workflow; avoid embedding secrets in manifests
- Provide drift detection and reporting hooks via PuppetDB

