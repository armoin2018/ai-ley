# Store operations
pnpm store status                   # Show store statistics
pnpm store prune                    # Clean up unused packages
pnpm store path                     # Show store directory

# Store configuration
pnpm config set store-dir /custom/path/.pnpm-store
pnpm config set verify-store-integrity true
pnpm config set package-import-method hardlink

# Verify store integrity
pnpm install --verify-store-integrity