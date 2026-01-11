# Static Analysis
npm install -g slither-analyzer
slither contracts/

# Formal Verification (if available)
npm install -g solc-verify
solc-verify contracts/MyContract.sol

# Gas Analysis
npx hardhat test --reporter gas

# Coverage Analysis
npx hardhat coverage