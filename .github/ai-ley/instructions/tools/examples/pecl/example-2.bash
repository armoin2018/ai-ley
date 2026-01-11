# Extension Installation
pecl install extension_name              # Install latest stable version
pecl install extension_name-1.2.3       # Install specific version
pecl install channel://pecl.php.net/extension_name-1.2.3  # Full channel specification

# Popular Extensions Installation
pecl install redis                      # Redis client extension
pecl install mongodb                    # MongoDB driver
pecl install apcu                       # User cache extension
pecl install memcached                  # Memcached client
pecl install imagick                    # ImageMagick image processing
pecl install xdebug                     # Debugging and profiling
pecl install grpc                       # gRPC framework support
pecl install protobuf                   # Protocol Buffers support

# Extension Management
pecl list                               # List installed extensions
pecl list-all                          # List all available extensions
pecl info extension_name                # Show extension information
pecl upgrade extension_name             # Upgrade extension to latest version
pecl uninstall extension_name           # Remove extension