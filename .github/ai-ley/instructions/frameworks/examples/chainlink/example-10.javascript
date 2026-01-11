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