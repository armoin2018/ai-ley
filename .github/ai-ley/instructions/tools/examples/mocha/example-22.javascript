const { expect, assert, should } = require('chai');

describe('Chai Integration', function () {
  it('should use expect style', function () {
    expect([1, 2, 3]).to.have.lengthOf(3);
    expect('hello').to.be.a('string');
    expect({ foo: 'bar' }).to.have.property('foo');
  });

  it('should use assert style', function () {
    assert.equal(true, true);
    assert.typeOf('hello', 'string');
    assert.lengthOf([1, 2, 3], 3);
  });

  it('should use should style', function () {
    'hello'.should.be.a('string');
    [1, 2, 3].should.have.lengthOf(3);
    ({ foo: 'bar' }).should.have.property('foo');
  });
});