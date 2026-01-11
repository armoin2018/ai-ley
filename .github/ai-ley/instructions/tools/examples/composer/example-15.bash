# Initialize package structure
mkdir my-package && cd my-package
composer init

# Package composer.json
{
    "name": "vendor/my-package",
    "description": "A useful PHP package",
    "type": "library",
    "license": "MIT",
    "authors": [
        {
            "name": "Your Name",
            "email": "your.email@example.com"
        }
    ],
    "minimum-stability": "stable",
    "require": {
        "php": ">=8.0"
    },
    "require-dev": {
        "phpunit/phpunit": "^10.0"
    },
    "autoload": {
        "psr-4": {
            "Vendor\\MyPackage\\": "src/"
        }
    },
    "autoload-dev": {
        "psr-4": {
            "Vendor\\MyPackage\\Tests\\": "tests/"
        }
    }
}

# Package structure
src/
├── MyClass.php
├── Services/
│   └── MyService.php
└── Contracts/
    └── MyInterface.php
tests/
├── Unit/
│   └── MyClassTest.php
└── Integration/
    └── MyServiceTest.php