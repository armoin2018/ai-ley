// api.integration.test.js
import request from 'supertest';
import app from '../src/app.js';

describe('User API', () => {
  beforeEach(async () => {
    await setupTestDatabase();
  });
  
  afterEach(async () => {
    await cleanupTestDatabase();
  });
  
  describe('GET /api/users/:id', () => {
    it('should return user data for valid ID', async () => {
      const user = await createTestUser({ name: 'John Doe' });
      
      const response = await request(app)
        .get(`/api/users/${user.id}`)
        .expect(200);
      
      expect(response.body).toMatchObject({
        id: user.id,
        name: 'John Doe'
      });
    });
    
    it('should return 404 for non-existent user', async () => {
      const response = await request(app)
        .get('/api/users/non-existent-id')
        .expect(404);
      
      expect(response.body.error).toBe('User not found');
    });
  });
});