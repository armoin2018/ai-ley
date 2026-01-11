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