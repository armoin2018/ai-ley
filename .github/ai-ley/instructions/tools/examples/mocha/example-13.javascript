const { expect } = require('chai');
const sinon = require('sinon');
const UserService = require('../src/services/UserService');
const EmailService = require('../src/services/EmailService');
const Database = require('../src/database/Database');

describe('User Service with Mocks', function () {
  let emailStub, dbStub;

  beforeEach(function () {
    // Stub external dependencies
    emailStub = sinon.stub(EmailService, 'sendWelcomeEmail');
    dbStub = sinon.stub(Database, 'save');
  });

  afterEach(function () {
    sinon.restore();
  });

  it('should create user and send welcome email', async function () {
    // Configure stubs
    dbStub.resolves({ id: 1, name: 'John Doe', email: 'john@test.com' });
    emailStub.resolves(true);

    const userData = { name: 'John Doe', email: 'john@test.com' };
    const result = await UserService.createUser(userData);

    // Verify behavior
    expect(result.id).to.equal(1);
    expect(dbStub.calledOnce).to.be.true;
    expect(emailStub.calledOnce).to.be.true;
    expect(emailStub.calledWith('john@test.com')).to.be.true;
  });

  it('should handle database errors', async function () {
    // Configure stub to reject
    dbStub.rejects(new Error('Database error'));

    const userData = { name: 'John Doe', email: 'john@test.com' };

    await expect(UserService.createUser(userData)).to.be.rejectedWith('Database error');

    // Verify email was not sent on database error
    expect(emailStub.called).to.be.false;
  });

  // Spying on existing methods
  it('should track method calls', function () {
    const user = { validate: () => true };
    const validateSpy = sinon.spy(user, 'validate');

    user.validate();
    user.validate();

    expect(validateSpy.callCount).to.equal(2);
    expect(validateSpy.alwaysReturned(true)).to.be.true;
  });
});