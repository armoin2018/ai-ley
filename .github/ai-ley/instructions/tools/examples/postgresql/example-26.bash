# Full restore from pg_dump
psql -h localhost -p 5432 -U username -d myapp -f backup.sql

# Parallel restore from directory format
pg_restore -h localhost -p 5432 -U username -d myapp -j 4 backup_dir

# Point-in-time recovery setup
restore_command = 'wal-e wal-fetch %f %p'
recovery_target_time = '2024-01-15 14:30:00'