# MariaDB command-line tools
mysql -u username -p database_name
mysqladmin -u root -p status
mysqldump -u root -p --databases mydb > backup.sql
mysqlcheck -u root -p --optimize --all-databases

# Performance monitoring
mysqladmin -u root -p extended-status
mysqladmin -u root -p processlist