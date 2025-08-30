---
applyTo: 'ethers, ethers.js, ethersjs'
agentMode: 'library-specific'
instructionType: 'guide'
guidelines: 'Focus on Ethers.js v6.x with TypeScript and modern async patterns'
---

# Ethers.js Library Instructions for AI Agents

## When to Use Ethers.js

Use Ethers.js when you need:

- Modern TypeScript-first Ethereum library with excellent type safety
- Modular architecture with tree-shaking for smaller bundle sizes
- React and modern frontend framework integration
- Clean, promise-based API with async/await support
- ENS (Ethereum Name Service) first-class support
- Better error handling and human-readable error messages
- Security-focused design with safe defaults
- Comprehensive testing and wallet management utilities

## When to Avoid Ethers.js

Consider alternatives when:

- Working with legacy codebases using Web3.js
- Need compatibility with older JavaScript environments
- Existing team expertise with Web3.js ecosystem
- Specific provider requirements that Web3.js handles better
- Working with Truffle (which has deep Web3.js integration)
- Need maximum ecosystem compatibility (Web3.js has broader adoption)

## Framework Overview

- **Library**: Ethers.js v6.x
- **Type**: Complete Ethereum library and wallet implementation
- **Architecture**: Modular, tree-shakeable with provider abstraction
- **Language**: TypeScript with comprehensive type definitions
- **Use Cases**: dApps, wallets, DeFi protocols, NFT platforms, blockchain analytics

## Installation & Setup

### ✅ Recommended: Full Installation

```bash
# Complete ethers.js package
npm install ethers

# For TypeScript projects (types included)
npm install ethers @types/node  # @types/node for Node.js environments
```

### Modular Installation (v6+)

```bash
# Install only needed modules for smaller bundles
npm install ethers/providers ethers/contract ethers/wallet
```

### Browser Setup

```html
<!-- CDN for browser use -->
<script type="module">
  import { ethers } from 'https://cdn.skypack.dev/ethers@6';
</script>

<!-- Or via unpkg -->
<script src="https://unpkg.com/ethers@6/dist/ethers.umd.min.js"></script>
```

## Project Structure

```
ethers-dapp/
├── src/
│   ├── contracts/           # Contract ABIs and typechain generated types
│   │   ├── MyToken.json
│   │   ├── typechain/      # Generated TypeScript types
│   │   └── deployments.json
│   ├── services/           # Ethers service layer
│   │   ├── provider.ts
│   │   ├── signer.ts
│   │   └── contracts.ts
│   ├── hooks/              # React hooks (if using React)
│   │   ├── useProvider.ts
│   │   ├── useSigner.ts
│   │   └── useContract.ts
│   ├── utils/              # Utility functions
│   │   ├── formatters.ts
│   │   └── constants.ts
│   └── types/              # TypeScript type definitions
│       └── index.ts
├── config/
│   └── networks.ts         # Network configurations
└── package.json
```

## Core Concepts

### Providers

- **Purpose**: Connection to Ethereum network for reading blockchain state
- **Usage**: Different provider types for various needs

```typescript
import { ethers } from 'ethers';

// JSON-RPC Provider (Infura, Alchemy, etc.)
const provider = new ethers.JsonRpcProvider('https://mainnet.infura.io/v3/YOUR_PROJECT_ID');

// WebSocket Provider for real-time events
const wsProvider = new ethers.WebSocketProvider('wss://mainnet.infura.io/ws/v3/YOUR_PROJECT_ID');

// Browser Provider (MetaMask, etc.)
const browserProvider = new ethers.BrowserProvider(window.ethereum);

// Multiple providers with fallback
const fallbackProvider = new ethers.FallbackProvider([
  { provider: new ethers.JsonRpcProvider('https://mainnet.infura.io/v3/PROJECT_ID'), weight: 1 },
  { provider: new ethers.JsonRpcProvider('https://eth-mainnet.alchemyapi.io/v2/API_KEY'), weight: 1 },
  { provider: new ethers.CloudflareProvider(), weight: 2 }
]);

// Network information
const network = await provider.getNetwork();
console.log(`Connected to ${network.name} (Chain ID: ${network.chainId})`);
```

### Signers and Wallets

- **Purpose**: Sign transactions and interact with accounts
- **Usage**: Different signer types for various authentication methods

