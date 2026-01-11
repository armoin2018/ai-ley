global $wpdb;
$user_id = $_GET['user_id']; // Unsanitized input
$result = $wpdb->get_row("SELECT * FROM {$wpdb->users} WHERE ID = $user_id"); // SQL injection risk