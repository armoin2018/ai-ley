# Analyze build performance
docker compose build --progress=plain

# Check container resource usage
docker compose top
docker stats --format "table {{.Container}}\t{{.CPUPerc}}\t{{.MemUsage}}"

# Optimize volume performance (macOS)
# Use :cached or :delegated for better performance
volumes:
  - .:/app:cached
  - /app/node_modules