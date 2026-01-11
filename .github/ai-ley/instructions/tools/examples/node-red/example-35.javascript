// API Gateway flow
const apiGateway = {
  flows: [
    {
      id: 'api-gateway',
      label: 'API Gateway',
      nodes: [
        // API endpoint
        {
          type: 'http in',
          url: '/api/v1/+',
          method: 'get',
        },

        // Authentication middleware
        {
          type: 'function',
          name: 'Authentication',
          func: `
                        const token = msg.req.headers.authorization;
                        
                        if (!token || !token.startsWith('Bearer ')) {
                            msg.statusCode = 401;
                            msg.payload = { error: 'Unauthorized' };
                            return [null, msg]; // Send to error output
                        }
                        
                        // Validate JWT token (simplified)
                        try {
                            const jwt = require('jsonwebtoken');
                            const decoded = jwt.verify(token.substring(7), process.env.JWT_SECRET);
                            msg.user = decoded;
                            return [msg, null]; // Send to success output
                        } catch (error) {
                            msg.statusCode = 401;
                            msg.payload = { error: 'Invalid token' };
                            return [null, msg];
                        }
                    `,
          outputs: 2,
        },

        // Route to appropriate service
        {
          type: 'switch',
          property: 'req.url',
          rules: [
            { t: 'regex', v: '^/api/v1/users', case: false },
            { t: 'regex', v: '^/api/v1/orders', case: false },
            { t: 'regex', v: '^/api/v1/products', case: false },
            { t: 'else' },
          ],
        },

        // User service call
        {
          type: 'function',
          name: 'User Service',
          func: `
                        const baseUrl = process.env.USER_SERVICE_URL || 'http://user-service:3000';
                        msg.url = baseUrl + msg.req.url.replace('/api/v1', '');
                        msg.method = msg.req.method;
                        msg.headers = {
                            'Content-Type': 'application/json',
                            'X-User-ID': msg.user.id
                        };
                        return msg;
                    `,
        },

        // HTTP request to service
        {
          type: 'http request',
          method: 'use',
          ret: 'obj',
        },

        // Response formatting
        {
          type: 'function',
          name: 'Format Response',
          func: `
                        // Add response metadata
                        const response = {
                            data: msg.payload,
                            timestamp: new Date().toISOString(),
                            requestId: msg._msgid
                        };
                        
                        msg.payload = response;
                        msg.headers = {
                            'Content-Type': 'application/json',
                            'X-Response-Time': Date.now() - msg.req.timestamp
                        };
                        
                        return msg;
                    `,
        },

        // HTTP response
        {
          type: 'http response',
        },
      ],
    },
  ],
};