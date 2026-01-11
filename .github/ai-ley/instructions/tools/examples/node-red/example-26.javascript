// Batch messages for efficiency
{
    "type": "function",
    "func": `
        let batch = context.get('batch') || [];
        batch.push(msg.payload);

        const batchSize = 10;
        const timeout = 5000; // 5 seconds

        if (batch.length >= batchSize) {
            // Send full batch
            msg.payload = batch;
            context.set('batch', []);
            return msg;
        } else {
            // Set timer for partial batch
            const timerId = context.get('timerId');
            if (timerId) {
                clearTimeout(timerId);
            }

            const newTimerId = setTimeout(() => {
                if (batch.length > 0) {
                    const timeoutMsg = {
                        topic: msg.topic,
                        payload: batch
                    };
                    context.set('batch', []);
                    node.send(timeoutMsg);
                }
            }, timeout);

            context.set('batch', batch);
            context.set('timerId', newTimerId);
            return null;
        }
    `
}