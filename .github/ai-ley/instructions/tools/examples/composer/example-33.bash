# Install analysis tools
composer require --dev phpstan/phpstan
composer require --dev vimeo/psalm

# Configure phpstan.neon
parameters:
    level: 8
    paths:
        - src
    excludePaths:
        - src/legacy

# Configure psalm.xml
<?xml version="1.0"?>
<psalm totallyTyped="false">
    <projectFiles>
        <directory name="src" />
        <ignoreFiles>
            <directory name="vendor" />
        </ignoreFiles>
    </projectFiles>
</psalm>

# Add to composer scripts
"scripts": {
    "analyze": [
        "phpstan analyse",
        "psalm --show-info=true"
    ]
}