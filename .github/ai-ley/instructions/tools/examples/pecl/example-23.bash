# Build and test custom extension
cd /opt/php-extensions/example
phpize
./configure
make
make test
sudo make install

# Create configuration
echo "extension=example.so" > /etc/php/8.1/mods-available/example.ini
phpenmod example

# Test the extension
php -r "echo example_hello('PECL'); echo example_add(2, 3);"