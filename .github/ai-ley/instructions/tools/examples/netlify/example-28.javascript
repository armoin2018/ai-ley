// Add proper error handling
exports.handler = async (event, context) => {
  try {
    // Function logic here
    return {
      statusCode: 200,
      body: JSON.stringify({ success: true })
    };
  } catch (error) {
    console.error('Function error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({
        error: 'Internal server error',
        message: error.message
      })
    };
  }
};

// Check function logs
netlify logs
netlify functions:list