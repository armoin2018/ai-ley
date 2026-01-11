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