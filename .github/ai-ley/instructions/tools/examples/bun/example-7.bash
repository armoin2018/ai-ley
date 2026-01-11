# Run JavaScript/TypeScript files
bun index.js                 # Run JavaScript
bun index.ts                 # Run TypeScript directly
bun src/server.ts           # Run with path

# Run with hot reload
bun --hot src/index.ts      # Auto-restart on changes
bun --watch src/app.ts      # Watch mode

# Run with environment variables
NODE_ENV=production bun start
bun --env-file=.env.local src/index.ts

# Execute from URL
bun https://example.com/script.js

# Execute one-liner
bun -e "console.log('Hello, Bun!')"
bun -p "Math.random()"      # Print result

# Debug mode
bun --inspect src/index.ts  # Enable debugger
bun --inspect-brk src/index.ts  # Break on start