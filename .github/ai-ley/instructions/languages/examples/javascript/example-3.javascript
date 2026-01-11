// ✅ Good: Pure functions with clear inputs/outputs
function calculateTax(amount, rate) {
  if (typeof amount !== 'number' || typeof rate !== 'number') {
    throw new Error('Amount and rate must be numbers');
  }
  
  if (amount < 0 || rate < 0) {
    throw new Error('Amount and rate must be non-negative');
  }
  
  return amount * rate;
}

// ✅ Good: Use JSDoc for documentation
/**
 * Fetches user data from the API
 * @param {string} userId - The unique identifier for the user
 * @param {Object} options - Additional options
 * @param {boolean} options.includeProfile - Whether to include profile data
 * @returns {Promise<Object>} The user data object
 * @throws {Error} When user is not found or network error occurs
 */
async function fetchUserData(userId, options = {}) {
  const { includeProfile = false } = options;
  
  try {
    const response = await api.get(`/users/${userId}`, {
      params: { includeProfile }
    });
    
    return response.data;
  } catch (error) {
    throw new Error(`Failed to fetch user data: ${error.message}`);
  }
}

// ✅ Good: Use arrow functions for short callbacks
const activeUsers = users.filter(user => user.isActive);
const userNames = users.map(user => user.name);
const totalScore = scores.reduce((sum, score) => sum + score, 0);