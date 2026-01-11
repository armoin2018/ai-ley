// monitoring/contract-monitor.js
const { ethers } = require('ethers');
const nodemailer = require('nodemailer');

class ContractMonitor {
  constructor(contractAddress, abi, provider) {
    this.contract = new ethers.Contract(contractAddress, abi, provider);
    this.provider = provider;
    this.alerts = [];
  }

  // Monitor transaction volume
  async monitorTransactionVolume() {
    const filter = this.contract.filters.Transfer();

    this.contract.on(filter, async (from, to, amount, event) => {
      const ethAmount = ethers.utils.formatEther(amount);

      // Alert on large transactions
      if (parseFloat(ethAmount) > 10000) {
        await this.sendAlert({
          type: 'LARGE_TRANSACTION',
          message: `Large transfer: ${ethAmount} tokens from ${from} to ${to}`,
          txHash: event.transactionHash,
        });
      }
    });
  }

  // Monitor contract balance
  async monitorContractBalance() {
    setInterval(async () => {
      const balance = await this.provider.getBalance(this.contract.address);
      const ethBalance = ethers.utils.formatEther(balance);

      // Alert on low balance
      if (parseFloat(ethBalance) < 1) {
        await this.sendAlert({
          type: 'LOW_BALANCE',
          message: `Contract balance is low: ${ethBalance} ETH`,
          balance: ethBalance,
        });
      }
    }, 60000); // Check every minute
  }

  // Monitor gas prices
  async monitorGasPrices() {
    setInterval(async () => {
      const gasPrice = await this.provider.getGasPrice();
      const gweiPrice = ethers.utils.formatUnits(gasPrice, 'gwei');

      // Alert on high gas prices
      if (parseFloat(gweiPrice) > 100) {
        await this.sendAlert({
          type: 'HIGH_GAS',
          message: `Gas price is high: ${gweiPrice} gwei`,
          gasPrice: gweiPrice,
        });
      }
    }, 300000); // Check every 5 minutes
  }

  async sendAlert(alert) {
    console.log('Alert:', alert);

    // Email notification
    const transporter = nodemailer.createTransporter({
      service: 'gmail',
      auth: {
        user: process.env.EMAIL_USER,
        pass: process.env.EMAIL_PASS,
      },
    });

    await transporter.sendMail({
      from: process.env.EMAIL_USER,
      to: process.env.ALERT_EMAIL,
      subject: `Contract Alert: ${alert.type}`,
      text: alert.message,
    });
  }
}

// Usage
const monitor = new ContractMonitor(
  process.env.CONTRACT_ADDRESS,
  require('./abi.json'),
  new ethers.providers.JsonRpcProvider(process.env.RPC_URL),
);

monitor.monitorTransactionVolume();
monitor.monitorContractBalance();
monitor.monitorGasPrices();