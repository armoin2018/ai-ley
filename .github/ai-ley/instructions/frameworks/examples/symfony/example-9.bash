# .env
APP_ENV=dev
APP_SECRET=your-secret-key
DATABASE_URL="mysql://root:password@127.0.0.1:3306/symfony_app?serverVersion=8.0"
MAILER_DSN=smtp://localhost:1025
FROM_EMAIL=noreply@example.com

# .env.prod
APP_ENV=prod
APP_DEBUG=false
DATABASE_URL="mysql://user:pass@prod-db:3306/prod_db?serverVersion=8.0"
MAILER_DSN=smtp://smtp.gmail.com:587?encryption=tls&auth_mode=oauth&username=user&password=pass