---
applyTo: "**/*.php,**/wp-*.php,**/functions.php,**/themes/**/*.php,**/plugins/**/*.php"
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

```php
// Translation functions
$message = __('Hello, World!', 'your-text-domain');
$formatted = sprintf(__('Welcome, %s!', 'your-text-domain'), $username);

// Sanitization
$clean_input = sanitize_text_field($_POST['user_input']);
$clean_email = sanitize_email($_POST['email']);
```

⸻

✅ Hook Implementation

- Use WordPress hooks (actions and filters) properly
- Implement proper hook priorities
- Remove hooks when necessary
- Use namespaced hook names to avoid conflicts

✅ Example:

```php
// Action hook
add_action('init', 'your_prefix_init_function');

function your_prefix_init_function() {
    // Initialization code
    if (is_admin()) {
        add_action('admin_menu', 'your_prefix_admin_menu');
    }
}

// Filter hook
add_filter('the_content', 'your_prefix_modify_content', 10, 1);

function your_prefix_modify_content($content) {
    if (is_single()) {
        $custom_content = '<div class="custom-prefix">' . $content . '</div>';
        return $custom_content;
    }
    return $content;
}
```

⸻

✅ Database Operations

- Always use prepared statements with $wpdb
- Use WordPress database abstraction layer
- Implement proper error handling
- Use WordPress caching for performance

❌ Bad:

```php
global $wpdb;
$user_id = $_GET['user_id']; // Unsanitized input
$result = $wpdb->get_row("SELECT * FROM {$wpdb->users} WHERE ID = $user_id"); // SQL injection risk
```

✅ Good:

```php
global $wpdb;
$user_id = absint($_GET['user_id']); // Sanitized input

$result = $wpdb->get_row($wpdb->prepare(
    "SELECT * FROM {$wpdb->users} WHERE ID = %d",
    $user_id
));

if ($wpdb->last_error) {
    error_log('Database error: ' . $wpdb->last_error);
    return new WP_Error('db_error', __('Database error occurred', 'your-text-domain'));
}
```

⸻

✅ Security Implementation

- Sanitize all inputs
- Escape all outputs
- Use nonces for form verification
- Check user capabilities

✅ Example:

```php
// Form processing with security
function your_prefix_process_form() {
    // Verify nonce
    if (!wp_verify_nonce($_POST['_wpnonce'], 'your_prefix_action')) {
        wp_die(__('Security check failed', 'your-text-domain'));
    }
    
    // Check user capabilities
    if (!current_user_can('manage_options')) {
        wp_die(__('You do not have permission to perform this action', 'your-text-domain'));
    }
    
    // Sanitize inputs
    $title = sanitize_text_field($_POST['title']);
    $content = wp_kses_post($_POST['content']);
    $email = sanitize_email($_POST['email']);
    
    // Process data...
    
    // Redirect with success message
    wp_safe_redirect(add_query_arg('message', 'success', admin_url('admin.php?page=your-page')));
    exit;
}

// Display form with nonce
function your_prefix_display_form() {
    ?>
    <form method="post" action="">
        <?php wp_nonce_field('your_prefix_action'); ?>
        <input type="text" name="title" value="<?php echo esc_attr($title); ?>" />
        <textarea name="content"><?php echo esc_textarea($content); ?></textarea>
        <input type="email" name="email" value="<?php echo esc_attr($email); ?>" />
        <?php submit_button(__('Save', 'your-text-domain')); ?>
    </form>
    <?php
}
```

⸻

✅ Asset Management

- Use wp_enqueue_script() and wp_enqueue_style()
- Implement proper dependencies
- Use WordPress version for cache busting
- Localize scripts for AJAX

✅ Example:

```php
function your_prefix_enqueue_assets() {
    // Enqueue CSS
    wp_enqueue_style(
        'your-prefix-style',
        plugin_dir_url(__FILE__) . 'assets/css/style.css',
        array(),
        '1.0.0'
    );
    
    // Enqueue JavaScript
    wp_enqueue_script(
        'your-prefix-script',
        plugin_dir_url(__FILE__) . 'assets/js/script.js',
        array('jquery'),
        '1.0.0',
        true
    );
    
    // Localize script for AJAX
    wp_localize_script('your-prefix-script', 'your_prefix_ajax', array(
        'ajax_url' => admin_url('admin-ajax.php'),
        'nonce' => wp_create_nonce('your_prefix_ajax_nonce'),
        'messages' => array(
            'loading' => __('Loading...', 'your-text-domain'),
            'error' => __('An error occurred', 'your-text-domain')
        )
    ));
}
add_action('wp_enqueue_scripts', 'your_prefix_enqueue_assets');
```

⸻

✅ WordPress REST API

- Implement proper authentication
- Use WordPress permission system
- Sanitize and validate inputs
- Return proper HTTP status codes

✅ Example:

```php
// Register REST API endpoint
add_action('rest_api_init', 'your_prefix_register_api_routes');

function your_prefix_register_api_routes() {
    register_rest_route('your-prefix/v1', '/users/(?P<id>\d+)', array(
        'methods' => 'GET',
        'callback' => 'your_prefix_get_user',
        'permission_callback' => 'your_prefix_api_permissions',
        'args' => array(
            'id' => array(
                'validate_callback' => function($param) {
                    return is_numeric($param);
                },
                'sanitize_callback' => 'absint'
            )
        )
    ));
}

function your_prefix_api_permissions($request) {
    return current_user_can('read');
}

function your_prefix_get_user($request) {
    $user_id = $request->get_param('id');
    
    $user = get_user_by('ID', $user_id);
    if (!$user) {
        return new WP_Error('user_not_found', __('User not found', 'your-text-domain'), array('status' => 404));
    }
    
    return array(
        'id' => $user->ID,
        'name' => $user->display_name,
        'email' => $user->user_email
    );
}
```

⸻

✅ Custom Post Types and Fields

- Register custom post types properly
- Use WordPress meta API for custom fields
- Implement proper sanitization for meta values
- Use WordPress capabilities system

✅ Example:

```php
// Register custom post type
function your_prefix_register_post_types() {
    register_post_type('your_custom_type', array(
        'labels' => array(
            'name' => __('Custom Items', 'your-text-domain'),
            'singular_name' => __('Custom Item', 'your-text-domain')
        ),
        'public' => true,
        'has_archive' => true,
        'supports' => array('title', 'editor', 'custom-fields'),
        'show_in_rest' => true
    ));
}
add_action('init', 'your_prefix_register_post_types');

// Save custom fields
function your_prefix_save_custom_fields($post_id) {
    if (!current_user_can('edit_post', $post_id)) {
        return;
    }
    
    if (defined('DOING_AUTOSAVE') && DOING_AUTOSAVE) {
        return;
    }
    
    if (isset($_POST['custom_field'])) {
        $value = sanitize_text_field($_POST['custom_field']);
        update_post_meta($post_id, '_custom_field', $value);
    }
}
add_action('save_post', 'your_prefix_save_custom_fields');
```

⸻

🧠 WordPress Performance

- Use WordPress caching functions
- Optimize database queries
- Use WordPress transients for temporary data
- Implement lazy loading where appropriate

✅ Example:

```php
function your_prefix_get_cached_data($key, $expiration = 3600) {
    $cached_data = get_transient('your_prefix_' . $key);
    
    if (false === $cached_data) {
        // Generate expensive data
        $cached_data = your_prefix_expensive_operation();
        
        // Cache for 1 hour
        set_transient('your_prefix_' . $key, $cached_data, $expiration);
    }
    
    return $cached_data;
}
```

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
