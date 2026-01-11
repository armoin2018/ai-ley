// scripts/deploy.js
const { ethers } = require('hardhat');

async function main() {
  const [deployer] = await ethers.getSigners();

  console.log('Deploying contracts with account:', deployer.address);
  console.log('Account balance:', (await deployer.getBalance()).toString());

  // Deploy contract
  const MyContract = await ethers.getContractFactory('MyContract');
  const contract = await MyContract.deploy();
  await contract.deployed();

  console.log('Contract deployed to:', contract.address);

  // Verify deployment
  const owner = await contract.owner();
  console.log('Contract owner:', owner);

  // Save deployment info
  const deploymentInfo = {
    contractAddress: contract.address,
    deployer: deployer.address,
    blockNumber: contract.deployTransaction.blockNumber,
    gasUsed: contract.deployTransaction.gasLimit.toString(),
  };

  console.log('Deployment info:', deploymentInfo);
}

main()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });