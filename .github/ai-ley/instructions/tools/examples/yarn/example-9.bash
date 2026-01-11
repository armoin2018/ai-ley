# Workspace operations
yarn workspaces info               # Show workspace dependency tree
yarn workspaces run build         # Run script in all workspaces
yarn workspaces run --parallel build  # Run in parallel

# Workspace-specific commands
yarn workspace package-a add lodash    # Add dependency to specific workspace
yarn workspace package-a run test     # Run script in specific workspace
yarn workspace package-a remove dep   # Remove dependency from workspace

# Add dependencies to workspaces
yarn add lodash -W                     # Add to root workspace
yarn add jest --dev -W                # Add dev dependency to root