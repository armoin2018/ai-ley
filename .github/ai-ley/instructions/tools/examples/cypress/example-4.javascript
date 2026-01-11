// cypress/support/commands.js - Custom commands
// Login command
Cypress.Commands.add('login', (username, password) => {
  cy.session([username, password], () => {
    cy.visit('/login');
    cy.get('[data-cy=username]').type(username);
    cy.get('[data-cy=password]').type(password);
    cy.get('[data-cy=login-button]').click();

    // Wait for successful login
    cy.url().should('include', '/dashboard');
    cy.get('[data-cy=user-menu]').should('be.visible');
  });
});

// Database seeding command
Cypress.Commands.add('seedDatabase', (fixture) => {
  cy.task('seedDb', fixture);
});

// API mocking command
Cypress.Commands.add('mockApi', (route, fixture) => {
  cy.intercept('GET', route, { fixture }).as('apiCall');
});

// Custom assertion commands
Cypress.Commands.add('shouldBeVisible', { prevSubject: true }, (subject) => {
  cy.wrap(subject).should('be.visible');
  return cy.wrap(subject);
});

// File upload command
Cypress.Commands.add('uploadFile', (selector, fileName, fileType = '') => {
  cy.get(selector).then((subject) => {
    const el = subject[0];
    const blob = Cypress.Blob.base64StringToBlob('test content', fileType);
    const file = new File([blob], fileName, { type: fileType });
    const dataTransfer = new DataTransfer();
    dataTransfer.items.add(file);
    el.files = dataTransfer.files;

    cy.wrap(subject).trigger('change', { force: true });
  });
});

// Accessibility testing command
Cypress.Commands.add('injectAxe', () => {
  cy.window({ log: false }).then((win) => {
    const script = win.document.createElement('script');
    script.src = 'https://unpkg.com/axe-core@4.7.0/axe.min.js';
    win.document.head.appendChild(script);
  });
});

Cypress.Commands.add('checkA11y', (context, options) => {
  cy.window({ log: false }).then((win) => {
    if (win.axe) {
      cy.wrap(null, { log: false })
        .then(() => {
          return new Cypress.Promise((resolve, reject) => {
            win.axe.run(context || win.document, options || {}, (err, results) => {
              if (err) reject(err);
              else resolve(results);
            });
          });
        })
        .then((results) => {
          cy.task('log', `Accessibility violations: ${results.violations.length}`);
          if (results.violations.length) {
            results.violations.forEach((violation) => {
              cy.task('log', `${violation.id}: ${violation.description}`);
            });
            throw new Error(`${results.violations.length} accessibility violation(s) detected`);
          }
        });
    }
  });
});