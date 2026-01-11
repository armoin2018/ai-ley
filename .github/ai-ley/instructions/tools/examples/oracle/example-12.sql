-- Essential daily commands
SELECT * FROM user_tables;              -- List user tables
DESC table_name;                        -- Describe table structure
SELECT * FROM user_sequences;          -- List sequences
SELECT * FROM user_indexes;            -- List indexes

-- System queries
SELECT * FROM v$version;               -- Oracle version
SELECT * FROM v$instance;             -- Instance information
SELECT * FROM user_tab_privs;          -- User privileges