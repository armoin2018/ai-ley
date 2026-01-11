# Initialize new Hardhat project
mkdir my-smart-contract-project
cd my-smart-contract-project
npm init -y
npm install --save-dev hardhat
npx hardhat init

# Install essential dependencies
npm install --save-dev @nomiclabs/hardhat-waffle @nomiclabs/hardhat-ethers
npm install --save-dev @openzeppelin/contracts @openzeppelin/test-helpers
npm install --save-dev chai ethereum-waffle ethers
npm install --save-dev hardhat-gas-reporter solidity-coverage
npm install --save-dev @nomiclabs/hardhat-etherscan dotenv