# Extension Development Tools
phpize --help                          # Show phpize options
php-config --extension-dir             # Show extension directory
php-config --include-dir               # Show include directory

# Debugging Extension Loading
php -d extension=debug_extension.so -m  # Load extension with debug
strace -e trace=file php -m 2>&1 | grep extension  # Trace file operations
ldd /usr/lib/php/20210902/extension.so  # Check shared library dependencies

# Performance Analysis
php -d extension=xdebug.so script.php   # Profile with Xdebug
valgrind --tool=memcheck php script.php # Memory analysis
perf record php script.php              # Performance profiling

# Extension Testing Framework
#!/bin/bash
test_extension() {
    local extension="$1"
    local test_file="tests/${extension}_test.php"
    
    echo "Testing $extension extension..."
    
    # Check if extension is loaded
    if ! php -m | grep -q "^$extension$"; then
        echo "FAIL: Extension $extension not loaded"
        return 1
    fi
    
    # Run specific tests
    if [[ -f "$test_file" ]]; then
        php "$test_file"
        local exit_code=$?
        if [[ $exit_code -eq 0 ]]; then
            echo "PASS: $extension tests completed successfully"
        else
            echo "FAIL: $extension tests failed with exit code $exit_code"
            return 1
        fi
    else
        echo "WARN: No test file found for $extension"
    fi
    
    return 0
}

# Test all installed extensions
for ext in $(pecl list | tail -n +4 | awk '{print $1}'); do
    test_extension "$ext"
done