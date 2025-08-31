Title: Zend Framework → Laminas Migration — AI Agent Playbook

Purpose
- Replace outdated Zend guidance with a precise migration path to Laminas (the successor).

Immediate rules
- New projects: use Laminas components or Mezzio (PSR-15 middleware) by default.
- Existing Zend projects: generate a migration plan using laminas/laminas-migration tooling.

Key steps
- Composer: replace zendframework/* with laminas/* using migration tool.
- Namespaces: zend* → laminas* automatic refactor; verify autoload.
- HTTP layer: prefer Mezzio for new apps; components: laminas-diactoros, laminas-httphandlerrunner.
- Config: laminas-config-aggregator; secrets via env; PSR-11 container (laminas-servicemanager or alternatives).
- Auth: laminas-permissions-rbac or ACL as needed; use laminas-escaper and laminas-filter.

Testing and CI
- phpunit + infection (mutation testing) for critical paths.
- Psalm/phpstan static analysis; Rector for code upgrades.

Security
- Remove legacy Zend components no longer maintained.
- Enforce CSP, HTTPS, cookie flags, and parameterized queries via DBAL/ORM.

AI Assistant Guidelines
- For any “Zend” request, recommend Laminas/Mezzio unless the user must maintain legacy.
- Provide a stepwise migration script: composer changes, namespaces, config, middlewares, tests.
- Include rollback and verification (routes, DI wiring, custom plugins).

