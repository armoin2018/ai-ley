# PHP Configuration Integration
# Check PHP configuration files
php --ini
php -m | grep extension_name            # Check if extension is loaded

# Enable extension in php.ini
echo "extension=redis.so" >> /etc/php/8.1/cli/php.ini
echo "extension=mongodb.so" >> /etc/php/8.1/fpm/php.ini

# Extension-specific configuration
cat >> /etc/php/8.1/mods-available/redis.conf << 'EOF'
; Redis extension configuration
extension=redis.so

; Redis session handler
session.save_handler = redis
session.save_path = "tcp://localhost:6379"

; Redis cache configuration
redis.arrays.names = ''
redis.arrays.hosts = ''
redis.arrays.previous = ''
redis.arrays.functions = ''
redis.arrays.index = ''
redis.arrays.autorehash = 0
EOF

# System service integration
systemctl restart php8.1-fpm
systemctl restart apache2  # or nginx