Title: OpenZeppelin — AI Agent Implementation Guide

Use cases
- Security-reviewed Solidity contracts: ERC-20/721/1155, access control, upgradeability.

Critical rules
- Prefer composition over inheritance depth; minimize custom code; use audited modules.
- Always pin compiler and OZ versions; enable optimizer with safe settings.
- Avoid upgradeable proxies unless governance, audits, and runbooks are in place.

Security
- Use AccessControl/Ownable with multi-sig for privileged ops; time-lock sensitive functions.
- ReentrancyGuard where applicable; checks-effects-interactions; pull payments.
- Pause and emergency stop patterns; supply caps; rate limits; allowlists/denylists.

Testing
- Hardhat/Foundry tests with invariants and property-based tests; fuzz critical paths.
- Coverage thresholds; static analysis (Slither, Mythril); gas snapshots.

CI/CD
- Lint, compile, test, analyze; require peer review before deploy; record artifact hashes.
- Deploy to testnets first; verify source on explorers; tag releases immutably.

AI Assistant Guidelines
- Generate minimal, standard OZ-based contracts; explain risk of deviations.
- Provide migration, upgrade, and revoke runbooks; include multi-sig governance.
- Refuse to generate unaudited, complex financial logic without explicit risk acknowledgement.

