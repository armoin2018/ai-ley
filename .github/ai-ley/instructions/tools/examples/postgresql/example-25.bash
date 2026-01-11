# Full backup with pg_dump
pg_dump -h localhost -p 5432 -U username -d myapp -f backup.sql

# Compressed backup
pg_dump -h localhost -p 5432 -U username -d myapp | gzip > backup.sql.gz

# Directory format backup (allows parallel restore)
pg_dump -h localhost -p 5432 -U username -d myapp -Fd -f backup_dir

# Continuous archiving (WAL-E or similar)
archive_mode = on
archive_command = 'wal-e wal-push %p'