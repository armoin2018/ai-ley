# Create new project with composer.json
composer init

# Interactive project creation
composer init --name="vendor/package" --description="Project description"

# Create project from package template
composer create-project laravel/laravel my-project
composer create-project symfony/skeleton my-app
composer create-project drupal/recommended-project my-site

# Initialize in existing project
touch composer.json