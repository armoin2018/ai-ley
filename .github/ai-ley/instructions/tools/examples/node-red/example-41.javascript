// Debug helper function
{
    "type": "function",
    "name": "Debug Helper",
    "func": `
        // Log message structure
        node.log('Message received:');
        node.log('Topic: ' + msg.topic);
        node.log('Payload type: ' + typeof msg.payload);
        node.log('Payload: ' + JSON.stringify(msg.payload, null, 2));

        // Log context state
        const contextKeys = context.keys();
        if (contextKeys.length > 0) {
            node.log('Context keys: ' + contextKeys.join(', '));
        }

        // Performance timing
        msg.debugStartTime = Date.now();

        return msg;
    `
}