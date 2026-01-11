# Debug network connectivity
docker compose exec web ping db
docker compose exec web nslookup db
docker network ls
docker network inspect myapp_default