```typescript
// Wallet from private key
const wallet = new ethers.Wallet('0x' + privateKey, provider);

// Browser signer (MetaMask)
const browserProvider = new ethers.BrowserProvider(window.ethereum);
const signer = await browserProvider.getSigner();

// HD Wallet from mnemonic
const hdWallet = ethers.Wallet.fromPhrase(
  'abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon abandon about'
);

// Connect wallet to provider
const connectedWallet = wallet.connect(provider);

// Get wallet information
const address = await signer.getAddress();
const balance = await signer.getBalance();
const balanceEth = ethers.formatEther(balance);
```

### Contract Interaction

- **Purpose**: Deploy and interact with smart contracts
- **Usage**: Type-safe contract interaction with TypeScript

```typescript
// Contract ABI and bytecode
import MyTokenABI from './contracts/MyToken.json';

// Create contract instance (read-only)
const contract = new ethers.Contract(contractAddress, MyTokenABI.abi, provider);

// Contract with signer (can send transactions)
const contractWithSigner = contract.connect(signer);

// Read contract state (no gas required)
const totalSupply = await contract.totalSupply();
const balance = await contract.balanceOf(userAddress);
const name = await contract.name();

// Write to contract (requires gas and signing)
const tx = await contractWithSigner.transfer(
  recipientAddress, 
  ethers.parseEther('10.0')
);
const receipt = await tx.wait(); // Wait for confirmation

// Deploy contract
const contractFactory = new ethers.ContractFactory(
  MyTokenABI.abi,
  MyTokenABI.bytecode,
  signer
);

const deployedContract = await contractFactory.deploy(
  'MyToken',
  'MTK',
  ethers.parseEther('1000000') // Constructor parameters
);
await deployedContract.waitForDeployment();
```

## ✅ Best Practices

### Provider Service Pattern

```typescript
// services/provider.ts
import { ethers } from 'ethers';

export class ProviderService {
  private static instance: ProviderService;
  private provider: ethers.Provider | null = null;
  private signer: ethers.Signer | null = null;

  private constructor() {}

  static getInstance(): ProviderService {
    if (!ProviderService.instance) {
      ProviderService.instance = new ProviderService();
    }
    return ProviderService.instance;
  }

  async initializeProvider(): Promise<ethers.Provider> {
    if (typeof window !== 'undefined' && window.ethereum) {
      // Browser environment
      this.provider = new ethers.BrowserProvider(window.ethereum);
    } else {
      // Server environment or fallback
      this.provider = new ethers.JsonRpcProvider(
        process.env.NEXT_PUBLIC_RPC_URL || 'https://cloudflare-eth.com'
      );
    }
    return this.provider;
  }

  async getSigner(): Promise<ethers.Signer> {
    if (!this.provider) {
      await this.initializeProvider();
    }

    if (this.provider instanceof ethers.BrowserProvider) {
      this.signer = await this.provider.getSigner();
    } else {
      throw new Error('Cannot get signer from non-browser provider');
    }

    return this.signer;
  }

  getProvider(): ethers.Provider {
    if (!this.provider) {
      throw new Error('Provider not initialized');
    }
    return this.provider;
  }

  async getNetwork(): Promise<ethers.Network> {
    return await this.getProvider().getNetwork();
  }

  async getBalance(address: string): Promise<string> {
    const balance = await this.getProvider().getBalance(address);
    return ethers.formatEther(balance);
  }
}
```

### Contract Service with TypeScript

