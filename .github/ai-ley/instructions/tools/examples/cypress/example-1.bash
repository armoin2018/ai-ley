# Install Cypress as dev dependency
npm install --save-dev cypress

# Install additional testing utilities
npm install --save-dev @testing-library/cypress @cypress/code-coverage

# Initialize Cypress (creates cypress folder and config)
npx cypress open

# Run Cypress in headless mode
npx cypress run