// utils/web3Utils.js
export class Web3Utils {
  static async retryOperation(operation, maxRetries = 3, delay = 1000) {
    for (let i = 0; i < maxRetries; i++) {
      try {
        return await operation();
      } catch (error) {
        if (i === maxRetries - 1) throw error;
        await new Promise(resolve => setTimeout(resolve, delay * (i + 1)));
      }
    }
  }

  static handleError(error) {
    if (error.code === 4001) {
      return 'User rejected the transaction';
    } else if (error.code === -32603) {
      return 'Internal error occurred';
    } else if (error.message.includes('insufficient funds')) {
      return 'Insufficient funds for transaction';
    }
    return error.message || 'Unknown error occurred';
  }

  static formatAddress(address) {
    if (!address) return '';
    return `${address.slice(0, 6)}...${address.slice(-4)}`;
  }

  static isValidAddress(address) {
    return Web3.utils.isAddress(address);
  }
}