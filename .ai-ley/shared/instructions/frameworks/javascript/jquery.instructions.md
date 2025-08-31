# jQuery Framework Instructions

## Framework Overview

- **Framework Name**: jQuery
- **Version**: 3.7.x (Current stable version)
- **Type**: JavaScript library for DOM manipulation and AJAX
- **Language**: JavaScript
- **Use Cases**: DOM manipulation, event handling, AJAX requests, animations, legacy browser support

## Installation & Setup

```bash
# Via npm
npm install jquery

# Via CDN (in HTML)
<script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>

# Download and include locally
<script src="js/jquery-3.7.1.min.js"></script>
```

## Project Structure

```
project-root/
  css/
    styles.css
    vendor/
  js/
    main.js
    modules/
      components.js
      utils.js
    vendor/
      jquery.min.js
  images/
  index.html
  package.json
```

## Core Concepts

### DOM Selection and Manipulation

- **Purpose**: Select and modify HTML elements efficiently
- **Usage**: Use CSS-style selectors to target elements
- **Example**:

```javascript
// Selection
const $header = $('#header');
const $buttons = $('.btn');
const $inputs = $('input[type="text"]');

// Manipulation
$header.text('New Header Text');
$buttons.addClass('active').attr('disabled', false);
$('#content').html('<p>New content</p>');

// Chaining
$('.card').addClass('highlighted').fadeIn(300).find('.title').text('Updated Title');
```

### Event Handling

- **Purpose**: Respond to user interactions and browser events
- **Usage**: Attach event listeners with .on() method
- **Example**:

```javascript
// Click events
$('.btn-submit').on('click', function (e) {
  e.preventDefault();
  const formData = $('#myForm').serialize();
  submitForm(formData);
});

// Event delegation for dynamic content
$(document).on('click', '.dynamic-btn', function () {
  const itemId = $(this).data('id');
  handleDynamicClick(itemId);
});

// Multiple events
$('.input-field').on('focus blur', function (e) {
  $(this).toggleClass('focused', e.type === 'focus');
});
```

### AJAX Operations

- **Purpose**: Make asynchronous HTTP requests
- **Usage**: Use $.ajax(), $.get(), $.post() methods
- **Example**:

```javascript
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
```

### Animations and Effects

- **Purpose**: Create smooth visual transitions and effects
- **Usage**: Use built-in animation methods or .animate()
- **Example**:

```javascript
// Basic animations
$('.modal').fadeIn(300);
$('.alert').slideUp(500);

// Custom animations
$('.sidebar').animate(
  {
    width: '300px',
    opacity: 1,
  },
  {
    duration: 400,
    easing: 'easeInOutQuad',
    complete: function () {
      $(this).addClass('expanded');
    },
  },
);

// Chained animations
$('.notification').fadeIn(200).delay(3000).fadeOut(500);
```

## Development Workflow

1. **Setup**: Include jQuery via CDN or npm, ensure DOM ready
2. **Development**: Write modular JavaScript, test in browser console
3. **Testing**: Use browser DevTools, create test cases for interactions
4. **Building**: Minify JavaScript, optimize for production
5. **Deployment**: Ensure jQuery loads before custom scripts

## Best Practices

- Use $(document).ready() or $(function() {}) for DOM initialization
- Cache jQuery objects in variables to avoid repeated DOM queries
- Use event delegation for dynamically added elements
- Prefer data attributes over global variables for component state
- Use namespaced events to avoid conflicts
- Always handle AJAX errors gracefully
- Use semantic HTML and enhance with jQuery rather than building everything in JS

## Common Patterns

### Module Pattern

```javascript
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
```

### Plugin Pattern

```javascript
(function ($) {
  'use strict';

  $.fn.customModal = function (options) {
    const settings = $.extend(
      {
        animation: 'fade',
        duration: 300,
        backdrop: true,
        keyboard: true,
      },
      options,
    );

    return this.each(function () {
      const $modal = $(this);
      const $backdrop = $('<div class="modal-backdrop"></div>');

      function show() {
        $backdrop.appendTo('body');
        $modal.addClass('active');

        if (settings.animation === 'fade') {
          $modal.fadeIn(settings.duration);
        }
      }

      function hide() {
        $modal.fadeOut(settings.duration, function () {
          $backdrop.remove();
          $modal.removeClass('active');
        });
      }

      // Bind events
      $modal.find('[data-dismiss="modal"]').on('click', hide);

      if (settings.backdrop) {
        $backdrop.on('click', hide);
      }

      if (settings.keyboard) {
        $(document).on('keyup.modal', function (e) {
          if (e.keyCode === 27) hide();
        });
      }

      // Expose methods
      $modal.data('modal', {
        show: show,
        hide: hide,
      });
    });
  };
})(jQuery);

// Usage
$('.modal').customModal({
  animation: 'slide',
  duration: 500,
});
```

## Configuration

### jQuery Configuration

```javascript
// No conflict mode
jQuery.noConflict();
// Use jQuery instead of $

// Custom AJAX settings
$.ajaxSetup({
  timeout: 10000,
  cache: false,
  beforeSend: function (xhr) {
    xhr.setRequestHeader('X-Requested-With', 'XMLHttpRequest');
  },
});

// Custom animation settings
$.fx.speeds.slow = 1000;
$.fx.speeds.fast = 100;
```

### Environment Setup

