// Sensor data processing flow
const sensorFlow = [
  {
    type: 'mqtt in',
    topic: 'sensors/+/+', // sensors/device_id/sensor_type
    broker: 'mqtt-broker',
  },
  {
    type: 'function',
    func: `
            // Parse MQTT topic
            const topicParts = msg.topic.split('/');
            const deviceId = topicParts[1];
            const sensorType = topicParts[2];
            
            // Add metadata
            msg.deviceId = deviceId;
            msg.sensorType = sensorType;
            msg.timestamp = new Date().toISOString();
            
            // Validate data
            if (typeof msg.payload !== 'number') {
                msg.payload = parseFloat(msg.payload);
            }
            
            // Range validation
            if (sensorType === 'temperature' && (msg.payload < -50 || msg.payload > 100)) {
                node.warn('Temperature out of range: ' + msg.payload);
                return null;
            }
            
            return msg;
        `,
  },
  {
    type: 'mqtt out',
    topic: 'processed/sensors',
    broker: 'mqtt-broker',
  },
];