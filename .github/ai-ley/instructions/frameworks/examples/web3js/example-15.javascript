// Enable debug logging
const web3 = new Web3(provider, {
  debug: true,
  timeout: 20000
});

// Manual transaction debugging
const txHash = '0x...';
const receipt = await web3.eth.getTransactionReceipt(txHash);
const transaction = await web3.eth.getTransaction(txHash);