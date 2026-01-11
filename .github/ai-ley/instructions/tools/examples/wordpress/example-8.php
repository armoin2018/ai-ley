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