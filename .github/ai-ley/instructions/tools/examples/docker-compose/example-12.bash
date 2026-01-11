# .env file for development
NODE_ENV=development
API_PORT=3000
DATABASE_URL=postgresql://user:password@db:5432/myapp
REDIS_URL=redis://redis:6379

# Production secrets (use external secret management)
DB_PASSWORD_FILE=/run/secrets/db_password
API_SECRET_KEY_FILE=/run/secrets/api_key