# Verbose deployment
netlify deploy --debug

# Local development with debug
DEBUG=* netlify dev

# Function debugging
netlify functions:invoke function-name --payload='{"key":"value"}'

# Build debugging
netlify build --debug