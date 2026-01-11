# Monorepo workflow
yarn workspaces run build          # Build all packages
yarn workspace @myorg/core add lodash  # Add dep to specific package
yarn workspace @myorg/utils run test   # Test specific package

# Cross-workspace dependencies
cd packages/utils
yarn add @myorg/core@workspace:*   # Depend on sibling workspace