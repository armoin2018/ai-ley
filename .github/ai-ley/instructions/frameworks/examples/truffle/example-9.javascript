// truffle console interaction
truffle(development)> let instance = await MyToken.deployed()
truffle(development)> let balance = await instance.balanceOf(accounts[0])
truffle(development)> balance.toString()
truffle(development)> await instance.transfer(accounts[1], 1000)