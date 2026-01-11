# Multi-platform builds
docker buildx create --name multiarch
docker buildx use multiarch
docker buildx build --platform linux/amd64,linux/arm64 -t myapp:latest .