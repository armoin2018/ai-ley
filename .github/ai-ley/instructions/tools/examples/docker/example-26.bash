# Enable Docker debug mode
export DOCKER_DEBUG=1
dockerd --debug

# Verbose build output
docker build --progress=plain --no-cache .

# Container debugging
docker run -it --entrypoint /bin/sh myapp
docker exec -it running_container /bin/sh

# Network debugging
docker network ls
docker network inspect bridge
docker port container_name

# Volume debugging
docker volume ls
docker volume inspect volume_name
docker exec container_name df -h