```html
<!DOCTYPE html>
<html>
  <head>
    <meta charset="utf-8" />
    <title>jQuery App</title>
    <link rel="stylesheet" href="css/styles.css" />
  </head>
  <body>
    <!-- Content -->

    <!-- jQuery first -->
    <script src="https://code.jquery.com/jquery-3.7.1.min.js"></script>
    <!-- Then plugins -->
    <script src="js/plugins.js"></script>
    <!-- Finally app code -->
    <script src="js/main.js"></script>
  </body>
</html>
```

## Essential Commands

```bash
# Development (using build tools)
npm run dev

# Testing
npm test

# Building/Minification
npm run build

# Linting
eslint js/*.js

# Package management
npm install jquery
npm install --save-dev grunt gulp webpack
```

## Common Issues & Solutions

### $ is not defined

**Problem**: jQuery not loaded or conflicts with other libraries
**Solution**: Ensure jQuery loads first, use jQuery.noConflict() if needed

### Events not working on dynamic content

**Problem**: Event handlers not attached to dynamically added elements
**Solution**: Use event delegation with $(document).on('event', 'selector', handler)

### Memory leaks from event handlers

**Problem**: Event handlers not properly removed
**Solution**: Use .off() to remove handlers and namespace events

## Performance Optimization

- Cache jQuery objects in variables: `const $element = $('#element')`
- Use efficient selectors: prefer IDs over classes, classes over attributes
- Minimize DOM queries by storing references
- Use event delegation instead of binding to many elements
- Debounce expensive operations like scroll and resize handlers
- Use CSS classes for styling instead of .css() method
- Chain jQuery methods when possible to reduce DOM queries

## Security Considerations

- Sanitize user input before inserting into DOM with .html()
- Use .text() instead of .html() when displaying user content
- Validate AJAX responses before processing
- Use HTTPS for AJAX requests in production
- Implement CSRF protection for form submissions
- Escape special characters in user-generated content

## Useful Resources

- **Official Documentation**: https://jquery.com/
- **API Documentation**: https://api.jquery.com/
- **Learning Center**: https://learn.jquery.com/
- **jQuery UI**: https://jqueryui.com/
- **Plugin Registry**: https://plugins.jquery.com/

## Framework-Specific Guidelines

### Code Style

- Use camelCase for variable and function names
- Prefix jQuery objects with $ for clarity
- Use single quotes for strings consistently
- Indent with 2 spaces, use semicolons
- Group related functionality into modules

### Architecture Patterns

- Organize code into logical modules
- Use namespacing to avoid global pollution
- Implement plugin pattern for reusable components
- Separate concerns: HTML structure, CSS presentation, JS behavior
- Use data attributes for component configuration

## Integration Points

### Bootstrap

- **Purpose**: CSS framework that works seamlessly with jQuery
- **Setup**: Include Bootstrap CSS and JS after jQuery
- **Usage**: Use Bootstrap's JavaScript components with jQuery selectors

### Validation Plugins

- **Purpose**: Form validation with jQuery Validation Plugin
- **Setup**: Include jquery.validate.js after jQuery
- **Usage**: `$('#form').validate({ rules: {...}, messages: {...} })`

### UI Libraries

- **Purpose**: Rich UI components with jQuery UI
- **Setup**: Include jQuery UI CSS and JS
- **Usage**: `$('#datepicker').datepicker()`, `$('#dialog').dialog()`

## Version Compatibility

- **Browsers**: IE9+, modern browsers (jQuery 3.x)
- **Node.js**: Any version (if using in build process)
- **Dependencies**: None (standalone library)
- **jQuery Versions**: 1.x (legacy IE), 2.x (modern), 3.x (current)

## Troubleshooting

### Debug Mode

```javascript
// Enable debug logging
jQuery.fn.debug = function () {
  console.log(this);
  return this;
};

// Usage
$('.element').debug().addClass('active');
```

### Log Analysis

- Use browser DevTools Console for JavaScript errors
- Network tab for AJAX request debugging
- Elements tab for DOM inspection

## AI Assistant Guidelines

When helping with jQuery implementation:

1. **Prioritize modern alternatives** - Recommend vanilla JS or modern frameworks for new projects
2. **Legacy context awareness** - Understand when jQuery is appropriate for legacy codebases
3. **Migration guidance** - Provide clear migration paths from jQuery to modern alternatives
4. **Performance considerations** - Always include performance implications of jQuery usage
5. **Security practices** - Emphasize XSS prevention and input sanitization
6. **Modern JavaScript features** - Show equivalent modern JavaScript alongside jQuery examples
7. **DOM manipulation efficiency** - Recommend best practices for efficient DOM operations

### Code Generation Rules

- Always include modern JavaScript alternatives alongside jQuery examples
- Generate efficient selectors and minimize DOM queries
- Include proper error handling and input validation
- Follow jQuery best practices for chaining and event handling
- Provide migration suggestions for long-term maintainability
- Include security considerations for DOM manipulation
- Generate modular, testable code patterns
- Reference current jQuery documentation and best practices

### Decision Gates

- **Use jQuery when**: Working with legacy codebases, need broad browser support, team expertise
- **Avoid jQuery when**: Building new applications, using modern frameworks, performance is critical
- **Migration indicators**: Outdated jQuery versions, modern browser support requirements, framework adoption

### Common Error Messages

- **Error**: `Uncaught TypeError: $ is not a function`
  **Cause**: jQuery not loaded or loaded after custom scripts
  **Solution**: Load jQuery before other scripts

- **Error**: `Cannot read property 'length' of undefined`
  **Cause**: Selector returned empty jQuery object
  **Solution**: Check if elements exist: `if ($element.length) { ... }`

- **Error**: `Uncaught ReferenceError: jQuery is not defined`
  **Cause**: jQuery script failed to load
  **Solution**: Check script source URL and network connectivity
