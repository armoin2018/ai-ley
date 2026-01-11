# Start local blockchain (Ganache)
ganache-cli --deterministic --accounts 10 --host 0.0.0.0

# Compile contracts
truffle compile

# Run tests
truffle test
truffle test ./test/mytoken.test.js  # Specific test file

# Deploy to development network
truffle migrate

# Deploy to specific network
truffle migrate --network sepolia

# Reset deployment (re-deploy all)
truffle migrate --reset

# Interactive console
truffle console
truffle console --network sepolia