// cypress/e2e/data-driven-testing.cy.js - Using fixtures
describe('Data-Driven Testing', () => {
  beforeEach(() => {
    cy.fixture('users').as('userData');
  });

  it('should test with multiple user types', function () {
    // Access fixture data
    const { adminUser, regularUser } = this.userData;

    // Test with admin user
    cy.login(adminUser.email, adminUser.password);
    cy.visit('/admin');
    cy.get('[data-cy=admin-panel]').should('be.visible');
    cy.logout();

    // Test with regular user
    cy.login(regularUser.email, regularUser.password);
    cy.visit('/admin');
    cy.get('[data-cy=access-denied]').should('be.visible');
  });

  it('should handle user profile data', function () {
    this.userData.userProfiles.forEach((profile) => {
      cy.intercept('GET', `/api/users/${profile.id}`, profile).as('getUser');

      cy.visit(`/users/${profile.id}`);

      cy.wait('@getUser');
      cy.get('[data-cy=user-name]').should('contain', profile.name);
      cy.get('[data-cy=user-email]').should('contain', profile.email);
    });
  });
});