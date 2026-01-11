# Optimize package installation
bun install --frozen-lockfile    # Don't update lockfile
bun install --ignore-scripts     # Skip postinstall scripts
bun install --production         # Skip devDependencies

# Use global cache effectively
bun pm cache clear              # Clear cache if corrupted
bun install --verbose           # Debug installation issues