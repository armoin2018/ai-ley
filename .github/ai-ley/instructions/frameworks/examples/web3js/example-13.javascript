if (window.ethereum && window.ethereum.isMetaMask) {
    await window.ethereum.request({ method: 'eth_requestAccounts' });
  }