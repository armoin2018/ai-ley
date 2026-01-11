// Comprehensive error handling
{
    "type": "function",
    "func": `
        try {
            // Main logic here
            const result = processData(msg.payload);
            msg.payload = result;
            return msg;
        } catch (error) {
            // Log error with context
            node.error(\`Processing failed: \${error.message}\`, msg);

            // Send to error handling flow
            const errorMsg = {
                topic: 'error',
                payload: {
                    original: msg.payload,
                    error: error.message,
                    timestamp: new Date().toISOString(),
                    nodeId: node.id
                }
            };

            // Return error message to second output
            return [null, errorMsg];
        }
    `,
    "outputs": 2
}