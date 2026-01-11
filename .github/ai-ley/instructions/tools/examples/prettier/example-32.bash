# Debug configuration loading
prettier --find-config-path src/component.js

# Debug why file is ignored
prettier --debug-check src/component.js

# Check what files will be formatted
prettier --list-different .

# Debug plugin loading
prettier --debug-print-doc src/component.js