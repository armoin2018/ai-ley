// Rate limiting pattern
{
    "type": "function",
    "func": `
        const now = Date.now();
        const lastCall = context.get('lastCall') || 0;
        const rateLimit = 1000; // 1 second

        if (now - lastCall < rateLimit) {
            node.warn('Rate limit exceeded, dropping message');
            return null;
        }

        context.set('lastCall', now);
        return msg;
    `
}