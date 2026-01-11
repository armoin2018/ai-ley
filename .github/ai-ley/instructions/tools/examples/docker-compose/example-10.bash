# Initialize new project with docker-compose.yml
mkdir my-app && cd my-app
touch docker-compose.yml
touch .dockerignore
touch .env

# Basic project structure
mkdir -p {src,config,data,scripts}