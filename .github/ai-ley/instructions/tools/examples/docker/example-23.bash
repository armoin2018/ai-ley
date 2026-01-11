# Check container logs
docker logs container_name
docker logs -f container_name  # Follow logs

# Check container configuration
docker inspect container_name

# Debug with interactive shell
docker run -it --entrypoint /bin/sh image_name

# Check resource constraints
docker stats container_name
docker system df