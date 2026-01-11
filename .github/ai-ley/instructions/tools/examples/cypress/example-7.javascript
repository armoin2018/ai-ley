// src/components/UserCard.cy.js - Component test example
import UserCard from './UserCard.vue';

describe('UserCard Component', () => {
  it('should render user information correctly', () => {
    const user = {
      id: 1,
      name: 'John Doe',
      email: 'john@example.com',
      avatar: '/images/john.jpg',
      role: 'Admin',
      status: 'active',
    };

    cy.mount(UserCard, {
      props: { user },
    });

    // Verify rendered content
    cy.get('[data-cy=user-name]').should('contain', user.name);
    cy.get('[data-cy=user-email]').should('contain', user.email);
    cy.get('[data-cy=user-avatar]')
      .should('have.attr', 'src', user.avatar)
      .and('have.attr', 'alt', user.name);

    cy.get('[data-cy=user-role]').should('contain', user.role);
    cy.get('[data-cy=user-status]')
      .should('contain', user.status)
      .and('have.class', 'status-active');
  });

  it('should handle missing avatar gracefully', () => {
    const user = {
      id: 2,
      name: 'Jane Smith',
      email: 'jane@example.com',
      role: 'User',
      status: 'inactive',
    };

    cy.mount(UserCard, {
      props: { user },
    });

    // Should show default avatar
    cy.get('[data-cy=user-avatar]').should('have.attr', 'src').and('include', 'default-avatar');

    cy.get('[data-cy=user-status]').should('have.class', 'status-inactive');
  });

  it('should emit events on user interactions', () => {
    const user = { id: 1, name: 'John Doe', email: 'john@example.com' };

    cy.mount(UserCard, {
      props: { user },
    }).then(({ component }) => {
      // Listen for emitted events
      cy.spy(component, '$emit').as('componentEmit');
    });

    // Trigger click event
    cy.get('[data-cy=user-card]').click();
    cy.get('@componentEmit').should('have.been.calledWith', 'userSelected', user);

    // Trigger edit button
    cy.get('[data-cy=edit-button]').click();
    cy.get('@componentEmit').should('have.been.calledWith', 'editUser', user.id);

    // Trigger delete button with confirmation
    cy.get('[data-cy=delete-button]').click();
    cy.get('[data-cy=confirm-delete]').click();
    cy.get('@componentEmit').should('have.been.calledWith', 'deleteUser', user.id);
  });
});