# Verify workspace configuration
pnpm list --filter="./packages/*"

# Check workspace setup
pnpm why @company/shared

# Rebuild workspace links
rm -rf node_modules
pnpm install