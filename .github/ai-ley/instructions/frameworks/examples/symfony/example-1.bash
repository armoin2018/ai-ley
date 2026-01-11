# Install Symfony CLI
curl -sS https://get.symfony.com/cli/installer | bash

# Create new web application
symfony new my_project --version="7.0.*" --webapp

# Create API-only application
symfony new my_api --version="7.0.*"

# Create microservice
symfony new my_service --version="7.0.*" --minimal

# Start development server
cd my_project
symfony serve -d  # Runs in background