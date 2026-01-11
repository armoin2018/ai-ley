# Clear store and reinstall
pnpm store prune
rm -rf node_modules
pnpm install --verify-store-integrity

# Force store verification
pnpm config set verify-store-integrity true