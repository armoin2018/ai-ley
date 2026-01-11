# Start services
docker compose up                    # Foreground
docker compose up -d                 # Background (detached)
docker compose up --build            # Rebuild images
docker compose up web db             # Start specific services

# Stop services
docker compose down                  # Stop and remove containers
docker compose down -v              # Also remove volumes
docker compose down --rmi all       # Also remove images
docker compose stop                 # Stop without removing

# View status and logs
docker compose ps                    # List running services
docker compose logs                 # View all logs
docker compose logs -f web          # Follow logs for web service
docker compose top                  # Show running processes

# Service management
docker compose start web            # Start specific service
docker compose stop web             # Stop specific service
docker compose restart web          # Restart specific service
docker compose pause web            # Pause service
docker compose unpause web          # Unpause service