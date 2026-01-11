// hooks/useWeb3.js
import { useState, useEffect } from 'react';
import Web3Service from '../services/web3Service';

export function useWeb3() {
  const [account, setAccount] = useState(null);
  const [balance, setBalance] = useState('0');
  const [networkId, setNetworkId] = useState(null);
  const [isConnected, setIsConnected] = useState(false);

  useEffect(() => {
    const initWeb3 = async () => {
      try {
        const connected = await Web3Service.initialize();
        if (connected) {
          setAccount(Web3Service.accounts[0]);
          setNetworkId(Web3Service.networkId);
          setIsConnected(true);
          
          const balance = await Web3Service.getBalance(Web3Service.accounts[0]);
          setBalance(balance);
        }
      } catch (error) {
        console.error('Web3 initialization failed:', error);
      }
    };

    initWeb3();

    // Listen for account changes
    if (window.ethereum) {
      window.ethereum.on('accountsChanged', (accounts) => {
        setAccount(accounts[0] || null);
        setIsConnected(accounts.length > 0);
      });

      window.ethereum.on('chainChanged', (chainId) => {
        setNetworkId(parseInt(chainId, 16));
      });
    }

    return () => {
      if (window.ethereum) {
        window.ethereum.removeAllListeners('accountsChanged');
        window.ethereum.removeAllListeners('chainChanged');
      }
    };
  }, []);

  return { account, balance, networkId, isConnected };
}