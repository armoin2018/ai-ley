# Check price feed status
npx hardhat run scripts/check-price-feeds.js --network mainnet

# Monitor VRF subscription
npx hardhat run scripts/vrf-status.js --network mainnet

# Test automation upkeep
npx hardhat run scripts/test-automation.js --network mainnet