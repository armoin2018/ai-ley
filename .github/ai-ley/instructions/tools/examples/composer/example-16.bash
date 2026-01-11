# Link local package for development
composer config repositories.local-package path ../my-package
composer require vendor/my-package:dev-master

# Use symlinks for faster development
composer config repositories.local-package '{"type": "path", "url": "../my-package", "options": {"symlink": true}}'

# Remove local repository configuration
composer config --unset repositories.local-package