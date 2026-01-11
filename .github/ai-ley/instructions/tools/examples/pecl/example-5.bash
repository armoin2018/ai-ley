# Development Environment Setup
sudo apt-get install -y \
    php-dev \
    build-essential \
    autoconf \
    libtool \
    pkg-config \
    git

# Create development workspace
mkdir -p /opt/php-extensions
cd /opt/php-extensions

# Clone PECL extension development template
git clone https://github.com/php/pecl-template.git my-extension
cd my-extension

# Extension Building Process
phpize                                  # Prepare build environment
./configure                            # Configure build options
make                                   # Compile extension
make test                              # Run extension tests
sudo make install                      # Install extension

# Development Testing
cat > test_extension.php << 'EOF'
<?php
if (extension_loaded('my_extension')) {
    echo "Extension loaded successfully\n";
    
    // Test extension functionality
    $result = my_extension_function();
    var_dump($result);
} else {
    echo "Extension not loaded\n";
}
EOF

php test_extension.php