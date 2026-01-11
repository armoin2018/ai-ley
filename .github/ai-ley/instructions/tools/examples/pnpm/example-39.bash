# Enable debug logging
pnpm --loglevel=debug install

# Verbose output
pnpm install --verbose

# Check configuration
pnpm config list
pnpm config list --global

# Store diagnostics
pnpm store status
pnpm store prune --dry-run