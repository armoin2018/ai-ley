---
applyTo: 'chainlink, chainlink-contracts, chainlink-functions'
agentMode: 'framework-specific'
instructionType: 'guide'
guidelines: 'Focus on Chainlink v2.x with modern oracle patterns and hybrid smart contracts'
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

```bash
# Install Chainlink contracts
npm install @chainlink/contracts

# For Hardhat projects
npm install --save-dev @chainlink/contracts @nomiclabs/hardhat-ethers ethers

# For Foundry projects
forge install smartcontractkit/chainlink-brownie-contracts
```

### Chainlink Functions (Beta)

```bash
# Functions toolkit
npm install @chainlink/functions-toolkit

# CLI for Functions development
npm install -g @chainlink/functions-cli
```

## Project Structure

```
chainlink-project/
├── contracts/              # Smart contracts
│   ├── DataConsumer.sol    # Price feed consumer
│   ├── VRFConsumer.sol     # Randomness consumer
│   ├── AutomationTarget.sol # Keeper automation
│   └── CrossChainSender.sol # CCIP integration
├── scripts/                # Deployment and interaction scripts
│   ├── deploy.js          # Contract deployment
│   ├── fund-vrf.js        # VRF subscription funding
│   └── request-data.js    # Data request scripts
├── automation/            # Chainlink Automation
│   ├── upkeep-config.js   # Upkeep configuration
│   └── conditional-logic.js # Custom logic
├── functions/             # Chainlink Functions
│   ├── source.js          # Function source code
│   ├── config.js          # Function configuration
│   └── secrets.js         # API keys and secrets
├── test/                  # Contract tests
├── hardhat.config.js      # Hardhat configuration
└── .env                   # Environment variables
```

## Core Concepts

### Price Feeds

- **Purpose**: Secure, decentralized price data for DeFi applications
- **Usage**: Integrate reliable asset pricing into smart contracts

```solidity
// contracts/PriceConsumer.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract PriceConsumer {
    AggregatorV3Interface internal priceFeed;

    /**
     * Network: Ethereum Mainnet
     * Aggregator: ETH/USD
     * Address: 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419
     */
    constructor() {
        priceFeed = AggregatorV3Interface(0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
    }

    /**
     * Returns the latest price with decimals
     */
    function getLatestPrice() public view returns (int256, uint8) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.latestRoundData();
        
        uint8 decimals = priceFeed.decimals();
        return (price, decimals);
    }

    /**
     * Returns formatted price in USD (18 decimals)
     */
    function getFormattedPrice() public view returns (uint256) {
        (int256 price, uint8 decimals) = getLatestPrice();
        require(price > 0, "Invalid price");
        
        // Convert to 18 decimals
        return uint256(price) * (10 ** (18 - decimals));
    }

    /**
     * Get historical price data
     */
    function getHistoricalPrice(uint80 _roundId) public view returns (int256, uint256) {
        (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) = priceFeed.getRoundData(_roundId);
        
        return (price, timeStamp);
    }
}
```

### Verifiable Random Function (VRF)

- **Purpose**: Cryptographically secure randomness for blockchain applications
- **Usage**: Fair random number generation for games, lotteries, NFT traits

```solidity
// contracts/RandomNumberConsumer.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/vrf/VRFConsumerBaseV2.sol";
import "@chainlink/contracts/src/v0.8/interfaces/VRFCoordinatorV2Interface.sol";

contract RandomNumberConsumer is VRFConsumerBaseV2 {
    VRFCoordinatorV2Interface COORDINATOR;

    // VRF Configuration
    uint64 s_subscriptionId;
    bytes32 keyHash = 0x474e34a077df58807dbe9c96d3c009b23b3c6d0cce433e59bbf5b34f823bc56c; // Ethereum mainnet
    uint32 callbackGasLimit = 100000;
    uint16 requestConfirmations = 3;
    uint32 numWords = 1;

    mapping(uint256 => address) public requestToSender;
    mapping(address => uint256) public userToRandomNumber;

    event RandomNumberRequested(uint256 requestId, address requester);
    event RandomNumberFulfilled(uint256 requestId, uint256 randomNumber);

    constructor(uint64 subscriptionId) VRFConsumerBaseV2(0x271682DEB8C4E0901D1a1550aD2e64D568E69909) {
        COORDINATOR = VRFCoordinatorV2Interface(0x271682DEB8C4E0901D1a1550aD2e64D568E69909);
        s_subscriptionId = subscriptionId;
    }

    /**
     * Request randomness from Chainlink VRF
     */
    function requestRandomWords() external returns (uint256 requestId) {
        requestId = COORDINATOR.requestRandomWords(
            keyHash,
            s_subscriptionId,
            requestConfirmations,
            callbackGasLimit,
            numWords
        );
        
        requestToSender[requestId] = msg.sender;
        emit RandomNumberRequested(requestId, msg.sender);
        
        return requestId;
    }

    /**
     * Callback function used by VRF Coordinator
     */
    function fulfillRandomWords(uint256 _requestId, uint256[] memory _randomWords) internal override {
        address requester = requestToSender[_requestId];
        uint256 randomNumber = _randomWords[0];
        
        userToRandomNumber[requester] = randomNumber;
        emit RandomNumberFulfilled(_requestId, randomNumber);
    }

    /**
     * Get random number in a specific range
     */
    function getRandomInRange(uint256 min, uint256 max) external view returns (uint256) {
        uint256 randomNumber = userToRandomNumber[msg.sender];
        require(randomNumber > 0, "No random number available");
        require(max > min, "Invalid range");
        
        return (randomNumber % (max - min + 1)) + min;
    }
}
```

