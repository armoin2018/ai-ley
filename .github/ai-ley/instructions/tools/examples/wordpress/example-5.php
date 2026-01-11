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