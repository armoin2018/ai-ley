# Create new database
sqlite3 database_name.db

# Import SQL script
sqlite3 database_name.db < schema.sql

# Backup database
sqlite3 database_name.db .dump > backup.sql