const { expect } = require('chai');
const request = require('supertest');
const app = require('../src/app');

describe('Async Testing', function () {
  // Promise-based testing
  it('should handle promises', function () {
    return fetchUserData(1).then((user) => {
      expect(user.id).to.equal(1);
      expect(user.name).to.be.a('string');
    });
  });

  // Async/await testing
  it('should handle async/await', async function () {
    const user = await fetchUserData(1);

    expect(user.id).to.equal(1);
    expect(user.name).to.be.a('string');
  });

  // Callback testing with done
  it('should handle callbacks', function (done) {
    fetchUserDataCallback(1, (err, user) => {
      if (err) return done(err);

      expect(user.id).to.equal(1);
      expect(user.name).to.be.a('string');
      done();
    });
  });

  // HTTP API testing
  it('should test API endpoints', async function () {
    const response = await request(app).get('/api/users/1').expect(200);

    expect(response.body).to.have.property('id', 1);
    expect(response.body.name).to.be.a('string');
  });

  // Testing promise rejection
  it('should handle rejected promises', function () {
    return expect(fetchInvalidUser()).to.be.rejectedWith('User not found');
  });

  // Testing with timeout
  it('should handle slow operations', async function () {
    this.timeout(10000); // 10 second timeout

    const result = await slowOperation();
    expect(result).to.be.ok;
  });
});