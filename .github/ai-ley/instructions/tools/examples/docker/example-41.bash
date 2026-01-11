# Enable verbose/debug output
docker build --progress=plain --no-cache .
docker run --rm -it --entrypoint=/bin/sh myapp:latest

# Log analysis
docker logs --details <container>
docker inspect <container>