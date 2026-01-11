# Workspace commands
npm init -w packages/core          # Create new workspace
npm install --workspace=core       # Install deps in workspace
npm run test --workspaces          # Run in all workspaces
npm run build --workspace=core --workspace=utils  # Multiple workspaces

# Install dependencies
npm install lodash -w core         # Install in specific workspace
npm install jest -D -ws            # Install in all workspaces