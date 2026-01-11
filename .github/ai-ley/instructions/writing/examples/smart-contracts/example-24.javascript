// backend-integration.js
const { ethers } = require('ethers');
const express = require('express');
const app = express();

class BackendContractService {
  constructor() {
    this.provider = new ethers.providers.JsonRpcProvider(process.env.RPC_URL);
    this.wallet = new ethers.Wallet(process.env.PRIVATE_KEY, this.provider);
    this.contract = new ethers.Contract(
      process.env.CONTRACT_ADDRESS,
      require('./abi.json'),
      this.wallet,
    );
  }

  async mintTokens(recipientAddress, amount) {
    try {
      // Validate inputs
      if (!ethers.utils.isAddress(recipientAddress)) {
        throw new Error('Invalid recipient address');
      }

      if (amount <= 0) {
        throw new Error('Amount must be positive');
      }

      // Check gas price
      const gasPrice = await this.provider.getGasPrice();
      const maxGasPrice = ethers.utils.parseUnits('50', 'gwei');

      if (gasPrice.gt(maxGasPrice)) {
        throw new Error('Gas price too high, try again later');
      }

      // Execute transaction
      const tx = await this.contract.mint(recipientAddress, amount, {
        gasPrice: gasPrice,
        gasLimit: 200000,
      });

      return {
        transactionHash: tx.hash,
        status: 'pending',
      };
    } catch (error) {
      throw new Error(`Minting failed: ${error.message}`);
    }
  }

  async getTransactionStatus(txHash) {
    try {
      const receipt = await this.provider.getTransactionReceipt(txHash);

      if (!receipt) {
        return { status: 'pending' };
      }

      return {
        status: receipt.status === 1 ? 'success' : 'failed',
        blockNumber: receipt.blockNumber,
        gasUsed: receipt.gasUsed.toString(),
      };
    } catch (error) {
      throw new Error(`Failed to get transaction status: ${error.message}`);
    }
  }
}

// Express API endpoints
const contractService = new BackendContractService();

app.use(express.json());

app.post('/mint', async (req, res) => {
  try {
    const { recipient, amount } = req.body;
    const result = await contractService.mintTokens(recipient, amount);
    res.json(result);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.get('/transaction/:hash', async (req, res) => {
  try {
    const status = await contractService.getTransactionStatus(req.params.hash);
    res.json(status);
  } catch (error) {
    res.status(400).json({ error: error.message });
  }
});

app.listen(3000, () => {
  console.log('Server running on port 3000');
});