// ✅ Good: Proper error handling with async/await
async function processUserData(userId) {
  try {
    const user = await fetchUser(userId);
    const profile = await fetchUserProfile(user.profileId);
    const preferences = await fetchUserPreferences(userId);
    
    return {
      ...user,
      profile,
      preferences
    };
  } catch (error) {
    console.error('Error processing user data:', error);
    throw new Error(`User processing failed: ${error.message}`);
  }
}

// ✅ Good: Concurrent operations with Promise.all
async function loadDashboardData(userId) {
  try {
    const [user, analytics, notifications] = await Promise.all([
      fetchUser(userId),
      fetchAnalytics(userId),
      fetchNotifications(userId)
    ]);
    
    return { user, analytics, notifications };
  } catch (error) {
    throw new Error(`Dashboard loading failed: ${error.message}`);
  }
}

// ✅ Good: Handle partial failures with Promise.allSettled
async function loadOptionalData(userId) {
  const results = await Promise.allSettled([
    fetchUserProfile(userId),
    fetchUserPreferences(userId),
    fetchUserStats(userId)
  ]);
  
  const data = {};
  results.forEach((result, index) => {
    if (result.status === 'fulfilled') {
      const keys = ['profile', 'preferences', 'stats'];
      data[keys[index]] = result.value;
    }
  });
  
  return data;
}