```typescript
// services/contracts.ts
import { ethers } from 'ethers';
import { ProviderService } from './provider';
import MyTokenABI from '../contracts/MyToken.json';

interface TokenContract extends ethers.Contract {
  name(): Promise<string>;
  symbol(): Promise<string>;
  totalSupply(): Promise<bigint>;
  balanceOf(account: string): Promise<bigint>;
  transfer(to: string, amount: bigint): Promise<ethers.ContractTransactionResponse>;
  allowance(owner: string, spender: string): Promise<bigint>;
  approve(spender: string, amount: bigint): Promise<ethers.ContractTransactionResponse>;
}

export class ContractService {
  private providerService: ProviderService;
  private tokenContract: TokenContract | null = null;

  constructor() {
    this.providerService = ProviderService.getInstance();
  }

  async getTokenContract(address: string): Promise<TokenContract> {
    if (!this.tokenContract) {
      const provider = this.providerService.getProvider();
      this.tokenContract = new ethers.Contract(
        address,
        MyTokenABI.abi,
        provider
      ) as TokenContract;
    }
    return this.tokenContract;
  }

  async getTokenInfo(contractAddress: string) {
    const contract = await this.getTokenContract(contractAddress);
    
    const [name, symbol, totalSupply] = await Promise.all([
      contract.name(),
      contract.symbol(),
      contract.totalSupply()
    ]);

    return {
      name,
      symbol,
      totalSupply: ethers.formatEther(totalSupply)
    };
  }

  async transferTokens(
    contractAddress: string,
    to: string,
    amount: string
  ): Promise<ethers.ContractTransactionResponse> {
    const signer = await this.providerService.getSigner();
    const contract = (await this.getTokenContract(contractAddress)).connect(signer);
    
    const amountWei = ethers.parseEther(amount);
    return await contract.transfer(to, amountWei);
  }

  async approveTokens(
    contractAddress: string,
    spender: string,
    amount: string
  ): Promise<ethers.ContractTransactionResponse> {
    const signer = await this.providerService.getSigner();
    const contract = (await this.getTokenContract(contractAddress)).connect(signer);
    
    const amountWei = ethers.parseEther(amount);
    return await contract.approve(spender, amountWei);
  }
}
```

### Error Handling and Utilities

```typescript
// utils/ethers.ts
import { ethers } from 'ethers';

export class EthersUtils {
  static formatAddress(address: string): string {
    if (!ethers.isAddress(address)) return '';
    return `${address.slice(0, 6)}...${address.slice(-4)}`;
  }

  static formatEther(value: bigint, decimals: number = 4): string {
    return parseFloat(ethers.formatEther(value)).toFixed(decimals);
  }

  static parseEtherSafe(value: string): bigint {
    try {
      return ethers.parseEther(value);
    } catch (error) {
      throw new Error(`Invalid ether value: ${value}`);
    }
  }

  static async waitForTransaction(
    tx: ethers.ContractTransactionResponse,
    confirmations: number = 1
  ): Promise<ethers.ContractTransactionReceipt | null> {
    try {
      return await tx.wait(confirmations);
    } catch (error) {
      console.error('Transaction failed:', error);
      throw error;
    }
  }

  static handleError(error: any): string {
    if (error.code === 'ACTION_REJECTED') {
      return 'User rejected the transaction';
    } else if (error.code === 'INSUFFICIENT_FUNDS') {
      return 'Insufficient funds for transaction';
    } else if (error.code === 'NETWORK_ERROR') {
      return 'Network connection error';
    } else if (error.reason) {
      return error.reason;
    }
    return error.message || 'Unknown error occurred';
  }

  static isValidAddress(address: string): boolean {
    return ethers.isAddress(address);
  }

  static getNetworkName(chainId: number): string {
    const networks: { [key: number]: string } = {
      1: 'Ethereum Mainnet',
      11155111: 'Sepolia',
      137: 'Polygon',
      42161: 'Arbitrum One',
      10: 'Optimism'
    };
    return networks[chainId] || `Unknown Network (${chainId})`;
  }
}
```

## Common Patterns

### React Hook Integration

