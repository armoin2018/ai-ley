# Enable debug logging
export COMPOSE_LOG_LEVEL=DEBUG
docker compose up

# Validate configuration
docker compose config
docker compose config --quiet  # Exit code only

# Profile startup time
time docker compose up -d

# Monitor resource usage
docker stats $(docker compose ps -q)