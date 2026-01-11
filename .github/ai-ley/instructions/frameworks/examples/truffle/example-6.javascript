// test/mytoken.test.js
const MyToken = artifacts.require("MyToken");

contract("MyToken", (accounts) => {
  let myTokenInstance;
  const [owner, user1, user2] = accounts;
  const initialSupply = 1000000;

  beforeEach(async () => {
    myTokenInstance = await MyToken.new(initialSupply, { from: owner });
  });

  it("should have correct initial supply", async () => {
    const totalSupply = await myTokenInstance.totalSupply();
    assert.equal(totalSupply.toNumber(), initialSupply * 10**18);
  });

  it("should mint tokens correctly", async () => {
    const mintAmount = 1000;
    await myTokenInstance.mint(user1, mintAmount, { from: owner });
    
    const balance = await myTokenInstance.balanceOf(user1);
    assert.equal(balance.toNumber(), mintAmount);
  });
});