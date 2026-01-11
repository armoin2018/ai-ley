// migrations/2_deploy_contracts.js
const MyToken = artifacts.require("MyToken");

module.exports = function (deployer, network, accounts) {
  const initialSupply = 1000000; // 1 million tokens
  
  deployer.deploy(MyToken, initialSupply).then(() => {
    console.log("MyToken deployed at:", MyToken.address);
  });
};