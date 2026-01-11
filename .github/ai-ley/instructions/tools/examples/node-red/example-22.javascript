// InfluxDB integration
{
    "type": "function",
    "func": `
        // Prepare InfluxDB line protocol
        const measurement = 'sensor_data';
        const tags = \`device=\${msg.deviceId},type=\${msg.sensorType}\`;
        const fields = \`value=\${msg.payload}\`;
        const timestamp = Date.now() * 1000000; // nanoseconds

        msg.payload = \`\${measurement},\${tags} \${fields} \${timestamp}\`;

        return msg;
    `
},
{
    "type": "influxdb out",
    "database": "sensor_data",
    "measurement": "sensor_readings",
    "precision": "ns"
}