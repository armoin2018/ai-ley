// Complete IoT processing flow
const iotPipeline = {
  flows: [
    {
      id: 'iot-data-pipeline',
      label: 'IoT Data Processing',
      nodes: [
        // Input: MQTT sensor data
        {
          type: 'mqtt in',
          topic: 'sensors/+/+',
          qos: 0,
          broker: 'iot-broker',
        },

        // Validation and normalization
        {
          type: 'function',
          name: 'Validate Data',
          func: `
                        const [deviceId, sensorType] = msg.topic.split('/').slice(1);
                        
                        // Validate payload
                        if (typeof msg.payload !== 'object') {
                            try {
                                msg.payload = JSON.parse(msg.payload);
                            } catch (e) {
                                node.error('Invalid JSON payload', msg);
                                return null;
                            }
                        }
                        
                        // Add metadata
                        msg.deviceId = deviceId;
                        msg.sensorType = sensorType;
                        msg.timestamp = new Date().toISOString();
                        
                        // Range validation
                        const ranges = {
                            temperature: { min: -40, max: 85 },
                            humidity: { min: 0, max: 100 },
                            pressure: { min: 300, max: 1100 }
                        };
                        
                        const range = ranges[sensorType];
                        if (range && (msg.payload.value < range.min || msg.payload.value > range.max)) {
                            node.warn(\`\${sensorType} out of range: \${msg.payload.value}\`);
                            return null;
                        }
                        
                        return msg;
                    `,
        },

        // Anomaly detection
        {
          type: 'function',
          name: 'Anomaly Detection',
          func: `
                        const key = \`\${msg.deviceId}_\${msg.sensorType}\`;
                        let history = context.get(key) || [];
                        
                        history.push(msg.payload.value);
                        if (history.length > 10) {
                            history = history.slice(-10);
                        }
                        
                        if (history.length >= 3) {
                            const avg = history.reduce((a, b) => a + b) / history.length;
                            const stdDev = Math.sqrt(history.reduce((sq, n) => sq + Math.pow(n - avg, 2), 0) / history.length);
                            
                            if (Math.abs(msg.payload.value - avg) > 2 * stdDev) {
                                msg.anomaly = true;
                                msg.expected = avg;
                                msg.deviation = Math.abs(msg.payload.value - avg);
                            }
                        }
                        
                        context.set(key, history);
                        return msg;
                    `,
        },

        // Store in database
        {
          type: 'function',
          name: 'Format for DB',
          func: `
                        msg.payload = {
                            measurement: 'sensor_readings',
                            tags: {
                                device: msg.deviceId,
                                sensor: msg.sensorType,
                                location: msg.payload.location || 'unknown'
                            },
                            fields: {
                                value: msg.payload.value,
                                anomaly: msg.anomaly || false
                            },
                            timestamp: new Date(msg.timestamp)
                        };
                        return msg;
                    `,
        },

        // Alert on anomalies
        {
          type: 'switch',
          property: 'anomaly',
          rules: [{ t: 'true' }],
        },

        {
          type: 'function',
          name: 'Generate Alert',
          func: `
                        msg.payload = {
                            alert: 'Sensor Anomaly Detected',
                            device: msg.deviceId,
                            sensor: msg.sensorType,
                            value: msg.payload.value,
                            expected: msg.expected,
                            deviation: msg.deviation,
                            timestamp: msg.timestamp
                        };
                        return msg;
                    `,
        },
      ],
    },
  ],
};