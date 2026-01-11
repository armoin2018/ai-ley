// netlify/functions/hello.js
exports.handler = async (event, context) => {
  const { name = 'World' } = event.queryStringParameters || {};

  return {
    statusCode: 200,
    headers: {
      'Content-Type': 'application/json',
      'Access-Control-Allow-Origin': '*',
    },
    body: JSON.stringify({
      message: `Hello, ${name}!`,
      timestamp: new Date().toISOString(),
    }),
  };
};

// netlify/functions/form-handler.js
exports.handler = async (event, context) => {
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      body: JSON.stringify({ error: 'Method not allowed' }),
    };
  }

  const data = JSON.parse(event.body);

  // Process form data
  console.log('Form submission:', data);

  // Send email, save to database, etc.

  return {
    statusCode: 200,
    body: JSON.stringify({ success: true, message: 'Form submitted successfully' }),
  };
};

// Usage from frontend
fetch('/.netlify/functions/hello?name=Alice')
  .then((response) => response.json())
  .then((data) => console.log(data));