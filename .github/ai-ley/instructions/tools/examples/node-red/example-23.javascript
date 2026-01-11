// Smart home automation example
const homeAutomationFlow = {
  flows: [
    {
      id: 'home-automation',
      label: 'Home Automation',
      nodes: [
        {
          type: 'mqtt in',
          topic: 'home/motion/+',
          name: 'Motion Sensors',
        },
        {
          type: 'function',
          name: 'Motion Logic',
          func: `
                        const room = msg.topic.split('/')[2];
                        const motion = msg.payload;
                        
                        if (motion === 'detected') {
                            // Turn on lights
                            const lightMsg = {
                                topic: \`home/lights/\${room}\`,
                                payload: 'on'
                            };
                            
                            // Set timer for auto-off
                            const timerId = setTimeout(() => {
                                const offMsg = {
                                    topic: \`home/lights/\${room}\`,
                                    payload: 'off'
                                };
                                node.send(offMsg);
                            }, 300000); // 5 minutes
                            
                            context.set(\`timer_\${room}\`, timerId);
                            
                            return lightMsg;
                        } else {
                            // Motion stopped - clear timer
                            const timerId = context.get(\`timer_\${room}\`);
                            if (timerId) {
                                clearTimeout(timerId);
                                context.set(\`timer_\${room}\`, null);
                            }
                        }
                        
                        return null;
                    `,
        },
        {
          type: 'mqtt out',
          name: 'Light Control',
        },
      ],
    },
  ],
};