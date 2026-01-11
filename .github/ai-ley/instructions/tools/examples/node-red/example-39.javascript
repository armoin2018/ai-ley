// MQTT diagnostics function
{
    "type": "function",
    "func": `
        // Test MQTT connectivity
        const mqtt = require('mqtt');
        const client = mqtt.connect('mqtt://localhost:1883');

        client.on('connect', () => {
            node.log('MQTT connected successfully');
            client.end();
        });

        client.on('error', (error) => {
            node.error('MQTT connection failed: ' + error.message);
            client.end();
        });

        return msg;
    `
}