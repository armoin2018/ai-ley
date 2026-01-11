// netlify/functions/wordpress-webhook.js
exports.handler = async (event, context) => {
  if (event.httpMethod !== 'POST') {
    return { statusCode: 405, body: 'Method Not Allowed' };
  }

  const { headers } = event;
  const signature = headers['x-wp-signature'];

  // Verify webhook signature
  if (!verifySignature(event.body, signature)) {
    return { statusCode: 401, body: 'Unauthorized' };
  }

  // Trigger build on content change
  try {
    await fetch(`https://api.netlify.com/build_hooks/${process.env.BUILD_HOOK_ID}`, {
      method: 'POST',
    });

    return {
      statusCode: 200,
      body: JSON.stringify({ message: 'Build triggered successfully' }),
    };
  } catch (error) {
    return {
      statusCode: 500,
      body: JSON.stringify({ error: 'Failed to trigger build' }),
    };
  }
};