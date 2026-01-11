// API security middleware
{
    "type": "function",
    "name": "Security Middleware",
    "func": `
        // Rate limiting
        const ip = msg.req.connection.remoteAddress;
        const rateKey = 'rate_' + ip;
        let requests = context.get(rateKey) || [];
        const now = Date.now();

        // Clean old requests (1 minute window)
        requests = requests.filter(time => now - time < 60000);

        if (requests.length >= 100) { // 100 requests per minute
            msg.statusCode = 429;
            msg.payload = { error: 'Rate limit exceeded' };
            return [null, msg];
        }

        requests.push(now);
        context.set(rateKey, requests);

        // Input validation
        const allowedPaths = ['/api/data', '/api/status', '/api/health'];
        if (!allowedPaths.includes(msg.req.url)) {
            msg.statusCode = 404;
            msg.payload = { error: 'Not found' };
            return [null, msg];
        }

        // Sanitize headers
        delete msg.req.headers['x-forwarded-for'];

        return [msg, null];
    `,
    "outputs": 2
}