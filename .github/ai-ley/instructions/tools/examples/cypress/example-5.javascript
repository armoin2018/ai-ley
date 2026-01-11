// cypress/e2e/authentication.cy.js - E2E test example
describe('Authentication Flow', () => {
  beforeEach(() => {
    // Setup before each test
    cy.visit('/');
    cy.clearCookies();
    cy.clearLocalStorage();
  });

  context('Login', () => {
    it('should login with valid credentials', () => {
      // Test data
      const user = {
        email: 'user@example.com',
        password: 'password123',
      };

      // Navigate to login
      cy.get('[data-cy=login-link]').click();
      cy.url().should('include', '/login');

      // Fill form
      cy.get('[data-cy=email-input]').type(user.email).should('have.value', user.email);

      cy.get('[data-cy=password-input]').type(user.password).should('have.value', user.password);

      // Submit form
      cy.get('[data-cy=login-button]').click();

      // Verify success
      cy.url().should('include', '/dashboard');
      cy.get('[data-cy=welcome-message]').should('be.visible').and('contain', 'Welcome back');

      // Verify user menu is available
      cy.get('[data-cy=user-menu]').should('be.visible').click();

      cy.get('[data-cy=profile-link]').should('be.visible');
      cy.get('[data-cy=logout-link]').should('be.visible');
    });

    it('should show error with invalid credentials', () => {
      cy.get('[data-cy=login-link]').click();

      cy.get('[data-cy=email-input]').type('invalid@example.com');
      cy.get('[data-cy=password-input]').type('wrongpassword');
      cy.get('[data-cy=login-button]').click();

      // Verify error message
      cy.get('[data-cy=error-message]').should('be.visible').and('contain', 'Invalid credentials');

      // Verify still on login page
      cy.url().should('include', '/login');
    });

    it('should validate required fields', () => {
      cy.get('[data-cy=login-link]').click();
      cy.get('[data-cy=login-button]').click();

      // Check validation messages
      cy.get('[data-cy=email-error]').should('be.visible').and('contain', 'Email is required');

      cy.get('[data-cy=password-error]')
        .should('be.visible')
        .and('contain', 'Password is required');
    });
  });

  context('Registration', () => {
    it('should register new user successfully', () => {
      const newUser = {
        firstName: 'John',
        lastName: 'Doe',
        email: `test${Date.now()}@example.com`,
        password: 'SecurePassword123!',
      };

      cy.get('[data-cy=register-link]').click();
      cy.url().should('include', '/register');

      // Fill registration form
      cy.get('[data-cy=first-name-input]').type(newUser.firstName);
      cy.get('[data-cy=last-name-input]').type(newUser.lastName);
      cy.get('[data-cy=email-input]').type(newUser.email);
      cy.get('[data-cy=password-input]').type(newUser.password);
      cy.get('[data-cy=confirm-password-input]').type(newUser.password);

      // Accept terms
      cy.get('[data-cy=terms-checkbox]').check();

      // Submit registration
      cy.get('[data-cy=register-button]').click();

      // Verify success
      cy.get('[data-cy=success-message]')
        .should('be.visible')
        .and('contain', 'Registration successful');

      // Should redirect to verification page
      cy.url().should('include', '/verify-email');
    });
  });
});