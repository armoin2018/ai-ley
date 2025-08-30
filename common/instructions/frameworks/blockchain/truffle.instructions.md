---
applyTo: 'truffle, truffle-cli'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Truffle v5.11+ with Ganache and modern Solidity'
---

# Truffle Framework Instructions for AI Agents

## When to Use Truffle

Use Truffle when you need:

- Comprehensive smart contract development suite with built-in tools
- Established workflow for Ethereum dApp development
- Rich testing framework with JavaScript/Solidity tests
- Migration system for contract deployment across networks
- Integration with popular tools like Ganache and MetaMask
- Teams familiar with traditional development workflows
- Complex project structures with multiple contracts
- Support for multiple blockchain networks

## When to Avoid Truffle

Consider alternatives when:

- Building modern projects (Hardhat offers better TypeScript support)
- Need advanced debugging capabilities (Hardhat provides better error traces)
- Working with newer Ethereum features (Hardhat has faster adoption)
- Require plugin ecosystem (Hardhat has more extensive plugins)
- Building DeFi protocols (Foundry offers better testing performance)
- Team prefers configuration-free setup (Hardhat is more opinionated)

## Framework Overview

- **Framework**: Truffle v5.11+
- **Type**: Ethereum smart contract development framework
- **Architecture**: CLI-based development suite with compilation, testing, and deployment
- **Language**: Solidity for contracts, JavaScript/TypeScript for tests and migrations
- **Use Cases**: Smart contracts, DApps, token development, DeFi protocols

## Installation & Setup

### ✅ Recommended: Global Truffle CLI

```bash
# Install Truffle globally
npm install -g truffle

# Verify installation
truffle version

# Create new project
mkdir my-dapp && cd my-dapp
truffle init

# Or use Truffle Box (pre-configured templates)
truffle unbox metacoin
truffle unbox react  # React frontend included
```

### Alternative: Local Installation

```bash
# Install locally in project
npm init -y
npm install --save-dev truffle

# Use with npx
npx truffle init
```

## Project Structure

```
my-dapp/
├── contracts/              # Solidity smart contracts
│   ├── Migrations.sol      # Migration tracking contract
│   └── MyContract.sol      # Your custom contracts
├── migrations/             # Deployment scripts
│   ├── 1_initial_migration.js
│   └── 2_deploy_contracts.js
├── test/                   # Test files
│   ├── TestMyContract.sol  # Solidity tests
│   └── mycontract.js       # JavaScript tests
├── build/                  # Compiled contract artifacts (auto-generated)
│   └── contracts/
├── truffle-config.js       # Main configuration file
└── package.json           # Node.js dependencies
```

## Core Concepts

### Smart Contract Development

- **Purpose**: Write, compile, and deploy Solidity contracts
- **Usage**: Place contracts in `contracts/` directory

```solidity
// contracts/MyToken.sol
pragma solidity ^0.8.19;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract MyToken is ERC20, Ownable {
    constructor(uint256 initialSupply) ERC20("MyToken", "MTK") {
        _mint(msg.sender, initialSupply * 10**decimals());
    }

    function mint(address to, uint256 amount) public onlyOwner {
        _mint(to, amount);
    }
}
```

### Migrations System

- **Purpose**: Automated deployment and versioning of contracts
- **Usage**: Create sequential migration files for deployment

```javascript
// migrations/2_deploy_contracts.js
const MyToken = artifacts.require("MyToken");

module.exports = function (deployer, network, accounts) {
  const initialSupply = 1000000; // 1 million tokens
  
  deployer.deploy(MyToken, initialSupply).then(() => {
    console.log("MyToken deployed at:", MyToken.address);
  });
};
```

### Testing Framework

- **Purpose**: Comprehensive testing with JavaScript and Solidity
- **Usage**: Create tests in `test/` directory

```javascript
// test/mytoken.test.js
const MyToken = artifacts.require("MyToken");

contract("MyToken", (accounts) => {
  let myTokenInstance;
  const [owner, user1, user2] = accounts;
  const initialSupply = 1000000;

  beforeEach(async () => {
    myTokenInstance = await MyToken.new(initialSupply, { from: owner });
  });

  it("should have correct initial supply", async () => {
    const totalSupply = await myTokenInstance.totalSupply();
    assert.equal(totalSupply.toNumber(), initialSupply * 10**18);
  });

  it("should mint tokens correctly", async () => {
    const mintAmount = 1000;
    await myTokenInstance.mint(user1, mintAmount, { from: owner });
    
    const balance = await myTokenInstance.balanceOf(user1);
    assert.equal(balance.toNumber(), mintAmount);
  });
});
```

## ✅ Best Practices

### Project Configuration

