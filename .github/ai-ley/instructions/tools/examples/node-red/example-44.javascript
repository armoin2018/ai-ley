// Encrypt sensitive data in context
{
    "type": "function",
    "func": `
        const crypto = require('crypto');
        const algorithm = 'aes-256-cbc';
        const key = process.env.ENCRYPTION_KEY;

        if (!key) {
            node.error('Encryption key not configured');
            return null;
        }

        // Encrypt payload
        const iv = crypto.randomBytes(16);
        const cipher = crypto.createCipher(algorithm, key);
        let encrypted = cipher.update(JSON.stringify(msg.payload), 'utf8', 'hex');
        encrypted += cipher.final('hex');

        // Store encrypted data
        context.set('encrypted_data', {
            data: encrypted,
            iv: iv.toString('hex')
        });

        return msg;
    `
}