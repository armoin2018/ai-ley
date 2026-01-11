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