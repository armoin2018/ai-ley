# Download and install globally (recommended)
php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
php composer-setup.php --install-dir=/usr/local/bin --filename=composer
php -r "unlink('composer-setup.php');"

# Verify installation
composer --version

# macOS installation via Homebrew
brew install composer

# Windows installation via Chocolatey
choco install composer

# Ubuntu/Debian installation
curl -sS https://getcomposer.org/installer | php
sudo mv composer.phar /usr/local/bin/composer
sudo chmod +x /usr/local/bin/composer

# Docker installation
docker run --rm -v $(pwd):/app composer:latest install

# Update Composer itself
composer self-update
composer self-update --stable    # Update to latest stable
composer self-update --preview   # Update to development version