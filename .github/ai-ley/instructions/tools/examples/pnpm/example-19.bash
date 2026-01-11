# Optimize installation performance
pnpm config set verify-store-integrity false  # Skip verification
pnpm config set side-effects-cache true       # Enable side effects cache
pnpm config set prefer-offline true           # Use cache when possible

# Parallel installation
pnpm install --no-optional                    # Skip optional deps
pnpm install --production                     # Skip dev deps
pnpm install --frozen-lockfile                # Don't update lockfile