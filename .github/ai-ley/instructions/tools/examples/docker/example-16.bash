# Essential Docker commands
docker version                        # Show Docker version info
docker info                          # Display system-wide information
docker ps                            # List running containers
docker ps -a                         # List all containers
docker images                        # List images

# Container management
docker run -d --name myapp nginx     # Run container in background
docker start myapp                   # Start stopped container
docker stop myapp                    # Stop running container
docker restart myapp                 # Restart container
docker rm myapp                      # Remove container
docker exec -it myapp bash          # Execute command in running container

# Image management
docker build -t myapp:latest .       # Build image from Dockerfile
docker pull nginx:alpine             # Pull image from registry
docker push myregistry/myapp:latest  # Push image to registry
docker rmi myapp:latest              # Remove image
docker tag myapp:latest myapp:v1.0   # Tag image

# Docker Compose commands
docker compose up                    # Start services
docker compose up -d                 # Start services in background
docker compose down                  # Stop and remove services
docker compose build                 # Build services
docker compose logs -f               # Follow logs
docker compose exec web bash         # Execute command in service

# System maintenance
docker system df                     # Show disk usage
docker system prune                  # Remove unused data
docker system prune -a               # Remove all unused data
docker volume prune                  # Remove unused volumes
docker network prune                 # Remove unused networks

# Development and debugging
docker logs myapp                    # View container logs
docker logs -f myapp                 # Follow container logs
docker inspect myapp                 # Detailed container information
docker stats                        # Live resource usage statistics
docker top myapp                     # Running processes in container

# Registry operations
docker login                        # Login to Docker registry
docker logout                       # Logout from registry
docker search nginx                 # Search Docker Hub for images
docker history myapp:latest         # Show image history

# Advanced operations
docker commit myapp myapp:snapshot   # Create image from container
docker export myapp > myapp.tar      # Export container filesystem
docker import myapp.tar myapp:latest # Import container filesystem
docker save myapp:latest > myapp.tar # Save image to tar archive
docker load < myapp.tar              # Load image from tar archive