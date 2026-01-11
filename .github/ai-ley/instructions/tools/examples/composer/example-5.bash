# Global composer configuration
composer config --global repositories.packagist composer https://packagist.org
composer config --global github-oauth.github.com YOUR_GITHUB_TOKEN

# Configure authentication
composer config --global http-basic.repo.packagist.com username password
composer config --global gitlab-token.gitlab.com YOUR_GITLAB_TOKEN

# Performance optimization
composer config --global cache-ttl 86400
composer config --global process-timeout 600
composer config --global optimize-autoloader true

# Platform configuration
composer config --global platform.php 8.1.0