// cypress/support/e2e.js - Global support configuration
import './commands';
import '@cypress/code-coverage/support';

// Global before hook
beforeEach(() => {
  // Setup that runs before each test
  cy.log('Starting test execution');
});

// Global after hook
afterEach(() => {
  // Cleanup after each test
  cy.clearCookies();
  cy.clearLocalStorage();
});

// Custom error handling
Cypress.on('uncaught:exception', (err, runnable) => {
  // Prevent Cypress from failing tests on uncaught exceptions
  // that we expect in our application
  if (err.message.includes('Script error')) {
    return false;
  }
  return true;
});