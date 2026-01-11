// web3-integration.js
import { ethers } from 'ethers';

class ContractInterface {
  constructor(contractAddress, abi, providerUrl) {
    this.contractAddress = contractAddress;
    this.abi = abi;
    this.provider = new ethers.providers.JsonRpcProvider(providerUrl);
    this.contract = new ethers.Contract(contractAddress, abi, this.provider);
  }

  // Connect wallet
  async connectWallet() {
    if (typeof window.ethereum !== 'undefined') {
      try {
        await window.ethereum.request({ method: 'eth_requestAccounts' });
        this.signer = new ethers.providers.Web3Provider(window.ethereum).getSigner();
        this.contractWithSigner = this.contract.connect(this.signer);
        return await this.signer.getAddress();
      } catch (error) {
        throw new Error(`Failed to connect wallet: ${error.message}`);
      }
    } else {
      throw new Error('MetaMask not installed');
    }
  }

  // Read functions
  async getBalance(address) {
    try {
      return await this.contract.getBalance(address);
    } catch (error) {
      throw new Error(`Failed to get balance: ${error.message}`);
    }
  }

  async getCurrentSupply() {
    try {
      return await this.contract._currentSupply();
    } catch (error) {
      throw new Error(`Failed to get current supply: ${error.message}`);
    }
  }

  // Write functions
  async mint(to, amount) {
    if (!this.contractWithSigner) {
      throw new Error('Wallet not connected');
    }

    try {
      // Estimate gas
      const gasEstimate = await this.contractWithSigner.estimateGas.mint(to, amount);
      const gasLimit = gasEstimate.mul(120).div(100); // 20% buffer

      // Send transaction
      const tx = await this.contractWithSigner.mint(to, amount, {
        gasLimit: gasLimit
      });

      console.log(`Transaction sent: ${tx.hash}`);

      // Wait for confirmation
      const receipt = await tx.wait();
      console.log(`Transaction confirmed in block: ${receipt.blockNumber}`);

      return receipt;
    } catch (error) {
      throw new Error(`Failed to mint: ${error.message}`);
    }
  }

  // Event listening
  setupEventListeners() {
    this.contract.on('TokenMinted', (to, amount, event) => {
      console.log(`Tokens minted: ${amount} to ${to}`);
      // Handle event
    });

    this.contract.on('BalanceUpdated', (user, newBalance, event) => {
      console.log(`Balance updated for ${user}: ${newBalance}`);
      // Handle event
    });
  }

  // Cleanup
  removeEventListeners() {
    this.contract.removeAllListeners();
  }
}

// Usage example
async function initializeContract() {
  const contractAddress = '0x...'; // Your deployed contract address
  const abi = [...]; // Your contract ABI
  const providerUrl = 'https://mainnet.infura.io/v3/YOUR-PROJECT-ID';

  const contractInterface = new ContractInterface(contractAddress, abi, providerUrl);

  try {
    const userAddress = await contractInterface.connectWallet();
    console.log(`Connected wallet: ${userAddress}`);

    contractInterface.setupEventListeners();

    // Example interactions
    const balance = await contractInterface.getBalance(userAddress);
    console.log(`User balance: ${balance}`);

    // Mint tokens (if user is owner)
    await contractInterface.mint(userAddress, 100);

  } catch (error) {
    console.error('Error:', error.message);
  }
}