### Cross-Chain Interoperability Protocol (CCIP)

- **Purpose**: Secure cross-chain communication and token transfers
- **Usage**: Bridge assets and data between different blockchains

```solidity
// contracts/CCIPSender.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts-ccip/src/v0.8/ccip/interfaces/IRouterClient.sol";
import "@chainlink/contracts-ccip/src/v0.8/ccip/libraries/Client.sol";
import "@chainlink/contracts/src/v0.8/shared/access/OwnerIsCreator.sol";
import "@chainlink/contracts/src/v0.8/shared/interfaces/LinkTokenInterface.sol";

contract CCIPSender is OwnerIsCreator {
    IRouterClient private s_router;
    LinkTokenInterface private s_linkToken;

    mapping(uint64 => bool) public allowlistedDestinationChains;
    mapping(address => bool) public allowlistedSenders;

    event MessageSent(
        bytes32 indexed messageId,
        uint64 indexed destinationChainSelector,
        address receiver,
        string text,
        uint256 fees
    );

    constructor(address _router, address _link) {
        s_router = IRouterClient(_router);
        s_linkToken = LinkTokenInterface(_link);
    }

    modifier onlyAllowlistedDestinationChain(uint64 _destinationChainSelector) {
        require(allowlistedDestinationChains[_destinationChainSelector], "Destination chain not allowlisted");
        _;
    }

    function allowlistDestinationChain(uint64 _destinationChainSelector, bool allowed) external onlyOwner {
        allowlistedDestinationChains[_destinationChainSelector] = allowed;
    }

    function sendMessagePayLINK(
        uint64 _destinationChainSelector,
        address _receiver,
        string calldata _text
    ) external onlyAllowlistedDestinationChain(_destinationChainSelector) returns (bytes32 messageId) {
        // Create an EVM2AnyMessage struct in memory with necessary information for sending a cross-chain message
        Client.EVM2AnyMessage memory evm2AnyMessage = _buildCCIPMessage(_receiver, _text, address(s_linkToken));

        // Get the fee required to send the CCIP message
        uint256 fees = s_router.getFee(_destinationChainSelector, evm2AnyMessage);

        require(fees <= s_linkToken.balanceOf(address(this)), "Not enough LINK to pay fees");

        // approve the Router to transfer LINK tokens on contract's behalf. It will spend the fees in LINK
        s_linkToken.approve(address(s_router), fees);

        // Send the message through the router and store the returned message ID
        messageId = s_router.ccipSend(_destinationChainSelector, evm2AnyMessage);

        // Emit an event with message details
        emit MessageSent(messageId, _destinationChainSelector, _receiver, _text, fees);

        // Return the message ID
        return messageId;
    }

    function _buildCCIPMessage(
        address _receiver,
        string calldata _text,
        address _feeTokenAddress
    ) private pure returns (Client.EVM2AnyMessage memory) {
        // Set the token amounts
        Client.EVMTokenAmount[] memory tokenAmounts = new Client.EVMTokenAmount[](0);
        
        // Create an EVM2AnyMessage struct in memory with necessary information for sending a cross-chain message
        return Client.EVM2AnyMessage({
            receiver: abi.encode(_receiver), // ABI-encoded receiver address
            data: abi.encode(_text), // ABI-encoded string
            tokenAmounts: tokenAmounts, // Empty array as no tokens are transferred
            extraArgs: Client._argsToBytes(Client.EVMExtraArgsV1({gasLimit: 200_000})),
            feeToken: _feeTokenAddress
        });
    }
}
```

