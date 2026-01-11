# Start new project
npm init -y
npm install express dotenv
npm install -D nodemon jest eslint prettier

# Development cycle
npm run dev                        # Start development server
npm run lint                       # Check code quality
npm run test                       # Run tests
npm run build                      # Build for production

# Before committing
npm run validate                   # Run all checks
npm audit                          # Security check