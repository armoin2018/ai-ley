---
name: 'Wordpress.Instructions'
description: 'Development guidelines and best practices for Wordpress.Instructions'
keywords: [api, coding, gui, architecture, authentication, database, hints), (with, guide, framework]
---



# WordPress Coding & Style Guide (with AI Linting Hints)

This guide defines coding standards and best practices for WordPress development. These include AI linting hints to automatically enforce WordPress coding standards and maintain clean, secure, and performant WordPress code.

⸻

📂 WordPress Architecture

✅ Rule: Follow WordPress coding standards

- Use WordPress core functions instead of native PHP where available
- Follow WordPress naming conventions and file structure
- Implement proper WordPress security practices
- Use WordPress hooks and filters system

✅ Rule: Theme/Plugin separation

- Themes → Presentation and template logic
- Plugins → Functionality and business logic
- Core modifications → Never modify WordPress core files
- Custom code → Use child themes or custom plugins

✅ Rule: WordPress API usage

- Use WordPress database abstraction layer ($wpdb)
- Implement WordPress REST API endpoints properly
- Use WordPress caching mechanisms
- Follow WordPress multisite compatibility

✅ Rule: Security practices

- Sanitize all user inputs
- Escape all outputs
- Use WordPress nonces for form security
- Validate and authenticate user permissions

⸻

📜 WordPress-Specific Functions

✅ Rule: Use WordPress functions

- `get_option()` / `update_option()` for settings
- `wp_enqueue_script()` / `wp_enqueue_style()` for assets
- `wp_safe_redirect()` for redirects
- `wp_kses()` for HTML sanitization

✅ Rule: Database operations

- Use `$wpdb` for custom queries
- Use `WP_Query` for post queries
- Implement proper database table prefixes
- Use prepared statements for security

⸻

🖋 WordPress PHP Coding Standards

✅ String Handling

- Use single quotes unless WordPress translation functions require double quotes
- Use WordPress text domain for internationalization
- Sanitize strings with WordPress functions

✅ Example:

See [example-1](./examples/wordpress/example-1.php)

⸻

✅ Hook Implementation

- Use WordPress hooks (actions and filters) properly
- Implement proper hook priorities
- Remove hooks when necessary
- Use namespaced hook names to avoid conflicts

✅ Example:

See [example-2](./examples/wordpress/example-2.php)

⸻

✅ Database Operations

- Always use prepared statements with $wpdb
- Use WordPress database abstraction layer
- Implement proper error handling
- Use WordPress caching for performance

❌ Bad:

See [example-3](./examples/wordpress/example-3.php)

✅ Good:

See [example-4](./examples/wordpress/example-4.php)

⸻

✅ Security Implementation

- Sanitize all inputs
- Escape all outputs
- Use nonces for form verification
- Check user capabilities

✅ Example:

See [example-5](./examples/wordpress/example-5.php)

⸻

✅ Asset Management

- Use wp_enqueue_script() and wp_enqueue_style()
- Implement proper dependencies
- Use WordPress version for cache busting
- Localize scripts for AJAX

✅ Example:

See [example-6](./examples/wordpress/example-6.php)

⸻

✅ WordPress REST API

- Implement proper authentication
- Use WordPress permission system
- Sanitize and validate inputs
- Return proper HTTP status codes

✅ Example:

See [example-7](./examples/wordpress/example-7.php)

⸻

✅ Custom Post Types and Fields

- Register custom post types properly
- Use WordPress meta API for custom fields
- Implement proper sanitization for meta values
- Use WordPress capabilities system

✅ Example:

See [example-8](./examples/wordpress/example-8.php)

⸻

🧠 WordPress Performance

- Use WordPress caching functions
- Optimize database queries
- Use WordPress transients for temporary data
- Implement lazy loading where appropriate

✅ Example:

See [example-9](./examples/wordpress/example-9.php)

⸻

🧪 WordPress Testing

✅ Unit Testing

- Use WordPress testing framework
- Test with WordPress core functions
- Mock WordPress functions when necessary
- Test across different WordPress versions

✅ Integration Testing

- Test plugin/theme activation and deactivation
- Test with different WordPress configurations
- Test multisite compatibility
- Test with common plugin combinations

⸻

🚦 WordPress AI Enforcement Summary

✅ Enforce WordPress coding standards (WPCS)
✅ Require proper sanitization and escaping
✅ Enforce WordPress security practices (nonces, capabilities)
✅ Block direct database queries without $wpdb
✅ Require proper asset enqueueing
✅ Enforce internationalization (i18n) practices
✅ Require WordPress hook usage over direct calls
✅ Block unsafe HTML output without escaping
✅ Enforce proper error handling with WP_Error
✅ Auto-fix violations where possible

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
