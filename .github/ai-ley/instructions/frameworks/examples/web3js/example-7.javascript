// services/web3Service.js
class Web3Service {
  constructor() {
    this.web3 = null;
    this.accounts = [];
    this.networkId = null;
  }

  async initialize() {
    try {
      // Modern dapp browsers
      if (window.ethereum) {
        this.web3 = new Web3(window.ethereum);
        await window.ethereum.request({ method: 'eth_requestAccounts' });
      }
      // Legacy dapp browsers
      else if (window.web3) {
        this.web3 = new Web3(window.web3.currentProvider);
      }
      // Fallback to HTTP provider
      else {
        this.web3 = new Web3(process.env.REACT_APP_INFURA_URL);
      }

      this.accounts = await this.web3.eth.getAccounts();
      this.networkId = await this.web3.eth.net.getId();
      
      return true;
    } catch (error) {
      console.error('Web3 initialization error:', error);
      return false;
    }
  }

  async getBalance(address) {
    const balance = await this.web3.eth.getBalance(address);
    return this.web3.utils.fromWei(balance, 'ether');
  }

  async sendTransaction(to, value, data = '0x') {
    return await this.web3.eth.sendTransaction({
      from: this.accounts[0],
      to,
      value: this.web3.utils.toWei(value, 'ether'),
      data,
      gas: await this.estimateGas(to, value, data)
    });
  }

  async estimateGas(to, value, data) {
    return await this.web3.eth.estimateGas({
      from: this.accounts[0],
      to,
      value: this.web3.utils.toWei(value, 'ether'),
      data
    });
  }
}

export default new Web3Service();