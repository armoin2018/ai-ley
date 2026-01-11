const { expect } = require('chai');
const { ethers } = require('hardhat');
const { loadFixture } = require('@nomicfoundation/hardhat-network-helpers');

describe('MyContract', function () {
  async function deployContractFixture() {
    const [owner, addr1, addr2] = await ethers.getSigners();

    const MyContract = await ethers.getContractFactory('MyContract');
    const contract = await MyContract.deploy();
    await contract.deployed();

    return { contract, owner, addr1, addr2 };
  }

  describe('Deployment', function () {
    it('Should set the right owner', async function () {
      const { contract, owner } = await loadFixture(deployContractFixture);
      expect(await contract.owner()).to.equal(owner.address);
    });

    it('Should initialize with zero supply', async function () {
      const { contract } = await loadFixture(deployContractFixture);
      expect(await contract._currentSupply()).to.equal(0);
    });
  });

  describe('Minting', function () {
    it('Should mint tokens successfully', async function () {
      const { contract, owner, addr1 } = await loadFixture(deployContractFixture);

      await expect(contract.mint(addr1.address, 100))
        .to.emit(contract, 'TokenMinted')
        .withArgs(addr1.address, 100);

      expect(await contract.getBalance(addr1.address)).to.equal(100);
    });

    it('Should reject minting from non-owner', async function () {
      const { contract, addr1, addr2 } = await loadFixture(deployContractFixture);

      await expect(contract.connect(addr1).mint(addr2.address, 100)).to.be.revertedWith(
        'Ownable: caller is not the owner',
      );
    });

    it('Should reject minting zero amount', async function () {
      const { contract, addr1 } = await loadFixture(deployContractFixture);

      await expect(contract.mint(addr1.address, 0)).to.be.revertedWith(
        'Amount must be greater than zero',
      );
    });
  });

  describe('Edge Cases', function () {
    it('Should handle max supply correctly', async function () {
      const { contract, addr1 } = await loadFixture(deployContractFixture);

      const maxSupply = await contract.MAX_SUPPLY();
      await contract.mint(addr1.address, maxSupply);

      await expect(contract.mint(addr1.address, 1)).to.be.revertedWith('Exceeds max supply');
    });
  });

  describe('Gas Usage', function () {
    it('Should use reasonable gas for minting', async function () {
      const { contract, addr1 } = await loadFixture(deployContractFixture);

      const tx = await contract.mint(addr1.address, 100);
      const receipt = await tx.wait();

      expect(receipt.gasUsed).to.be.below(100000);
    });
  });
});