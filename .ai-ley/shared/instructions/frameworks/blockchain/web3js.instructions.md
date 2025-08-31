---
applyTo: 'web3, web3.js, web3js'
agentMode: 'library-specific'
instructionType: 'guide'
guidelines: 'Focus on Web3.js v4.x with TypeScript and modern async patterns'
---

# Web3.js Library Instructions for AI Agents

## When to Use Web3.js

Use Web3.js when you need:

- Direct interaction with Ethereum blockchain from JavaScript/TypeScript
- Frontend dApp development with wallet integration
- Backend services that need blockchain connectivity
- Real-time blockchain event monitoring
- Cross-platform compatibility (browser, Node.js, React Native)
- Established ecosystem with extensive documentation
- Integration with popular frameworks and tools
- Support for multiple providers (HTTP, WebSocket, IPC)

## When to Avoid Web3.js

Consider alternatives when:

- Building React applications (consider Ethers.js for better React integration)
- Need smaller bundle size (Ethers.js is more modular)
- Working with TypeScript-first development (Ethers.js has better TypeScript support)
- Building modern dApps (newer libraries like Viem offer better developer experience)
- Performance-critical applications (consider lighter alternatives)
- Working exclusively with specific L2s (use their native SDKs)

## Framework Overview

- **Library**: Web3.js v4.x
- **Type**: Ethereum JavaScript API library
- **Architecture**: Modular provider-based architecture with plugin system
- **Language**: JavaScript/TypeScript with full type definitions
- **Use Cases**: dApps, wallet integration, smart contract interaction, blockchain monitoring

## Installation & Setup

### ✅ Recommended: Modular Installation

```bash
# Core Web3 with recommended plugins
npm install web3 web3-eth web3-eth-contract

# For Node.js projects
npm install web3 @types/web3  # If using TypeScript

# Specific modules (for smaller bundle size)
npm install web3-core web3-eth web3-utils
```

### Browser Setup

```html
<!-- CDN for browser use -->
<script src="https://cdn.jsdelivr.net/npm/web3@4/dist/web3.min.js"></script>

<!-- Or ES6 modules -->
<script type="module">
  import Web3 from 'https://cdn.skypack.dev/web3@4';
</script>
```

## Project Structure

```
web3-dapp/
├── src/
│   ├── contracts/           # Contract ABIs and addresses
│   │   ├── MyToken.json
│   │   └── addresses.json
│   ├── services/           # Web3 service layer
│   │   ├── web3Service.js
│   │   └── contractService.js
│   ├── utils/              # Utility functions
│   │   ├── web3Utils.js
│   │   └── formatters.js
│   ├── hooks/              # React hooks (if using React)
│   │   └── useWeb3.js
│   └── components/         # UI components
├── config/
│   └── networks.json       # Network configurations
└── package.json
```

## Core Concepts

### Web3 Instance and Provider

- **Purpose**: Connection to Ethereum network via providers
- **Usage**: Initialize Web3 with appropriate provider

```javascript
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
```

### Account Management

- **Purpose**: Handle user accounts and transaction signing
- **Usage**: Manage wallets and account operations

```javascript
// Get accounts
const accounts = await web3.eth.getAccounts();
const primaryAccount = accounts[0];

// Get balance
const balance = await web3.eth.getBalance(primaryAccount);
const balanceEth = web3.utils.fromWei(balance, 'ether');

// Create account from private key
const account = web3.eth.accounts.privateKeyToAccount('0x' + privateKey);
web3.eth.accounts.wallet.add(account);

// Sign transaction
const signedTx = await web3.eth.accounts.signTransaction({
  to: '0x...',
  value: web3.utils.toWei('1', 'ether'),
  gas: 21000,
  gasPrice: await web3.eth.getGasPrice()
}, privateKey);
```

### Smart Contract Interaction

- **Purpose**: Deploy and interact with smart contracts
- **Usage**: Create contract instances and call methods

