# Enable debug mode in .env
CI_ENVIRONMENT = development

# Check application logs
tail -f writable/logs/log-*.log

# Debug database queries
# Set DBDebug = true in Database config

# Use Spark commands
php spark list
php spark migrate:status
php spark cache:clear