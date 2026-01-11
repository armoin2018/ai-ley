// services/contractService.js
import Web3Service from './web3Service';
import TokenABI from '../contracts/MyToken.json';
import { CONTRACT_ADDRESSES } from '../config/networks.json';

class ContractService {
  constructor() {
    this.tokenContract = null;
  }

  async initialize() {
    if (!Web3Service.web3) {
      await Web3Service.initialize();
    }

    const networkId = await Web3Service.web3.eth.net.getId();
    const contractAddress = CONTRACT_ADDRESSES[networkId]?.MyToken;

    if (!contractAddress) {
      throw new Error(`Contract not deployed on network ${networkId}`);
    }

    this.tokenContract = new Web3Service.web3.eth.Contract(
      TokenABI.abi,
      contractAddress
    );
  }

  async getTokenBalance(address) {
    const balance = await this.tokenContract.methods.balanceOf(address).call();
    return Web3Service.web3.utils.fromWei(balance, 'ether');
  }

  async transferTokens(to, amount) {
    const amountWei = Web3Service.web3.utils.toWei(amount, 'ether');
    
    return await this.tokenContract.methods
      .transfer(to, amountWei)
      .send({ 
        from: Web3Service.accounts[0],
        gas: 100000 
      });
  }

  watchTransferEvents(callback) {
    this.tokenContract.events.Transfer({}, callback);
  }
}

export default new ContractService();