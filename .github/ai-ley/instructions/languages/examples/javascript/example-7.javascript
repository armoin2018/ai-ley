// ✅ Good: Well-structured class with proper encapsulation
class UserService {
  #database;
  #cache;
  
  constructor(database, cache) {
    this.#database = database;
    this.#cache = cache;
  }
  
  async getUser(userId) {
    // Check cache first
    const cachedUser = await this.#cache.get(`user:${userId}`);
    if (cachedUser) {
      return cachedUser;
    }
    
    // Fetch from database
    const user = await this.#database.findUserById(userId);
    if (!user) {
      throw new Error(`User with ID ${userId} not found`);
    }
    
    // Cache the result
    await this.#cache.set(`user:${userId}`, user, { ttl: 300 });
    
    return user;
  }
  
  async updateUser(userId, updates) {
    const user = await this.getUser(userId);
    
    // Validate updates
    this.#validateUserUpdates(updates);
    
    // Update in database
    const updatedUser = await this.#database.updateUser(userId, updates);
    
    // Invalidate cache
    await this.#cache.delete(`user:${userId}`);
    
    return updatedUser;
  }
  
  #validateUserUpdates(updates) {
    const allowedFields = ['name', 'email', 'preferences'];
    const invalidFields = Object.keys(updates).filter(
      field => !allowedFields.includes(field)
    );
    
    if (invalidFields.length > 0) {
      throw new ValidationError(
        `Invalid fields: ${invalidFields.join(', ')}`,
        invalidFields[0]
      );
    }
  }
}