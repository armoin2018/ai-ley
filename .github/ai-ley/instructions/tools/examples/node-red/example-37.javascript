// Identify memory leaks
// 1. Check context usage
context.keys().forEach((key) => {
  const value = context.get(key);
  console.log(`Context ${key}: ${JSON.stringify(value).length} bytes`);
});

// 2. Clear unused context
context.set('largeData', undefined);

// 3. Use external storage for large data
const redis = require('redis');
const client = redis.createClient();