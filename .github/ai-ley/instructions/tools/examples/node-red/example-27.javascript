// Efficient memory usage
{
    "type": "function",
    "func": `
        // Avoid storing large objects in context
        // Instead, use external storage or process immediately

        // Good: Process and forward
        const processed = processLargeData(msg.payload);
        msg.payload = processed.summary;

        // Bad: Store in context
        // context.set('largeData', msg.payload);

        return msg;
    `
}