```javascript
// truffle-config.js
const HDWalletProvider = require('@truffle/hdwallet-provider');

module.exports = {
  networks: {
    development: {
      host: "127.0.0.1",
      port: 8545,
      network_id: "*",
      gas: 6721975,
      gasPrice: 20000000000
    },
    
    sepolia: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC,
        `https://sepolia.infura.io/v3/${process.env.INFURA_PROJECT_ID}`
      ),
      network_id: 11155111,
      gas: 4500000,
      gasPrice: 10000000000
    },
    
    mainnet: {
      provider: () => new HDWalletProvider(
        process.env.MNEMONIC,
        `https://mainnet.infura.io/v3/${process.env.INFURA_PROJECT_ID}`
      ),
      network_id: 1,
      gas: 5500000,
      gasPrice: 20000000000,
      skipDryRun: true
    }
  },

  compilers: {
    solc: {
      version: "0.8.19",
      settings: {
        optimizer: {
          enabled: true,
          runs: 200
        }
      }
    }
  },

  plugins: ["truffle-plugin-verify"],
  
  api_keys: {
    etherscan: process.env.ETHERSCAN_API_KEY
  }
};
```

### Development Workflow

```bash
# Start local blockchain (Ganache)
ganache-cli --deterministic --accounts 10 --host 0.0.0.0

# Compile contracts
truffle compile

# Run tests
truffle test
truffle test ./test/mytoken.test.js  # Specific test file

# Deploy to development network
truffle migrate

# Deploy to specific network
truffle migrate --network sepolia

# Reset deployment (re-deploy all)
truffle migrate --reset

# Interactive console
truffle console
truffle console --network sepolia
```

### Contract Interaction

```javascript
// truffle console interaction
truffle(development)> let instance = await MyToken.deployed()
truffle(development)> let balance = await instance.balanceOf(accounts[0])
truffle(development)> balance.toString()
truffle(development)> await instance.transfer(accounts[1], 1000)
```

## Common Patterns

### Multi-Contract Deployment

```javascript
// migrations/2_deploy_all_contracts.js
const Token = artifacts.require("MyToken");
const Crowdsale = artifacts.require("MyCrowdsale");
const Vault = artifacts.require("TokenVault");

module.exports = async function(deployer, network, accounts) {
  const [owner, beneficiary] = accounts;
  
  // Deploy token first
  await deployer.deploy(Token, 1000000);
  const token = await Token.deployed();
  
  // Deploy crowdsale with token address
  await deployer.deploy(Crowdsale, token.address, beneficiary);
  const crowdsale = await Crowdsale.deployed();
  
  // Deploy vault with both addresses
  await deployer.deploy(Vault, token.address, crowdsale.address);
  
  console.log("All contracts deployed successfully");
};
```

### Environment-Specific Configuration

```javascript
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
```

### Advanced Testing Patterns

```javascript
// test/integration.test.js
const { expectRevert, expectEvent } = require('@openzeppelin/test-helpers');
const { BN } = require('@openzeppelin/test-helpers/src/setup');

contract("Integration Tests", (accounts) => {
  it("should handle complex workflow", async () => {
    const token = await MyToken.new(1000000);
    
    // Test with expectRevert
    await expectRevert(
      token.mint(accounts[1], 1000, { from: accounts[1] }),
      "Ownable: caller is not the owner"
    );
    
    // Test events
    const receipt = await token.mint(accounts[1], 1000);
    expectEvent(receipt, 'Transfer', {
      from: '0x0000000000000000000000000000000000000000',
      to: accounts[1],
      value: new BN(1000)
    });
  });
});
```

## Integration Points

### Ganache Integration

- **Purpose**: Local blockchain for development and testing
- **Setup**: `npm install -g ganache-cli` or use Ganache GUI
- **Usage**: 
  ```bash
  ganache-cli --deterministic --accounts 10 --host 0.0.0.0 --port 8545
  ```

### OpenZeppelin Integration

- **Purpose**: Secure, audited smart contract templates
- **Setup**: `npm install @openzeppelin/contracts`
- **Usage**: Import contracts and extend functionality
  ```solidity
  import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
  ```

## Version Compatibility

- **Node.js**: 14.x or later (16.x recommended)
- **Solidity**: 0.5.x to 0.8.x (0.8.19+ recommended)
- **Web3.js**: 1.8.x (included with Truffle)
- **Ganache**: 7.x for CLI, 2.x for GUI
- **OpenZeppelin Contracts**: 4.x or 5.x

## Troubleshooting

### Debug Mode

```bash
# Enable detailed logging
truffle compile --debug
truffle migrate --dry-run
truffle test --verbose

# Debug specific transaction
truffle debug <transaction_hash>
```

### Log Analysis

- **Compilation errors**: Check Solidity syntax and imports
- **Migration errors**: Verify network configuration and gas settings
- **Test failures**: Use `console.log` in tests and check gas usage

### Common Error Messages

- **Error**: `Error: Network not found`
  **Cause**: Network name doesn't match truffle-config.js
  **Solution**: Verify network configuration and spelling

- **Error**: `VM Exception while processing transaction: revert`
  **Cause**: Contract execution failed or require() condition not met
  **Solution**: Check contract logic and transaction parameters

- **Error**: `Error: Exceeds block gas limit`
  **Cause**: Contract deployment or function call requires too much gas
  **Solution**: Optimize contract code or increase gas limit in configuration
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
