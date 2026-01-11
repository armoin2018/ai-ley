// Template for robust function nodes
// Input validation
if (!msg.payload) {
  node.warn('Empty payload received');
  return null;
}

try {
  // Main processing logic
  const result = processData(msg.payload);

  // Output validation
  if (result !== null && result !== undefined) {
    msg.payload = result;
    return msg;
  } else {
    node.warn('Processing returned null result');
    return null;
  }
} catch (error) {
  // Error handling
  node.error(`Processing failed: ${error.message}`, msg);

  // Optional: Send to error output
  const errorMsg = {
    topic: 'error',
    payload: {
      error: error.message,
      original: msg.payload,
      timestamp: new Date().toISOString(),
    },
  };

  return [null, errorMsg]; // For nodes with multiple outputs
}