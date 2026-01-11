# Run npm scripts
npm start                   # Runs "start" script
npm test                    # Runs "test" script
npm run build               # Runs "build" script
npm run lint                # Runs custom script

# Run with arguments
npm test -- --watch         # Pass arguments to script
npm run build -- --production

# List available scripts
npm run                     # Show all scripts

# Run multiple scripts
npm run lint && npm run test && npm run build

# Pre and post hooks (automatic)
npm run build               # Runs prebuild, build, postbuild