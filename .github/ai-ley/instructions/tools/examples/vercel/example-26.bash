# Verbose deployment
vercel --debug

# Local development with debug
DEBUG=* vercel dev

# Function debugging
vercel logs --follow

# Build debugging
vercel build --debug