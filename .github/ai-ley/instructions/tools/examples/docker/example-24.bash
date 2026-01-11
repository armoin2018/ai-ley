# Clean build without cache
docker build --no-cache -t myapp .

# Check build context size
du -sh .
# Optimize with .dockerignore

# Debug build step by step
docker build --target builder -t myapp:debug .
docker run -it myapp:debug /bin/sh

# Check base image
docker pull node:18-alpine
docker run -it node:18-alpine /bin/sh