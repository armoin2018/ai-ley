# Semantic versioning
yarn version --patch              # 1.0.0 → 1.0.1
yarn version --minor              # 1.0.0 → 1.1.0
yarn version --major              # 1.0.0 → 2.0.0

# Pre-release versions
yarn version --prerelease         # 1.0.0 → 1.0.1-0
yarn version --prerelease --preid=alpha  # 1.0.0 → 1.0.1-alpha.0

# Custom version
yarn version --new-version 1.2.3-custom.1

# Version management with workspaces
yarn workspaces version           # Version all workspaces
yarn workspace @myorg/core version --patch  # Version specific workspace