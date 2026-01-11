// test/user.test.js
const { expect } = require('chai');
const User = require('../src/models/User');

describe('User Model', function () {
  describe('User Creation', function () {
    it('should create a user with valid data', function () {
      const userData = {
        name: 'John Doe',
        email: 'john@example.com',
        age: 30,
      };

      const user = new User(userData);

      expect(user.name).to.equal('John Doe');
      expect(user.email).to.equal('john@example.com');
      expect(user.age).to.equal(30);
    });

    it('should throw error with invalid email', function () {
      const userData = {
        name: 'John Doe',
        email: 'invalid-email',
        age: 30,
      };

      expect(() => new User(userData)).to.throw('Invalid email format');
    });
  });

  describe('User Methods', function () {
    let user;

    beforeEach(function () {
      user = new User({
        name: 'Test User',
        email: 'test@example.com',
        age: 25,
      });
    });

    it('should return full name', function () {
      expect(user.getFullName()).to.equal('Test User');
    });

    it('should validate age', function () {
      expect(user.isAdult()).to.be.true;

      user.age = 16;
      expect(user.isAdult()).to.be.false;
    });
  });
});