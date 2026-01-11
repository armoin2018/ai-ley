# Faster installations
yarn install --frozen-lockfile    # Skip resolution, use lockfile
yarn install --offline           # Use cache only
yarn install --prefer-offline    # Prefer cache over network
yarn install --network-concurrency 1  # Reduce network load

# Parallel processing
yarn install --parallel          # Install deps in parallel (Yarn 1.x)
yarn workspaces run --parallel build  # Parallel workspace commands