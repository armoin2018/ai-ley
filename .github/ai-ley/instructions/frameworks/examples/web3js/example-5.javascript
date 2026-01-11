// Get accounts
const accounts = await web3.eth.getAccounts();
const primaryAccount = accounts[0];

// Get balance
const balance = await web3.eth.getBalance(primaryAccount);
const balanceEth = web3.utils.fromWei(balance, 'ether');

// Create account from private key
const account = web3.eth.accounts.privateKeyToAccount('0x' + privateKey);
web3.eth.accounts.wallet.add(account);

// Sign transaction
const signedTx = await web3.eth.accounts.signTransaction({
  to: '0x...',
  value: web3.utils.toWei('1', 'ether'),
  gas: 21000,
  gasPrice: await web3.eth.getGasPrice()
}, privateKey);