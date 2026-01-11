// hardhat.config.js
require('dotenv').config();

const config = {
  solidity: '0.8.19',
  networks: {
    // Testnets
    goerli: {
      url: `https://goerli.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: [process.env.TESTNET_PRIVATE_KEY],
      gasPrice: 20000000000, // 20 gwei
      gas: 2000000,
    },
    sepolia: {
      url: `https://sepolia.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: [process.env.TESTNET_PRIVATE_KEY],
      gasPrice: 20000000000,
    },

    // Mainnet
    mainnet: {
      url: `https://mainnet.infura.io/v3/${process.env.INFURA_PROJECT_ID}`,
      accounts: [process.env.DEPLOYER_PRIVATE_KEY],
      gasPrice: 30000000000, // 30 gwei
      gas: 2000000,
    },

    // Layer 2 Networks
    polygon: {
      url: 'https://polygon-rpc.com/',
      accounts: [process.env.DEPLOYER_PRIVATE_KEY],
      gasPrice: 30000000000,
    },
    arbitrum: {
      url: 'https://arb1.arbitrum.io/rpc',
      accounts: [process.env.DEPLOYER_PRIVATE_KEY],
    },
  },
  etherscan: {
    apiKey: process.env.ETHERSCAN_API_KEY,
  },
};

module.exports = config;