// test/integration.test.js
const { expectRevert, expectEvent } = require('@openzeppelin/test-helpers');
const { BN } = require('@openzeppelin/test-helpers/src/setup');

contract("Integration Tests", (accounts) => {
  it("should handle complex workflow", async () => {
    const token = await MyToken.new(1000000);
    
    // Test with expectRevert
    await expectRevert(
      token.mint(accounts[1], 1000, { from: accounts[1] }),
      "Ownable: caller is not the owner"
    );
    
    // Test events
    const receipt = await token.mint(accounts[1], 1000);
    expectEvent(receipt, 'Transfer', {
      from: '0x0000000000000000000000000000000000000000',
      to: accounts[1],
      value: new BN(1000)
    });
  });
});