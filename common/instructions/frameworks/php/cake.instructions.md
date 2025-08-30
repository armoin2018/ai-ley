Title: CakePHP (v5) — AI Agent Implementation Guide

Purpose
- Provide strict rules for generating CakePHP apps using modern Cake 5 patterns.
- Enforce layered architecture, ORM safety, validation, and testing.

When to use
- Rapid CRUD-heavy apps with convention-over-configuration and robust ORM.
- Admin portals, internal tools, REST APIs with authentication/authorization.

When to avoid
- Ultra-high concurrency with bespoke frameworks; or real-time websockets-first apps.

Architecture
- Use Controllers → Services → ORM (Tables/Entities) with DTOs for boundaries.
- Validation: Form/Request validation + domain rules in Table classes.
- Authentication/Authorization: cakephp/authentication + authorization plugins.
- Migrations: bake + migrations; no ad-hoc schema drift.

Security
- Always enable CSRF, Form Tampering protection, and HTTPS-only cookies.
- Parameterized queries via ORM; never concatenate SQL.
- Secrets via env; configuration through app_local.php only.

Testing
- Use PHPUnit with fixtures/factories; mock external services.
- Controller tests for routing and middleware; integration tests for auth flows.

CI/CD
- Bake scaffolds, run migrations, seed minimal data; run phpstan, php-cs-fixer, phpunit.
- Build container with production config separated; run DB migrations on deploy.

AI Assistant Guidelines
- Generate bake commands, Table/Entity skeletons, request validators, and policy classes.
- Prefer Repository + Service patterns, avoid business logic in Controllers.
- Include tests for each generated action; provide fixtures.

