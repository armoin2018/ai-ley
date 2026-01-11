# Initialize new project
yarn init                          # Interactive setup
yarn init -y                       # Use defaults
yarn init -p                       # Private package

# Set Yarn version for project (Yarn 3+)
yarn set version stable            # Latest stable
yarn set version 3.6.3            # Specific version
yarn set version berry             # Latest berry version

# Create project structure
mkdir my-project
cd my-project
yarn init -y