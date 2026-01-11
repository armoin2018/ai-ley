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