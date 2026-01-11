// cypress/support/commands.js - Testing Library integration
import '@testing-library/cypress/add-commands';

// Example test using Testing Library queries
describe('React Component Testing', () => {
  it('should find elements using Testing Library queries', () => {
    cy.visit('/');

    // Use Testing Library queries in Cypress
    cy.findByRole('button', { name: /submit/i }).click();
    cy.findByLabelText(/email address/i).type('user@example.com');
    cy.findByText(/welcome back/i).should('be.visible');

    // Can still use regular Cypress commands
    cy.get('[data-cy=form]').within(() => {
      cy.findByRole('textbox', { name: /password/i }).type('password');
    });
  });
});