# Diagnose conflicts
composer why-not vendor/package 2.0

# Show dependency tree
composer depends vendor/package

# Try different versions
composer require vendor/package:^1.0 --with-dependencies

# Force update with conflicts
composer update --with-dependencies --ignore-platform-reqs