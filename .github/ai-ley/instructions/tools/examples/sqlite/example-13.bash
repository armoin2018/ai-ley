# Essential daily commands
sqlite3 database.db                     # Open database
.tables                                 # List all tables
.schema table_name                      # Show table schema
.dump                                   # Export database
.read script.sql                        # Execute SQL script

# Advanced operations
.backup backup.db                       # Create backup
.restore backup.db                      # Restore from backup
.mode csv                              # Set output mode
.output file.csv                       # Redirect output
.import file.csv table_name            # Import CSV data