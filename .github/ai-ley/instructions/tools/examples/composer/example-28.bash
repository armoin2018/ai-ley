# Increase timeout
composer config process-timeout 600

# Use prefer-dist to download archives instead of cloning
composer install --prefer-dist

# Use different repository mirrors
composer config repositories.packagist composer https://mirrors.cloud.tencent.com/composer/

# Configure proxy
composer config http-proxy http://proxy.company.com:8080