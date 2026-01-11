// Webhook flow pattern
[
  {
    type: 'http in',
    url: '/webhook/github',
    method: 'post',
  },
  {
    type: 'function',
    func: `
            // Validate webhook signature
            const crypto = require('crypto');
            const signature = msg.req.headers['x-hub-signature-256'];
            const payload = JSON.stringify(msg.payload);
            const secret = env.get('GITHUB_WEBHOOK_SECRET');
            
            const expectedSignature = 'sha256=' + crypto
                .createHmac('sha256', secret)
                .update(payload)
                .digest('hex');
            
            if (signature !== expectedSignature) {
                msg.statusCode = 401;
                msg.payload = 'Unauthorized';
                return msg;
            }
            
            // Process webhook payload
            if (msg.payload.action === 'opened') {
                msg.topic = 'pr_opened';
                msg.payload = {
                    repo: msg.payload.repository.name,
                    pr_number: msg.payload.number,
                    title: msg.payload.pull_request.title
                };
            }
            
            return msg;
        `,
  },
  {
    type: 'http response',
  },
];