// cypress/e2e/api-testing.cy.js - API testing examples
describe('API Testing', () => {
  beforeEach(() => {
    cy.login('user@example.com', 'password123');
  });

  context('User Profile API', () => {
    it('should load user profile data', () => {
      // Intercept API call
      cy.intercept('GET', '/api/user/profile', {
        fixture: 'user-profile.json',
      }).as('getUserProfile');

      cy.visit('/profile');

      // Wait for API call and verify request
      cy.wait('@getUserProfile').then((interception) => {
        expect(interception.response.statusCode).to.equal(200);
        expect(interception.request.headers).to.have.property('authorization');
      });

      // Verify UI displays data correctly
      cy.get('[data-cy=profile-name]').should('contain', 'John Doe');
      cy.get('[data-cy=profile-email]').should('contain', 'john@example.com');
    });

    it('should handle API errors gracefully', () => {
      // Mock API error
      cy.intercept('GET', '/api/user/profile', {
        statusCode: 500,
        body: { error: 'Internal server error' },
      }).as('getUserProfileError');

      cy.visit('/profile');

      cy.wait('@getUserProfileError');

      // Verify error handling
      cy.get('[data-cy=error-message]')
        .should('be.visible')
        .and('contain', 'Failed to load profile');

      cy.get('[data-cy=retry-button]').should('be.visible');
    });

    it('should update profile successfully', () => {
      const updatedProfile = {
        firstName: 'Jane',
        lastName: 'Smith',
        bio: 'Updated bio text',
      };

      // Mock successful update
      cy.intercept('PUT', '/api/user/profile', {
        statusCode: 200,
        body: { message: 'Profile updated successfully' },
      }).as('updateProfile');

      cy.visit('/profile/edit');

      // Update form fields
      cy.get('[data-cy=first-name-input]').clear().type(updatedProfile.firstName);

      cy.get('[data-cy=last-name-input]').clear().type(updatedProfile.lastName);

      cy.get('[data-cy=bio-textarea]').clear().type(updatedProfile.bio);

      // Submit update
      cy.get('[data-cy=save-button]').click();

      // Verify API call
      cy.wait('@updateProfile').then((interception) => {
        expect(interception.request.body).to.deep.include(updatedProfile);
      });

      // Verify success feedback
      cy.get('[data-cy=success-message]').should('be.visible').and('contain', 'Profile updated');
    });
  });

  context('File Upload API', () => {
    it('should upload profile picture', () => {
      cy.intercept('POST', '/api/user/avatar', {
        statusCode: 200,
        body: { avatarUrl: '/uploads/avatar-123.jpg' },
      }).as('uploadAvatar');

      cy.visit('/profile/edit');

      // Upload file
      cy.get('[data-cy=avatar-upload]').selectFile({
        contents: Cypress.Buffer.from('fake-image-content'),
        fileName: 'avatar.jpg',
        mimeType: 'image/jpeg',
      });

      cy.wait('@uploadAvatar');

      // Verify new avatar is displayed
      cy.get('[data-cy=avatar-preview]')
        .should('be.visible')
        .and('have.attr', 'src')
        .and('include', 'avatar-123.jpg');
    });
  });
});