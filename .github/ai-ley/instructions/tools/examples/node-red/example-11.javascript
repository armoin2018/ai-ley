// Function node example
// Input: msg object with payload, topic, etc.
// Output: modified msg object or array of msgs

// Simple data transformation
msg.payload = msg.payload * 2;
return msg;

// Multiple outputs
if (msg.payload > 100) {
  return [msg, null]; // Send to first output
} else {
  return [null, msg]; // Send to second output
}

// Asynchronous operations
const axios = global.get('axios');
axios
  .get('https://api.example.com/data')
  .then((response) => {
    msg.payload = response.data;
    node.send(msg);
  })
  .catch((error) => {
    node.error(error.message, msg);
  });

return null; // For async operations

// Context storage
let count = context.get('count') || 0;
count++;
context.set('count', count);
msg.payload = `Count: ${count}`;
return msg;

// Flow and global context
let globalData = global.get('sharedData');
let flowData = flow.get('flowVariable');