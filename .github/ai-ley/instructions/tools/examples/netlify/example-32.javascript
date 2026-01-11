// netlify/functions/secure-api.js
const crypto = require('crypto');

exports.handler = async (event, context) => {
  // Validate HTTP method
  if (event.httpMethod !== 'POST') {
    return {
      statusCode: 405,
      body: JSON.stringify({ error: 'Method not allowed' }),
    };
  }

  // Validate content type
  if (!event.headers['content-type']?.includes('application/json')) {
    return {
      statusCode: 400,
      body: JSON.stringify({ error: 'Invalid content type' }),
    };
  }

  // Rate limiting (simple implementation)
  const clientIP = event.headers['x-forwarded-for'] || event.headers['client-ip'];
  if (await isRateLimited(clientIP)) {
    return {
      statusCode: 429,
      body: JSON.stringify({ error: 'Rate limit exceeded' }),
    };
  }

  // Validate request signature
  const signature = event.headers['x-signature'];
  if (!validateSignature(event.body, signature)) {
    return {
      statusCode: 401,
      body: JSON.stringify({ error: 'Invalid signature' }),
    };
  }

  try {
    const data = JSON.parse(event.body);

    // Validate and sanitize input
    if (!isValidInput(data)) {
      return {
        statusCode: 400,
        body: JSON.stringify({ error: 'Invalid input data' }),
      };
    }

    // Process request
    const result = await processSecureRequest(data);

    return {
      statusCode: 200,
      headers: {
        'Content-Type': 'application/json',
        'Cache-Control': 'no-store',
      },
      body: JSON.stringify(result),
    };
  } catch (error) {
    console.error('Secure API error:', error);
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Internal server error' }),
    };
  }
};

function validateSignature(body, signature) {
  const expectedSignature = crypto
    .createHmac('sha256', process.env.WEBHOOK_SECRET)
    .update(body)
    .digest('hex');
  return crypto.timingSafeEqual(
    Buffer.from(signature, 'hex'),
    Buffer.from(expectedSignature, 'hex'),
  );
}