```javascript
// Contract ABI (from compilation output)
const contractABI = [
  {
    "inputs": [{"name": "_initialSupply", "type": "uint256"}],
    "name": "constructor",
    "type": "constructor"
  },
  {
    "inputs": [{"name": "_to", "type": "address"}, {"name": "_value", "type": "uint256"}],
    "name": "transfer",
    "outputs": [{"name": "", "type": "bool"}],
    "type": "function"
  }
];

// Create contract instance
const contract = new web3.eth.Contract(contractABI, contractAddress);

// Read-only call (no gas required)
const balance = await contract.methods.balanceOf(userAddress).call();

// Transaction (requires gas and signing)
const receipt = await contract.methods
  .transfer(recipientAddress, web3.utils.toWei('10', 'ether'))
  .send({ from: userAddress, gas: 100000 });

// Listen to events
contract.events.Transfer({
  filter: { from: userAddress }
}, (error, event) => {
  if (error) console.error(error);
  console.log('Transfer event:', event);
});
```

## ✅ Best Practices

### Service Layer Architecture

```javascript
// services/web3Service.js
class Web3Service {
  constructor() {
    this.web3 = null;
    this.accounts = [];
    this.networkId = null;
  }

  async initialize() {
    try {
      // Modern dapp browsers
      if (window.ethereum) {
        this.web3 = new Web3(window.ethereum);
        await window.ethereum.request({ method: 'eth_requestAccounts' });
      }
      // Legacy dapp browsers
      else if (window.web3) {
        this.web3 = new Web3(window.web3.currentProvider);
      }
      // Fallback to HTTP provider
      else {
        this.web3 = new Web3(process.env.REACT_APP_INFURA_URL);
      }

      this.accounts = await this.web3.eth.getAccounts();
      this.networkId = await this.web3.eth.net.getId();
      
      return true;
    } catch (error) {
      console.error('Web3 initialization error:', error);
      return false;
    }
  }

  async getBalance(address) {
    const balance = await this.web3.eth.getBalance(address);
    return this.web3.utils.fromWei(balance, 'ether');
  }

  async sendTransaction(to, value, data = '0x') {
    return await this.web3.eth.sendTransaction({
      from: this.accounts[0],
      to,
      value: this.web3.utils.toWei(value, 'ether'),
      data,
      gas: await this.estimateGas(to, value, data)
    });
  }

  async estimateGas(to, value, data) {
    return await this.web3.eth.estimateGas({
      from: this.accounts[0],
      to,
      value: this.web3.utils.toWei(value, 'ether'),
      data
    });
  }
}

export default new Web3Service();
```

### Contract Service Pattern

```javascript
// services/contractService.js
import Web3Service from './web3Service';
import TokenABI from '../contracts/MyToken.json';
import { CONTRACT_ADDRESSES } from '../config/networks.json';

class ContractService {
  constructor() {
    this.tokenContract = null;
  }

  async initialize() {
    if (!Web3Service.web3) {
      await Web3Service.initialize();
    }

    const networkId = await Web3Service.web3.eth.net.getId();
    const contractAddress = CONTRACT_ADDRESSES[networkId]?.MyToken;

    if (!contractAddress) {
      throw new Error(`Contract not deployed on network ${networkId}`);
    }

    this.tokenContract = new Web3Service.web3.eth.Contract(
      TokenABI.abi,
      contractAddress
    );
  }

  async getTokenBalance(address) {
    const balance = await this.tokenContract.methods.balanceOf(address).call();
    return Web3Service.web3.utils.fromWei(balance, 'ether');
  }

  async transferTokens(to, amount) {
    const amountWei = Web3Service.web3.utils.toWei(amount, 'ether');
    
    return await this.tokenContract.methods
      .transfer(to, amountWei)
      .send({ 
        from: Web3Service.accounts[0],
        gas: 100000 
      });
  }

  watchTransferEvents(callback) {
    this.tokenContract.events.Transfer({}, callback);
  }
}

export default new ContractService();
```

### Error Handling and Retry Logic

