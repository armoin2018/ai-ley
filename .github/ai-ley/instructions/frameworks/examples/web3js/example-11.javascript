// Batch multiple calls efficiently
const batch = new web3.BatchRequest();

batch.add(web3.eth.getBalance.request(address1, 'latest'));
batch.add(web3.eth.getBalance.request(address2, 'latest'));
batch.add(contract.methods.balanceOf(address1).call.request());

const results = await batch.execute();