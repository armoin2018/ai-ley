// scripts/production-deploy.js
const { ethers, run } = require('hardhat');

async function main() {
  // Pre-deployment checks
  console.log('🔍 Running pre-deployment checks...');

  const [deployer] = await ethers.getSigners();
  const balance = await deployer.getBalance();
  const gasPrice = await deployer.provider.getGasPrice();

  console.log(`Deployer: ${deployer.address}`);
  console.log(`Balance: ${ethers.utils.formatEther(balance)} ETH`);
  console.log(`Gas Price: ${ethers.utils.formatUnits(gasPrice, 'gwei')} gwei`);

  // Estimate deployment cost
  const MyContract = await ethers.getContractFactory('MyContract');
  const deploymentData = MyContract.getDeployTransaction();
  const estimatedGas = await deployer.estimateGas(deploymentData);
  const estimatedCost = estimatedGas.mul(gasPrice);

  console.log(`Estimated deployment cost: ${ethers.utils.formatEther(estimatedCost)} ETH`);

  if (balance.lt(estimatedCost.mul(120).div(100))) {
    // 20% buffer
    throw new Error('Insufficient balance for deployment');
  }

  // Deploy contract
  console.log('🚀 Deploying contract...');
  const contract = await MyContract.deploy();
  await contract.deployed();

  console.log(`✅ Contract deployed to: ${contract.address}`);
  console.log(`Transaction hash: ${contract.deployTransaction.hash}`);

  // Wait for confirmations
  console.log('⏳ Waiting for confirmations...');
  await contract.deployTransaction.wait(5);

  // Verify on Etherscan
  console.log('🔍 Verifying contract on Etherscan...');
  try {
    await run('verify:verify', {
      address: contract.address,
      constructorArguments: [],
    });
    console.log('✅ Contract verified on Etherscan');
  } catch (error) {
    console.log('❌ Verification failed:', error.message);
  }

  // Final checks
  const owner = await contract.owner();
  console.log(`Contract owner: ${owner}`);
  console.log('🎉 Deployment completed successfully!');
}

main().catch((error) => {
  console.error('❌ Deployment failed:', error);
  process.exit(1);
});