## ✅ Best Practices

### Automation Integration

```solidity
// contracts/AutomationTarget.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/automation/AutomationCompatible.sol";

contract AutomationTarget is AutomationCompatibleInterface {
    uint256 public counter;
    uint256 public immutable interval;
    uint256 public lastTimeStamp;
    
    mapping(address => uint256) public balances;

    event UpkeepPerformed(uint256 indexed counter, uint256 timestamp);

    constructor(uint256 updateInterval) {
        interval = updateInterval;
        lastTimeStamp = block.timestamp;
        counter = 0;
    }

    function checkUpkeep(bytes calldata checkData) external view override returns (bool upkeepNeeded, bytes memory performData) {
        upkeepNeeded = (block.timestamp - lastTimeStamp) > interval;
        performData = checkData;
    }

    function performUpkeep(bytes calldata performData) external override {
        if ((block.timestamp - lastTimeStamp) > interval) {
            lastTimeStamp = block.timestamp;
            counter = counter + 1;
            
            // Perform automated tasks
            _rebalancePortfolio();
            _updateRewards();
            
            emit UpkeepPerformed(counter, block.timestamp);
        }
    }

    function _rebalancePortfolio() private {
        // Automated portfolio rebalancing logic
        // This could involve calling other contracts, updating ratios, etc.
    }

    function _updateRewards() private {
        // Automated reward distribution logic
        // Calculate and distribute rewards to users
    }

    // Custom upkeep logic with conditions
    function checkConditionalUpkeep(bytes calldata checkData) external view returns (bool upkeepNeeded, bytes memory performData) {
        // Complex conditional logic
        bool conditionMet = _checkMarketConditions() && _checkUserActivity();
        upkeepNeeded = conditionMet && ((block.timestamp - lastTimeStamp) > interval);
        performData = abi.encode(counter, block.timestamp);
    }

    function _checkMarketConditions() private view returns (bool) {
        // Implement market condition checks
        // Could integrate with price feeds
        return true; // Placeholder
    }

    function _checkUserActivity() private view returns (bool) {
        // Check if there's been recent user activity
        return counter > 0; // Placeholder
    }
}
```

### Multi-Feed Price Aggregation

```solidity
// contracts/MultiPriceFeed.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract MultiPriceFeed {
    struct PriceFeed {
        AggregatorV3Interface feed;
        uint8 decimals;
        string name;
        bool isActive;
    }

    mapping(string => PriceFeed) public priceFeeds;
    string[] public feedNames;

    event FeedAdded(string name, address feedAddress);
    event FeedUpdated(string name, bool isActive);

    constructor() {
        // Initialize with common feeds (Ethereum mainnet)
        _addFeed("ETH/USD", 0x5f4eC3Df9cbd43714FE2740f5E3616155c5b8419);
        _addFeed("BTC/USD", 0xF4030086522a5bEEa4988F8cA5B36dbC97BeE88c);
        _addFeed("LINK/USD", 0x2c1d072e956AFFC0D435Cb7AC38EF18d24d9127c);
    }

    function _addFeed(string memory _name, address _feedAddress) private {
        AggregatorV3Interface feed = AggregatorV3Interface(_feedAddress);
        uint8 decimals = feed.decimals();
        
        priceFeeds[_name] = PriceFeed({
            feed: feed,
            decimals: decimals,
            name: _name,
            isActive: true
        });
        
        feedNames.push(_name);
        emit FeedAdded(_name, _feedAddress);
    }

    function getPrice(string memory _feedName) public view returns (int256 price, uint256 timestamp) {
        PriceFeed memory feed = priceFeeds[_feedName];
        require(feed.isActive, "Feed not active");

        (
            uint80 roundID,
            int256 _price,
            uint256 startedAt,
            uint256 _timestamp,
            uint80 answeredInRound
        ) = feed.feed.latestRoundData();

        require(_price > 0, "Invalid price");
        require(_timestamp > 0, "Invalid timestamp");

        return (_price, _timestamp);
    }

    function getFormattedPrice(string memory _feedName) public view returns (uint256) {
        PriceFeed memory feed = priceFeeds[_feedName];
        (int256 price, ) = getPrice(_feedName);
        
        // Convert to 18 decimals
        return uint256(price) * (10 ** (18 - feed.decimals));
    }

    function getPriceRatio(string memory _baseFeed, string memory _quoteFeed) public view returns (uint256) {
        uint256 basePrice = getFormattedPrice(_baseFeed);
        uint256 quotePrice = getFormattedPrice(_quoteFeed);
        
        require(quotePrice > 0, "Invalid quote price");
        return (basePrice * 1e18) / quotePrice;
    }

    function getAllActivePrices() public view returns (string[] memory names, int256[] memory prices, uint256[] memory timestamps) {
        uint256 activeCount = 0;
        
        // Count active feeds
        for (uint256 i = 0; i < feedNames.length; i++) {
            if (priceFeeds[feedNames[i]].isActive) {
                activeCount++;
            }
        }
        
        names = new string[](activeCount);
        prices = new int256[](activeCount);
        timestamps = new uint256[](activeCount);
        
        uint256 index = 0;
        for (uint256 i = 0; i < feedNames.length; i++) {
            if (priceFeeds[feedNames[i]].isActive) {
                names[index] = feedNames[i];
                (prices[index], timestamps[index]) = getPrice(feedNames[i]);
                index++;
            }
        }
    }
}
```

## Common Patterns

### Chainlink Functions Integration

```javascript
// functions/source.js - Functions source code
const source = `
// Fetch data from external API
const url = 'https://api.coinbase.com/v2/exchange-rates?currency=BTC';

try {
  const response = await Functions.makeHttpRequest({
    url: url,
    method: "GET",
    headers: {
      "Authorization": \`Bearer \${secrets.apiKey}\`
    }
  });

  if (response.error) {
    throw new Error(\`API Error: \${response.error}\`);
  }

  const data = response.data;
  const btcPrice = parseFloat(data.data.rates.USD);
  
  // Return price as bytes32
  return Functions.encodeUint256(Math.round(btcPrice * 1e8));
} catch (error) {
  throw new Error(\`Request failed: \${error.message}\`);
}
`;

// functions/config.js - Function configuration
const functionsConfig = {
  source: source,
  secrets: { apiKey: process.env.COINBASE_API_KEY },
  args: [],
  expectedReturnType: "uint256",
  subscriptionId: process.env.FUNCTIONS_SUBSCRIPTION_ID
};

module.exports = { functionsConfig };
```

### VRF Subscription Management

```javascript
// scripts/vrf-subscription-manager.js
const { ethers } = require("hardhat");

async function createSubscription() {
  const VRFCoordinatorV2 = await ethers.getContractAt(
    "VRFCoordinatorV2Interface",
    "0x271682DEB8C4E0901D1a1550aD2e64D568E69909" // Ethereum mainnet
  );

  const tx = await VRFCoordinatorV2.createSubscription();
  const receipt = await tx.wait();
  
  const subscriptionId = receipt.events[0].args.subId;
  console.log("Subscription created with ID:", subscriptionId.toString());
  
  return subscriptionId;
}

async function fundSubscription(subscriptionId, amount) {
  const linkToken = await ethers.getContractAt(
    "LinkTokenInterface",
    "0x514910771AF9Ca656af840dff83E8264EcF986CA" // LINK token mainnet
  );

  const VRFCoordinatorV2 = await ethers.getContractAt(
    "VRFCoordinatorV2Interface",
    "0x271682DEB8C4E0901D1a1550aD2e64D568E69909"
  );

  // Transfer LINK to coordinator and fund subscription
  const fundTx = await linkToken.transferAndCall(
    VRFCoordinatorV2.address,
    ethers.utils.parseEther(amount),
    ethers.utils.defaultAbiCoder.encode(["uint64"], [subscriptionId])
  );

  await fundTx.wait();
  console.log(`Funded subscription ${subscriptionId} with ${amount} LINK`);
}

async function addConsumer(subscriptionId, consumerAddress) {
  const VRFCoordinatorV2 = await ethers.getContractAt(
    "VRFCoordinatorV2Interface",
    "0x271682DEB8C4E0901D1a1550aD2e64D568E69909"
  );

  const tx = await VRFCoordinatorV2.addConsumer(subscriptionId, consumerAddress);
  await tx.wait();
  
  console.log(`Added consumer ${consumerAddress} to subscription ${subscriptionId}`);
}

module.exports = { createSubscription, fundSubscription, addConsumer };
```

### Error Handling and Monitoring

```solidity
// contracts/ChainlinkDataMonitor.sol
// SPDX-License-Identifier: MIT
pragma solidity ^0.8.19;

import "@chainlink/contracts/src/v0.8/interfaces/AggregatorV3Interface.sol";

contract ChainlinkDataMonitor {
    struct FeedStatus {
        bool isStale;
        bool isPriceValid;
        uint256 lastUpdate;
        int256 lastPrice;
        uint256 staleDuration;
    }

    mapping(address => FeedStatus) public feedStatuses;
    mapping(address => uint256) public maxStaleDuration;

    event FeedStatusUpdated(address indexed feed, bool isStale, bool isPriceValid);
    event StaleDataDetected(address indexed feed, uint256 timeSinceUpdate);

    function checkFeedStatus(address _feedAddress) public returns (FeedStatus memory) {
        AggregatorV3Interface feed = AggregatorV3Interface(_feedAddress);
        
        try feed.latestRoundData() returns (
            uint80 roundID,
            int256 price,
            uint256 startedAt,
            uint256 timeStamp,
            uint80 answeredInRound
        ) {
            uint256 timeSinceUpdate = block.timestamp - timeStamp;
            uint256 maxStale = maxStaleDuration[_feedAddress];
            if (maxStale == 0) maxStale = 3600; // Default 1 hour

            bool isStale = timeSinceUpdate > maxStale;
            bool isPriceValid = price > 0 && timeStamp > 0;

            feedStatuses[_feedAddress] = FeedStatus({
                isStale: isStale,
                isPriceValid: isPriceValid,
                lastUpdate: timeStamp,
                lastPrice: price,
                staleDuration: timeSinceUpdate
            });

            if (isStale) {
                emit StaleDataDetected(_feedAddress, timeSinceUpdate);
            }

            emit FeedStatusUpdated(_feedAddress, isStale, isPriceValid);
            return feedStatuses[_feedAddress];
            
        } catch {
            feedStatuses[_feedAddress] = FeedStatus({
                isStale: true,
                isPriceValid: false,
                lastUpdate: 0,
                lastPrice: 0,
                staleDuration: type(uint256).max
            });

            emit FeedStatusUpdated(_feedAddress, true, false);
            return feedStatuses[_feedAddress];
        }
    }

    function setStaleDuration(address _feedAddress, uint256 _duration) external {
        maxStaleDuration[_feedAddress] = _duration;
    }

    function batchCheckFeeds(address[] calldata _feeds) external returns (bool allHealthy) {
        allHealthy = true;
        
        for (uint256 i = 0; i < _feeds.length; i++) {
            FeedStatus memory status = checkFeedStatus(_feeds[i]);
            if (status.isStale || !status.isPriceValid) {
                allHealthy = false;
            }
        }
    }
}
```

## Integration Points

### DeFi Protocol Integration

- **Purpose**: Integrate price feeds into lending, trading, and yield protocols
- **Setup**: Use aggregated price data for liquidations and valuations
- **Usage**: 
  ```solidity
  // Get price with staleness check
  function getSecurePrice(address feed) external view returns (uint256) {
      (uint80 roundID, int256 price, uint256 startedAt, uint256 timeStamp, uint80 answeredInRound) = 
          AggregatorV3Interface(feed).latestRoundData();
      
      require(block.timestamp - timeStamp < 3600, "Price data stale");
      require(price > 0, "Invalid price");
      
      return uint256(price);
  }
  ```

### Gaming and NFT Integration

- **Purpose**: Fair randomness for game mechanics and NFT generation
- **Setup**: VRF subscription for random number generation
- **Usage**: 
  ```solidity
  // Generate random NFT traits
  function mintRandomNFT() external {
      uint256 requestId = requestRandomWords();
      pendingMints[requestId] = msg.sender;
  }
  ```

## Version Compatibility

- **Solidity**: 0.8.19+ (recommended for latest security features)
- **Node.js**: 16.x or later (18.x recommended)
- **Hardhat**: 2.x for smart contract development
- **Foundry**: Latest version for advanced testing
- **Chainlink Contracts**: v0.8.x (latest stable)

## Troubleshooting

### Debug Mode

```bash
# Check price feed status
npx hardhat run scripts/check-price-feeds.js --network mainnet

# Monitor VRF subscription
npx hardhat run scripts/vrf-status.js --network mainnet

# Test automation upkeep
npx hardhat run scripts/test-automation.js --network mainnet
```

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
