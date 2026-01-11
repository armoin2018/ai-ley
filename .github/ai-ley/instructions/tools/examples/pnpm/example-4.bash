# Set global configuration
pnpm config set registry https://registry.npmjs.org/
pnpm config set store-dir ~/.pnpm-store
pnpm config set strict-peer-dependencies true

# View current configuration
pnpm config list
pnpm config list --global
pnpm config get registry

# Location-specific configuration
pnpm config set --location=global registry https://npm.company.com/
pnpm config set --location=project auto-install-peers true

# Environment-specific settings
pnpm config set production-only true --location=global