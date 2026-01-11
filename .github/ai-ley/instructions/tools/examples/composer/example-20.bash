# Enable parallel downloads (Composer 2.0+)
composer config --global process-timeout 600
composer global require hirak/prestissimo  # For Composer 1.x

# Multiple concurrent downloads
composer install --prefer-dist --no-progress