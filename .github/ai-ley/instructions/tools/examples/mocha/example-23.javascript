const sinon = require('sinon');
const { expect } = require('chai');

describe('Sinon Integration', function () {
  it('should mock functions', function () {
    const mock = sinon.mock();
    mock.withArgs('hello').returns('world');

    expect(mock('hello')).to.equal('world');
    expect(mock.calledWith('hello')).to.be.true;
  });

  it('should stub methods', function () {
    const obj = { method: () => 'original' };
    const stub = sinon.stub(obj, 'method').returns('stubbed');

    expect(obj.method()).to.equal('stubbed');
    expect(stub.calledOnce).to.be.true;

    stub.restore();
  });
});