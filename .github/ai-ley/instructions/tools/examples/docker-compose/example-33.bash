# Debug volume mounts
docker compose exec web ls -la /app
docker inspect myapp_web | grep -A 10 Mounts