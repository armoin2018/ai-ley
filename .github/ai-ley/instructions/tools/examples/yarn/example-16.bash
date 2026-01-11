# Start new project
yarn init -y
yarn add express dotenv
yarn add --dev nodemon jest eslint prettier typescript

# Development cycle
yarn dev                          # Start development server
yarn lint                         # Check code quality
yarn test                         # Run tests
yarn build                        # Build for production

# Before committing
yarn lint && yarn test && yarn build
yarn audit                        # Security check