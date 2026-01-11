# Remove npm artifacts
rm package-lock.json
rm -rf node_modules

# Install with pnpm
pnpm install

# Update scripts if needed (usually no changes required)
# Commit pnpm-lock.yaml