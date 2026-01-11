// GET request
$.get('/api/users', function (data) {
  displayUsers(data);
}).fail(function (xhr, status, error) {
  console.error('Error fetching users:', error);
});

// POST request with JSON
$.ajax({
  url: '/api/users',
  method: 'POST',
  contentType: 'application/json',
  data: JSON.stringify(userData),
  success: function (response) {
    showSuccessMessage('User created successfully');
  },
  error: function (xhr, status, error) {
    showErrorMessage('Failed to create user');
  },
});

// Promise-based approach
$.getJSON('/api/config')
  .done(function (config) {
    initializeApp(config);
  })
  .fail(function () {
    useDefaultConfig();
  });