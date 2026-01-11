-- Monitor active locks
SELECT
    l.pid,
    l.mode,
    l.granted,
    c.relname,
    a.query
FROM pg_locks l
JOIN pg_class c ON l.relation = c.oid
JOIN pg_stat_activity a ON l.pid = a.pid
WHERE NOT l.granted;