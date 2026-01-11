# Essential daily commands
docker ps                              # List running containers
docker images                          # List available images
docker logs <container-id>             # View container logs
docker exec -it <container-id> /bin/sh # Access container shell

# Advanced operations
docker system prune                    # Clean up unused resources
docker build --no-cache -t app:latest . # Build without cache
docker run --rm -it app:latest /bin/sh  # Run temporary interactive container