```javascript
// utils/web3Utils.js
export class Web3Utils {
  static async retryOperation(operation, maxRetries = 3, delay = 1000) {
    for (let i = 0; i < maxRetries; i++) {
      try {
        return await operation();
      } catch (error) {
        if (i === maxRetries - 1) throw error;
        await new Promise(resolve => setTimeout(resolve, delay * (i + 1)));
      }
    }
  }

  static handleError(error) {
    if (error.code === 4001) {
      return 'User rejected the transaction';
    } else if (error.code === -32603) {
      return 'Internal error occurred';
    } else if (error.message.includes('insufficient funds')) {
      return 'Insufficient funds for transaction';
    }
    return error.message || 'Unknown error occurred';
  }

  static formatAddress(address) {
    if (!address) return '';
    return `${address.slice(0, 6)}...${address.slice(-4)}`;
  }

  static isValidAddress(address) {
    return Web3.utils.isAddress(address);
  }
}
```

## Common Patterns

### React Hook Integration

```javascript
// hooks/useWeb3.js
import { useState, useEffect } from 'react';
import Web3Service from '../services/web3Service';

export function useWeb3() {
  const [account, setAccount] = useState(null);
  const [balance, setBalance] = useState('0');
  const [networkId, setNetworkId] = useState(null);
  const [isConnected, setIsConnected] = useState(false);

  useEffect(() => {
    const initWeb3 = async () => {
      try {
        const connected = await Web3Service.initialize();
        if (connected) {
          setAccount(Web3Service.accounts[0]);
          setNetworkId(Web3Service.networkId);
          setIsConnected(true);
          
          const balance = await Web3Service.getBalance(Web3Service.accounts[0]);
          setBalance(balance);
        }
      } catch (error) {
        console.error('Web3 initialization failed:', error);
      }
    };

    initWeb3();

    // Listen for account changes
    if (window.ethereum) {
      window.ethereum.on('accountsChanged', (accounts) => {
        setAccount(accounts[0] || null);
        setIsConnected(accounts.length > 0);
      });

      window.ethereum.on('chainChanged', (chainId) => {
        setNetworkId(parseInt(chainId, 16));
      });
    }

    return () => {
      if (window.ethereum) {
        window.ethereum.removeAllListeners('accountsChanged');
        window.ethereum.removeAllListeners('chainChanged');
      }
    };
  }, []);

  return { account, balance, networkId, isConnected };
}
```

### Batch Operations

```javascript
// Batch multiple calls efficiently
const batch = new web3.BatchRequest();

batch.add(web3.eth.getBalance.request(address1, 'latest'));
batch.add(web3.eth.getBalance.request(address2, 'latest'));
batch.add(contract.methods.balanceOf(address1).call.request());

const results = await batch.execute();
```

### Event Subscription Management

```javascript
class EventManager {
  constructor(web3) {
    this.web3 = web3;
    this.subscriptions = new Map();
  }

  subscribe(eventName, contract, options, callback) {
    const subscription = contract.events[eventName](options, callback);
    this.subscriptions.set(eventName, subscription);
    return subscription;
  }

  unsubscribe(eventName) {
    const subscription = this.subscriptions.get(eventName);
    if (subscription) {
      subscription.unsubscribe();
      this.subscriptions.delete(eventName);
    }
  }

  unsubscribeAll() {
    this.subscriptions.forEach((subscription) => {
      subscription.unsubscribe();
    });
    this.subscriptions.clear();
  }
}
```

## Integration Points

### MetaMask Integration

- **Purpose**: Browser wallet connectivity for dApps
- **Setup**: Detect and connect to MetaMask provider
- **Usage**: 
  ```javascript
  if (window.ethereum && window.ethereum.isMetaMask) {
    await window.ethereum.request({ method: 'eth_requestAccounts' });
  }
  ```

### IPFS Integration

- **Purpose**: Decentralized storage for dApp assets
- **Setup**: `npm install ipfs-http-client`
- **Usage**: Store metadata and retrieve via IPFS hashes
  ```javascript
  import { create } from 'ipfs-http-client';
  const ipfs = create({ url: 'https://ipfs.infura.io:5001' });
  ```