```typescript
// hooks/useEthers.ts
import { useState, useEffect } from 'react';
import { ethers } from 'ethers';
import { ProviderService } from '../services/provider';

export function useEthers() {
  const [provider, setProvider] = useState<ethers.Provider | null>(null);
  const [signer, setSigner] = useState<ethers.Signer | null>(null);
  const [account, setAccount] = useState<string | null>(null);
  const [chainId, setChainId] = useState<number | null>(null);
  const [isConnected, setIsConnected] = useState(false);

  const providerService = ProviderService.getInstance();

  useEffect(() => {
    const initializeEthers = async () => {
      try {
        const provider = await providerService.initializeProvider();
        setProvider(provider);

        if (provider instanceof ethers.BrowserProvider) {
          try {
            const signer = await provider.getSigner();
            const address = await signer.getAddress();
            const network = await provider.getNetwork();

            setSigner(signer);
            setAccount(address);
            setChainId(Number(network.chainId));
            setIsConnected(true);
          } catch (error) {
            // User not connected or rejected
            console.log('User not connected');
          }
        }
      } catch (error) {
        console.error('Failed to initialize ethers:', error);
      }
    };

    initializeEthers();

    // Listen for account changes
    if (window.ethereum) {
      window.ethereum.on('accountsChanged', (accounts: string[]) => {
        if (accounts.length === 0) {
          setAccount(null);
          setSigner(null);
          setIsConnected(false);
        } else {
          setAccount(accounts[0]);
          // Re-initialize signer
          initializeEthers();
        }
      });

      window.ethereum.on('chainChanged', (chainId: string) => {
        setChainId(parseInt(chainId, 16));
        // Re-initialize on network change
        initializeEthers();
      });
    }

    return () => {
      if (window.ethereum) {
        window.ethereum.removeAllListeners('accountsChanged');
        window.ethereum.removeAllListeners('chainChanged');
      }
    };
  }, []);

  const connectWallet = async () => {
    if (window.ethereum) {
      try {
        await window.ethereum.request({ method: 'eth_requestAccounts' });
        const signer = await providerService.getSigner();
        const address = await signer.getAddress();
        
        setSigner(signer);
        setAccount(address);
        setIsConnected(true);
      } catch (error) {
        console.error('Failed to connect wallet:', error);
      }
    }
  };

  return {
    provider,
    signer,
    account,
    chainId,
    isConnected,
    connectWallet
  };
}
```

### Event Listening and Filtering

```typescript
// Event listening patterns
const contract = new ethers.Contract(address, abi, provider);

// Listen to all Transfer events
contract.on('Transfer', (from, to, amount, event) => {
  console.log(`Transfer: ${from} -> ${to}, Amount: ${ethers.formatEther(amount)}`);
});

// Filter events with specific criteria
const filter = contract.filters.Transfer(userAddress, null); // Transfers from userAddress
const events = await contract.queryFilter(filter, -10000); // Last 10000 blocks

// Remove listeners
contract.removeAllListeners('Transfer');

// One-time event listener
contract.once('Transfer', (from, to, amount) => {
  console.log('First transfer detected');
});
```

### Batch Operations and Multicall

```typescript
// Batch multiple read operations
async function batchReadOperations(contract: ethers.Contract, addresses: string[]) {
  const promises = addresses.map(address => contract.balanceOf(address));
  const balances = await Promise.all(promises);
  
  return addresses.map((address, index) => ({
    address,
    balance: ethers.formatEther(balances[index])
  }));
}
```

## Integration Points

### ENS Integration

- **Purpose**: Human-readable Ethereum addresses
- **Setup**: Built into Ethers.js provider
- **Usage**: 
  ```typescript
  const address = await provider.resolveName('vitalik.eth');
  const name = await provider.lookupAddress('0x...');
  ```

### IPFS Integration

- **Purpose**: Decentralized storage for metadata
- **Setup**: `npm install ipfs-http-client`
- **Usage**: Upload and retrieve JSON metadata
  ```typescript
  const metadataHash = await ipfs.add(JSON.stringify(metadata));
  ```

## Version Compatibility

- **Node.js**: 16.x or later (18.x recommended)
- **TypeScript**: 4.7+ for full type support
- **React**: 16.8+ for hooks, 18+ recommended
- **Vue**: 3.x for Composition API
- **Browsers**: Modern browsers with ES2020+ support
- **Ethereum**: All Ethereum networks and EVM-compatible chains

## Troubleshooting

### Debug Mode

```typescript
// Enable debug logging
const provider = new ethers.JsonRpcProvider(url, undefined, {
  staticNetwork: true,
  polling: true
});

// Transaction debugging
const tx = await contract.transfer(to, amount);
console.log('Transaction hash:', tx.hash);
const receipt = await tx.wait();
console.log('Transaction receipt:', receipt);
```

### Log Analysis

- **Provider errors**: Check network connectivity and RPC endpoint
- **Transaction failures**: Examine gas estimation and contract state
- **Type errors**: Ensure proper TypeScript configuration and types

### Common Error Messages

- **Error**: `Could not detect network`
  **Cause**: Provider cannot connect to specified network
  **Solution**: Verify RPC URL and network configuration

- **Error**: `User rejected the request`
  **Cause**: User denied transaction in wallet
  **Solution**: Handle gracefully and allow retry

- **Error**: `Replacement fee too low`
  **Cause**: Attempting to replace transaction with insufficient gas price
  **Solution**: Increase gas price for replacement transaction
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
