# Create secrets directory
mkdir -p secrets
chmod 700 secrets

# Generate secure passwords
openssl rand -base64 32 > secrets/db_password.txt
chmod 600 secrets/db_password.txt

# Use environment-specific secrets
docker compose --env-file .env.prod -f docker-compose.yml -f docker-compose.prod.yml up