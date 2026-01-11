---
name: 'Chainlink.Instructions'
description: 'See [example-1](./examples/chainlink/example-1.'
keywords: [api, (vrf), (ccip), aggregation, [concept, agents, architecture, [pattern, analysis, (beta)]
---



# Chainlink Framework Instructions for AI Agents

## When to Use Chainlink

Use Chainlink when you need:

- Real-world data integration into smart contracts (price feeds, weather, sports)
- Decentralized oracle networks for reliable off-chain data
- Verifiable randomness (VRF) for gaming, NFTs, or fair distribution
- Cross-chain interoperability and asset transfers
- Automated smart contract execution (Automation/Keepers)
- Hybrid smart contracts combining on-chain and off-chain computation
- High-stakes DeFi protocols requiring secure price data
- Enterprise blockchain integration with existing APIs and systems

## When to Avoid Chainlink

Consider alternatives when:

- Building simple smart contracts without external data needs
- Working on testnets or learning projects (cost considerations)
- Need real-time data with sub-second latency (oracle updates have delays)
- Budget constraints for oracle service fees
- Working with unsupported blockchains or data sources
- Building applications that require 100% on-chain execution
- Simple automation that can be handled by standard smart contract patterns

## Framework Overview

- **Framework**: Chainlink v2.x
- **Type**: Decentralized oracle network and hybrid smart contract platform
- **Architecture**: Off-chain data aggregation with on-chain verification
- **Language**: Solidity for contracts, JavaScript/TypeScript for automation
- **Use Cases**: Price feeds, VRF, cross-chain, automation, external APIs, hybrid computation

## Installation & Setup

### ✅ Recommended: Chainlink Contracts

See [example-1](./examples/chainlink/example-1.bash)

### Chainlink Functions (Beta)

See [example-2](./examples/chainlink/example-2.bash)

## Project Structure

See [example-3](./examples/chainlink/example-3.txt)

## Core Concepts

### Price Feeds

- **Purpose**: Secure, decentralized price data for DeFi applications
- **Usage**: Integrate reliable asset pricing into smart contracts

See [example-4](./examples/chainlink/example-4.solidity)

### Verifiable Random Function (VRF)

- **Purpose**: Cryptographically secure randomness for blockchain applications
- **Usage**: Fair random number generation for games, lotteries, NFT traits

See [example-5](./examples/chainlink/example-5.solidity)

### Cross-Chain Interoperability Protocol (CCIP)

- **Purpose**: Secure cross-chain communication and token transfers
- **Usage**: Bridge assets and data between different blockchains

See [example-6](./examples/chainlink/example-6.solidity)

## ✅ Best Practices

### Automation Integration

See [example-7](./examples/chainlink/example-7.solidity)

### Multi-Feed Price Aggregation

See [example-8](./examples/chainlink/example-8.solidity)

## Common Patterns

### Chainlink Functions Integration

See [example-9](./examples/chainlink/example-9.javascript)

### VRF Subscription Management

See [example-10](./examples/chainlink/example-10.javascript)

### Error Handling and Monitoring

See [example-11](./examples/chainlink/example-11.solidity)

## Integration Points

### DeFi Protocol Integration

- **Purpose**: Integrate price feeds into lending, trading, and yield protocols
- **Setup**: Use aggregated price data for liquidations and valuations
- **Usage**: 
  See [example-12](./examples/chainlink/example-12.solidity)

### Gaming and NFT Integration

- **Purpose**: Fair randomness for game mechanics and NFT generation
- **Setup**: VRF subscription for random number generation
- **Usage**: 
  See [example-13](./examples/chainlink/example-13.solidity)

## Version Compatibility

- **Solidity**: 0.8.19+ (recommended for latest security features)
- **Node.js**: 16.x or later (18.x recommended)
- **Hardhat**: 2.x for smart contract development
- **Foundry**: Latest version for advanced testing
- **Chainlink Contracts**: v0.8.x (latest stable)

## Troubleshooting

### Debug Mode

See [example-14](./examples/chainlink/example-14.bash)

### Log Analysis

- **Oracle updates**: Monitor price feed update frequency and deviation
- **VRF requests**: Check fulfillment status and gas usage
- **CCIP messages**: Verify cross-chain message delivery status

### Common Error Messages

- **Error**: `Feed not found`
  **Cause**: Price feed address incorrect or not deployed on current network
  **Solution**: Verify feed address from Chainlink documentation for your network

- **Error**: `Insufficient LINK balance`
  **Cause**: Contract doesn't have enough LINK tokens for oracle services
  **Solution**: Fund contract with LINK tokens or use alternative payment methods

- **Error**: `VRF subscription not funded`
  **Cause**: VRF subscription doesn't have sufficient LINK balance
  **Solution**: Add LINK to subscription via VRF coordinator or subscription management interface
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
See [example-15](./examples/chainlink/example-15.txt)[language]
// Example implementation
[code example]
See [example-16](./examples/chainlink/example-16.txt)[format]
# Configuration options
[example configuration]
See [example-17](./examples/chainlink/example-17.txt)[format]
# Configuration options
[example configuration]
See [example-18](./examples/chainlink/example-18.txt)bash
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
See [example-19](./examples/chainlink/example-19.txt)bash
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
