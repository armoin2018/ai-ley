# Security-Hardened Extension Configuration
# Xdebug Security (Development only)
cat > /etc/php/8.1/mods-available/xdebug-secure.conf << 'EOF'
zend_extension=xdebug.so

; Enable only in development
xdebug.mode = debug,develop
xdebug.start_with_request = trigger

; Secure remote debugging
xdebug.client_host = 127.0.0.1
xdebug.client_port = 9003
xdebug.discover_client_host = 0

; Security restrictions
xdebug.max_nesting_level = 256
xdebug.max_stack_frames = 100

; File access restrictions
xdebug.file_link_format = ""
xdebug.var_display_max_children = 128
xdebug.var_display_max_data = 512
xdebug.var_display_max_depth = 3
EOF

# Secure Redis Configuration
cat > /etc/php/8.1/mods-available/redis-secure.conf << 'EOF'
extension=redis.so

; Connection security
redis.arrays.auth = "your-secure-password"
redis.session.save_path = "tcp://127.0.0.1:6379?auth=password"

; SSL/TLS support
redis.arrays.consistent = 1
redis.arrays.retries = 3
redis.arrays.connect_timeout = 5
redis.arrays.read_timeout = 5

; Security monitoring
redis.arrays.lazyconnect = 0  ; Force immediate connection validation
EOF