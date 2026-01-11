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