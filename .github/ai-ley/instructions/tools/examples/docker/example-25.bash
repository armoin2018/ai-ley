# Monitor resource usage
docker stats
docker system df

# Optimize Dockerfile
# Use multi-stage builds
# Minimize layers
# Use .dockerignore

# Set resource limits
docker run --memory=512m --cpus=0.5 myapp

# Check for memory leaks
docker exec container_name ps aux
docker exec container_name top