## Version Compatibility

- **Node.js**: 14.x or later (18.x recommended)
- **Browsers**: Modern browsers with ES2017+ support
- **TypeScript**: 4.7+ for full type support
- **React**: 16.8+ for hooks support
- **Vue**: 3.x for Composition API
- **Ethereum**: Compatible with all Ethereum networks and EVM chains

## Troubleshooting

### Debug Mode

```javascript
// Enable debug logging
const web3 = new Web3(provider, {
  debug: true,
  timeout: 20000
});

// Manual transaction debugging
const txHash = '0x...';
const receipt = await web3.eth.getTransactionReceipt(txHash);
const transaction = await web3.eth.getTransaction(txHash);
```

### Log Analysis

- **Network errors**: Check provider URL and connectivity
- **Transaction failures**: Examine gas limits and contract state
- **MetaMask issues**: Check browser console for wallet errors

### Common Error Messages

- **Error**: `Provider not set or invalid`
  **Cause**: Web3 instance not properly initialized with provider
  **Solution**: Ensure provider is set before making calls

- **Error**: `User denied transaction signature`
  **Cause**: User rejected transaction in wallet
  **Solution**: Handle error gracefully and prompt user to retry

- **Error**: `Insufficient funds for gas * price + value`
  **Cause**: Account doesn't have enough ETH for transaction
  **Solution**: Check balance and reduce transaction value or gas price
- **Example**: [Code example]

### [Concept 2]
- **Purpose**: [What this concept does]
- **Usage**: [How to implement/use it]
- **Example**: [Code example]

## Development Workflow
1. **Setup**: [Initial project setup steps]
2. **Development**: [Development server, hot reload, etc.]
3. **Testing**: [Testing framework and commands]
4. **Building**: [Build process and commands]
5. **Deployment**: [Deployment strategies]

## Best Practices
- [Best practice 1 with explanation]
- [Best practice 2 with explanation]
- [Best practice 3 with explanation]

## Common Patterns
### [Pattern Name]
```[language]
// Example implementation
[code example]
```

### [Pattern Name]
```[language]
// Example implementation
[code example]
```

## Configuration
### [Config File 1]
```[format]
# Configuration options
[example configuration]
```

### [Config File 2]
```[format]
# Configuration options
[example configuration]
```

## Essential Commands
```bash
# Development
[dev server command]

# Testing
[test command]

# Building
[build command]

# Linting
[lint command]

# Package management
[install dependencies]
[add new package]
[update packages]
```

## Common Issues & Solutions
### [Issue 1]
**Problem**: [Description of the problem]
**Solution**: [How to solve it]

### [Issue 2]
**Problem**: [Description of the problem]
**Solution**: [How to solve it]

## Performance Optimization
- [Optimization technique 1]
- [Optimization technique 2]
- [Optimization technique 3]

## Security Considerations
- [Security best practice 1]
- [Security best practice 2]
- [Security best practice 3]

## Useful Resources
- **Official Documentation**: [URL]
- **Community Resources**: [URLs]
- **Learning Materials**: [URLs]
- **Tools & Extensions**: [List of helpful tools]

## Framework-Specific Guidelines
### Code Style
- [Coding conventions specific to this framework]
- [Naming conventions]
- [File organization patterns]

### Architecture Patterns
- [Recommended architectural patterns]
- [State management approaches]
- [Component/module organization]

## Integration Points
### [External Service/Tool 1]
- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

### [External Service/Tool 2]
- **Purpose**: [What it integrates with]
- **Setup**: [How to configure]
- **Usage**: [Implementation examples]

## Version Compatibility
- **Node.js**: [Supported versions]
- **Dependencies**: [Key dependency versions]
- **Browser Support**: [If applicable]
- **OS Support**: [If applicable]

## Troubleshooting
### Debug Mode
```bash
[debug commands]
```

### Log Analysis
- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages
- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]
