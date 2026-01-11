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