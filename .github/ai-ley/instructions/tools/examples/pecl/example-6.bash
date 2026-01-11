# Extension Performance Configuration
# Redis Performance Tuning
cat > /etc/php/8.1/mods-available/redis-optimized.conf << 'EOF'
extension=redis.so

; Performance optimizations
redis.arrays.autorehash = 1
redis.arrays.retries = 3
redis.arrays.lazyconnect = 1

; Connection pooling
redis.pconnect.pooling_enabled = 1
redis.pconnect.connection_limit = 100

; Serialization optimization
redis.serializer = igbinary  ; or php, json
redis.compression = lz4      ; or lzf, zstd
EOF

# APCu Configuration for Optimal Performance
cat > /etc/php/8.1/mods-available/apcu-optimized.conf << 'EOF'
extension=apcu.so

; Memory allocation (adjust based on server memory)
apc.shm_size = 256M
apc.shm_segments = 1

; Cache optimization
apc.ttl = 7200
apc.user_ttl = 7200
apc.gc_ttl = 3600

; Performance tuning
apc.mmap_file_mask = /tmp/apc.XXXXXX
apc.slam_defense = 1
apc.enable_cli = 1

; Monitoring
apc.stat = 0  ; Disable for production (improves performance)
apc.preload_path = /var/www/app/preload.php
EOF

# MongoDB Performance Configuration
cat > /etc/php/8.1/mods-available/mongodb-optimized.conf << 'EOF'
extension=mongodb.so

; Connection optimization
mongodb.debug = 0
mongodb.max_execution_time = 30

; Logging configuration (disable in production)
mongodb.command_logging = 0
mongodb.query_logging = 0
EOF