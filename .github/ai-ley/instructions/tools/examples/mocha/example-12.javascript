const { expect } = require('chai');
const mongoose = require('mongoose');
const User = require('../src/models/User');

describe('Database Integration Tests', function () {
  // Run once before all tests in this describe block
  before(async function () {
    await mongoose.connect('mongodb://localhost:27017/test_db');
    console.log('Connected to test database');
  });

  // Run once after all tests in this describe block
  after(async function () {
    await mongoose.connection.close();
    console.log('Disconnected from test database');
  });

  // Run before each test
  beforeEach(async function () {
    // Clear database before each test
    await User.deleteMany({});

    // Seed test data
    await User.create([
      { name: 'User 1', email: 'user1@test.com' },
      { name: 'User 2', email: 'user2@test.com' },
    ]);
  });

  // Run after each test
  afterEach(function () {
    // Clean up any test artifacts
    console.log('Test completed, data cleaned');
  });

  describe('User Operations', function () {
    it('should find all users', async function () {
      const users = await User.find({});
      expect(users).to.have.lengthOf(2);
    });

    it('should create new user', async function () {
      const newUser = await User.create({
        name: 'New User',
        email: 'new@test.com',
      });

      expect(newUser.name).to.equal('New User');

      const allUsers = await User.find({});
      expect(allUsers).to.have.lengthOf(3);
    });
  });
});