# Development workflow
npm run cy:open          # Open Cypress Test Runner
npm run cy:run           # Run tests headlessly
npm run cy:run:chrome    # Run in specific browser
npm run cy:run:record    # Record to Cypress Cloud

# Test specific files
npx cypress run --spec "cypress/e2e/auth/**/*"
npx cypress run --spec "cypress/e2e/auth/login.cy.js"

# Environment-specific testing
npx cypress run --env environment=staging
npx cypress run --config baseUrl=https://staging.app.com

# Component testing
npm run cy:open:component
npm run cy:run:component

# Generate test reports
npx cypress run --reporter mochawesome