# Increase Node.js memory
export NODE_OPTIONS="--max_old_space_size=4096"
node --max_old_space_size=4096 node_modules/.bin/webpack

# Or in package.json scripts
{
  "scripts": {
    "build": "node --max_old_space_size=4096 node_modules/.bin/webpack"
  }
}