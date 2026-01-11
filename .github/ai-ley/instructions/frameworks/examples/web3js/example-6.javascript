// Contract ABI (from compilation output)
const contractABI = [
  {
    "inputs": [{"name": "_initialSupply", "type": "uint256"}],
    "name": "constructor",
    "type": "constructor"
  },
  {
    "inputs": [{"name": "_to", "type": "address"}, {"name": "_value", "type": "uint256"}],
    "name": "transfer",
    "outputs": [{"name": "", "type": "bool"}],
    "type": "function"
  }
];

// Create contract instance
const contract = new web3.eth.Contract(contractABI, contractAddress);

// Read-only call (no gas required)
const balance = await contract.methods.balanceOf(userAddress).call();

// Transaction (requires gas and signing)
const receipt = await contract.methods
  .transfer(recipientAddress, web3.utils.toWei('10', 'ether'))
  .send({ from: userAddress, gas: 100000 });

// Listen to events
contract.events.Transfer({
  filter: { from: userAddress }
}, (error, event) => {
  if (error) console.error(error);
  console.log('Transfer event:', event);
});