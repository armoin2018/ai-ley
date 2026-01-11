const UserModule = (function ($) {
  'use strict';

  let users = [];

  function init() {
    bindEvents();
    loadUsers();
  }

  function bindEvents() {
    $('#user-form').on('submit', handleFormSubmit);
    $(document).on('click', '.user-delete', handleUserDelete);
  }

  function loadUsers() {
    $.getJSON('/api/users')
      .done(function (data) {
        users = data;
        renderUsers();
      })
      .fail(handleError);
  }

  function renderUsers() {
    const $container = $('#users-container');
    const html = users
      .map(
        (user) => `
      <div class="user-card" data-id="${user.id}">
        <h3>${user.name}</h3>
        <p>${user.email}</p>
        <button class="user-delete btn btn-danger">Delete</button>
      </div>
    `,
      )
      .join('');
    $container.html(html);
  }

  function handleFormSubmit(e) {
    e.preventDefault();
    const formData = $(this).serialize();
    // Handle form submission
  }

  function handleUserDelete(e) {
    const userId = $(this).closest('.user-card').data('id');
    if (confirm('Are you sure?')) {
      deleteUser(userId);
    }
  }

  function handleError(xhr, status, error) {
    console.error('Error:', error);
    showNotification('An error occurred', 'error');
  }

  return {
    init: init,
  };
})(jQuery);

// Initialize when DOM is ready
$(document).ready(function () {
  UserModule.init();
});