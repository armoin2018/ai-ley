# Security audit
npm audit                          # Check for vulnerabilities
npm audit --audit-level moderate   # Set severity threshold
npm audit fix                      # Automatically fix issues
npm audit fix --force             # Force fixes (potentially breaking)

# Manual security review
npm audit --json                   # JSON output for parsing
npm audit --production            # Audit only production deps

# Using npm audit signatures (npm 8.12+)
npm audit signatures              # Verify package signatures
npm install --audit-signatures    # Install with signature verification

# Third-party security tools
npx audit-ci                      # CI-friendly audit
npx better-npm-audit              # Enhanced audit reporting