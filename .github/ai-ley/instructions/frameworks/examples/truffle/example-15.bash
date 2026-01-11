# Enable detailed logging
truffle compile --debug
truffle migrate --dry-run
truffle test --verbose

# Debug specific transaction
truffle debug <transaction_hash>