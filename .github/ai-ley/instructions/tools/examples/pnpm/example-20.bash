# Store management for performance
pnpm store prune                              # Remove unused packages
pnpm config set package-import-method hardlink # Use hardlinks
pnpm config set store-dir /fast-ssd/.pnpm-store # Use fast storage