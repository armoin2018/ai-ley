// Industrial automation flow
const industrialAutomation = {
  nodes: [
    // Modbus data collection
    {
      type: 'modbus-read',
      name: 'Read Sensors',
      unitid: 1,
      dataType: 'HoldingRegister',
      adr: '0',
      quantity: '10',
      rate: '1000',
    },

    // Data processing
    {
      type: 'function',
      name: 'Process Sensor Data',
      func: `
                // Parse Modbus register values
                const registers = msg.payload;
                
                const sensorData = {
                    temperature: registers[0] / 10, // Scale factor
                    pressure: registers[1] / 100,
                    flowRate: registers[2],
                    valve1Position: registers[3],
                    valve2Position: registers[4],
                    motorSpeed: registers[5],
                    alarmStatus: registers[6]
                };
                
                // Safety checks
                const alerts = [];
                if (sensorData.temperature > 80) {
                    alerts.push('High temperature warning');
                }
                if (sensorData.pressure > 10) {
                    alerts.push('High pressure warning');
                }
                
                msg.payload = {
                    ...sensorData,
                    alerts,
                    timestamp: new Date().toISOString()
                };
                
                return msg;
            `,
    },

    // Control logic
    {
      type: 'function',
      name: 'Control Logic',
      func: `
                const data = msg.payload;
                const commands = [];
                
                // Temperature control
                if (data.temperature > 75) {
                    commands.push({
                        register: 10,
                        value: Math.min(data.valve1Position + 10, 100) // Open cooling valve
                    });
                } else if (data.temperature < 65) {
                    commands.push({
                        register: 10,
                        value: Math.max(data.valve1Position - 10, 0) // Close cooling valve
                    });
                }
                
                // Pressure control
                if (data.pressure > 8) {
                    commands.push({
                        register: 11,
                        value: Math.min(data.valve2Position + 15, 100) // Open relief valve
                    });
                }
                
                // Emergency shutdown
                if (data.alarmStatus > 0) {
                    commands.push({
                        register: 12,
                        value: 0 // Stop motor
                    });
                }
                
                if (commands.length > 0) {
                    msg.payload = commands;
                    return msg;
                }
                
                return null;
            `,
    },

    // Modbus write commands
    {
      type: 'split',
    },
    {
      type: 'modbus-write',
      name: 'Send Commands',
      unitid: 1,
      dataType: 'HoldingRegister',
    },
  ],
};