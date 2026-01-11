import { Web3 } from 'web3';

// HTTP Provider (most common)
const web3 = new Web3('https://mainnet.infura.io/v3/YOUR_PROJECT_ID');

// WebSocket Provider (for real-time events)
const web3WS = new Web3('wss://mainnet.infura.io/ws/v3/YOUR_PROJECT_ID');

// MetaMask/Browser Provider
if (typeof window !== 'undefined' && window.ethereum) {
  const web3 = new Web3(window.ethereum);
  // Request account access
  await window.ethereum.request({ method: 'eth_requestAccounts' });
}

// Multiple providers for failover
const providers = [
  'https://mainnet.infura.io/v3/PROJECT_ID',
  'https://eth-mainnet.alchemyapi.io/v2/API_KEY',
  'https://cloudflare-eth.com'
];