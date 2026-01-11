---
name: 'Web3Js.Instructions'
description: 'Use Web3.'
keywords: [api, batch, account, agents, [concept, architecture, backend, [pattern, analysis, avoid]
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

See [example-1](./examples/web3js/example-1.bash)

### Browser Setup

See [example-2](./examples/web3js/example-2.html)

## Project Structure

See [example-3](./examples/web3js/example-3.txt)

## Core Concepts

### Web3 Instance and Provider

- **Purpose**: Connection to Ethereum network via providers
- **Usage**: Initialize Web3 with appropriate provider

See [example-4](./examples/web3js/example-4.javascript)

### Account Management

- **Purpose**: Handle user accounts and transaction signing
- **Usage**: Manage wallets and account operations

See [example-5](./examples/web3js/example-5.javascript)

### Smart Contract Interaction

- **Purpose**: Deploy and interact with smart contracts
- **Usage**: Create contract instances and call methods

See [example-6](./examples/web3js/example-6.javascript)

## ✅ Best Practices

### Service Layer Architecture

See [example-7](./examples/web3js/example-7.javascript)

### Contract Service Pattern

See [example-8](./examples/web3js/example-8.javascript)

### Error Handling and Retry Logic

See [example-9](./examples/web3js/example-9.javascript)

## Common Patterns

### React Hook Integration

See [example-10](./examples/web3js/example-10.javascript)

### Batch Operations

See [example-11](./examples/web3js/example-11.javascript)

### Event Subscription Management

See [example-12](./examples/web3js/example-12.javascript)

## Integration Points

### MetaMask Integration

- **Purpose**: Browser wallet connectivity for dApps
- **Setup**: Detect and connect to MetaMask provider
- **Usage**: 
  See [example-13](./examples/web3js/example-13.javascript)

### IPFS Integration

- **Purpose**: Decentralized storage for dApp assets
- **Setup**: `npm install ipfs-http-client`
- **Usage**: Store metadata and retrieve via IPFS hashes
  See [example-14](./examples/web3js/example-14.javascript)

## Version Compatibility

- **Node.js**: 14.x or later (18.x recommended)
- **Browsers**: Modern browsers with ES2017+ support
- **TypeScript**: 4.7+ for full type support
- **React**: 16.8+ for hooks support
- **Vue**: 3.x for Composition API
- **Ethereum**: Compatible with all Ethereum networks and EVM chains

## Troubleshooting

### Debug Mode

See [example-15](./examples/web3js/example-15.javascript)

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
See [example-16](./examples/web3js/example-16.txt)[language]
// Example implementation
[code example]
See [example-17](./examples/web3js/example-17.txt)[format]
# Configuration options
[example configuration]
See [example-18](./examples/web3js/example-18.txt)[format]
# Configuration options
[example configuration]
See [example-19](./examples/web3js/example-19.txt)bash
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
See [example-20](./examples/web3js/example-20.txt)bash
[debug commands]
```

### Log Analysis
- [Where to find logs]
- [How to interpret common error messages]

### Common Error Messages
- **Error**: `[error message]`
  **Cause**: [Why this happens]
  **Solution**: [How to fix]

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0

---
version: 1.0.0
updated: 2026-01-10
reviewed: 2026-01-10
score: 3.0
