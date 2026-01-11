const { expect } = require('chai');
const fc = require('fast-check');

describe('Property-Based Tests', function () {
  it('Should maintain invariants under random operations', async function () {
    await fc.assert(
      fc.asyncProperty(
        fc.array(fc.nat(1000), 1, 100), // Random amounts
        async (amounts) => {
          const { contract, owner, addr1 } = await loadFixture(deployContractFixture);

          let totalMinted = 0;

          for (const amount of amounts) {
            if (totalMinted + amount <= (await contract.MAX_SUPPLY())) {
              await contract.mint(addr1.address, amount);
              totalMinted += amount;
            }
          }

          expect(await contract.getBalance(addr1.address)).to.equal(totalMinted);
        },
      ),
      { numRuns: 100 },
    );
  });
});