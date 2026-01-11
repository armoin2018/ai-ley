# Enable verbose logging
yarn install --verbose
yarn --verbose add lodash

# Debug specific operations
yarn config set --home enableTelemetry 0
yarn config set logLevel info

# Check Yarn doctor (Yarn 3+)
yarn dlx @yarnpkg/doctor