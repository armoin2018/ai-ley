// user.service.test.js
import { UserService } from '../src/services/user.service.js';

describe('UserService', () => {
  let userService;
  let mockDatabase;
  let mockCache;
  
  beforeEach(() => {
    mockDatabase = {
      findUserById: jest.fn(),
      updateUser: jest.fn()
    };
    
    mockCache = {
      get: jest.fn(),
      set: jest.fn(),
      delete: jest.fn()
    };
    
    userService = new UserService(mockDatabase, mockCache);
  });
  
  afterEach(() => {
    jest.clearAllMocks();
  });
  
  describe('getUser', () => {
    it('should return cached user when available', async () => {
      const userId = '123';
      const cachedUser = { id: userId, name: 'John Doe' };
      
      mockCache.get.mockResolvedValue(cachedUser);
      
      const result = await userService.getUser(userId);
      
      expect(result).toEqual(cachedUser);
      expect(mockCache.get).toHaveBeenCalledWith(`user:${userId}`);
      expect(mockDatabase.findUserById).not.toHaveBeenCalled();
    });
    
    it('should fetch from database when not cached', async () => {
      const userId = '123';
      const user = { id: userId, name: 'John Doe' };
      
      mockCache.get.mockResolvedValue(null);
      mockDatabase.findUserById.mockResolvedValue(user);
      
      const result = await userService.getUser(userId);
      
      expect(result).toEqual(user);
      expect(mockDatabase.findUserById).toHaveBeenCalledWith(userId);
      expect(mockCache.set).toHaveBeenCalledWith(
        `user:${userId}`,
        user,
        { ttl: 300 }
      );
    });
    
    it('should throw error when user not found', async () => {
      const userId = '123';
      
      mockCache.get.mockResolvedValue(null);
      mockDatabase.findUserById.mockResolvedValue(null);
      
      await expect(userService.getUser(userId))
        .rejects
        .toThrow(`User with ID ${userId} not found`);
    });
  });
});