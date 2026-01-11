// migrations/config.js
const development = {
  gasPrice: 20000000000,
  gas: 6721975
};

const testnet = {
  gasPrice: 10000000000,
  gas: 4500000
};

const mainnet = {
  gasPrice: 50000000000,
  gas: 5000000
};

module.exports = { development, testnet, mainnet };