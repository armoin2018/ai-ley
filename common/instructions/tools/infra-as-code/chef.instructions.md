# Chef — Infrastructure as Code at Scale

## Overview
Chef automates infrastructure with Ruby‑based cookbooks and recipes, supporting policy‑as‑code,
idempotent configuration, and compliance. Use Chef Infra Client/Server or Chef Solo/Workstation;
Chef InSpec for compliance testing; Test Kitchen for integration tests.

## Core concepts
- Cookbooks → Recipes → Resources/Providers; Attributes; Templates; Files
- Policyfiles/Berkshelf for dependency management (prefer Policyfiles)
- Environments, Roles (consider policyfiles + attributes instead of Roles)
- Data Bags/Encrypted Data Bags for shared config (prefer secrets manager integration)

## Best practices
- Idempotent resources; converge safe; minimal Ruby logic in recipes (prefer custom resources)
- Separate config from secrets; never commit secrets; use Vault/SSM/Key Vault
- Use Policyfiles with pinned versions; signed artifact store; promote across envs (dev→stage→prod)
- Test Kitchen for integration tests; InSpec for compliance; CI gates on converge + InSpec

## CI/CD pipeline
- Lint: cookstyle/foodcritic (if used), unit tests: chefspec
- Kitchen matrix on key platforms; converge and verify with InSpec profiles
- Artifact upload to Chef Server/Artifact Repo; promote via policy revision bump

## Observability
- Report handlers and audit mode; central logs; converge frequency dashboards; failure alerts

## Migration/modernization
- Prefer custom resources and unified_mode; remove legacy LWRPs
- Replace Roles with Policyfiles where practical; reduce environment sprawl

## AI Assistant Guidelines
- Generate custom resources with clear properties and idempotency checks
- Default to Policyfiles and secrets in a vault; include Test Kitchen + InSpec examples
- Avoid suggesting secrets in attributes or data bags; do not hardcode credentials

