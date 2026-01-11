# Execute commands in running containers
docker compose exec web bash                    # Interactive shell
docker compose exec web npm test               # Run tests
docker compose exec -u root web apt update     # Run as root user

# Run one-off commands
docker compose run web npm install             # Install dependencies
docker compose run --rm web npm test          # Run and remove container
docker compose run -p 3001:3000 web npm start # Custom port mapping

# Debugging and inspection
docker compose config                          # Validate and view configuration
docker compose images                          # List images
docker compose port web 3000                  # Show port mapping
docker compose events                          # Show real-time events