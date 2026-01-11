// Translation functions
$message = __('Hello, World!', 'your-text-domain');
$formatted = sprintf(__('Welcome, %s!', 'your-text-domain'), $username);

// Sanitization
$clean_input = sanitize_text_field($_POST['user_input']);
$clean_email = sanitize_email($_POST['email']);