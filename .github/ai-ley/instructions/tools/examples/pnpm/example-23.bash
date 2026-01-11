# Remove Yarn artifacts
rm yarn.lock
rm -rf node_modules

# Convert yarn workspaces to pnpm workspaces
# Update package.json workspaces to pnpm-workspace.yaml

# Install with pnpm
pnpm install

# Update scripts if using Yarn-specific commands