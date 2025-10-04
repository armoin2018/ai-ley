---
agentMode: general
applyTo: automation
author: AI-LEY
description: Comprehensive instructions for using Node-RED to build event-driven automation flows, including installation, flow development, core nodes, API integration, MQTT, and deployment management.
extensions:
  - .json
  - .js
guidelines: Follow Node-RED best practices and flow design patterns
instructionType: tools
keywords:
  - node-red
  - automation
  - event-driven
  - flows
  - iot
  - mqtt
  - api-integration
  - visual-programming
  - low-code
  - raspberry-pi
  - industrial-automation
lastUpdated: '2025-09-30T00:00:00.000000'
technicalQualityScore: 5.0
AIUsabilityScore: 5.0
title: Node-RED Event-Driven Automation
version: 1.0.0
---

# Node-RED Event-Driven Automation Instructions

## Tool Overview

- **Tool Name**: Node-RED
- **Version**: 3.1+ (latest stable)
- **Category**: Low-Code Development, Automation, IoT Platform
- **Purpose**: Visual programming tool for building event-driven automation flows, IoT applications, and API integrations
- **Prerequisites**: Node.js 18+, npm/yarn, basic understanding of JavaScript and networking concepts

## Installation & Setup

### Local Installation

```bash
# Global installation via npm
npm install -g --unsafe-perm node-red

# Alternative: using yarn
yarn global add node-red

# Verify installation
node-red --version

# Start Node-RED
node-red

# Access the editor at http://localhost:1880
```

### Docker Installation

```bash
# Pull official Docker image
docker pull nodered/node-red:latest

# Run Node-RED container
docker run -it -p 1880:1880 -v node_red_data:/data --name mynodered nodered/node-red

# Run with local directory mount
docker run -it -p 1880:1880 -v ~/.node-red:/data --name mynodered nodered/node-red
```

### Raspberry Pi Installation

```bash
# Update system
sudo apt update && sudo apt upgrade

# Install Node.js and npm
curl -fsSL https://deb.nodesource.com/setup_18.x | sudo -E bash -
sudo apt-get install -y nodejs

# Install Node-RED
bash <(curl -sL https://raw.githubusercontent.com/node-red/linux-installers/master/deb/update-nodejs-and-nodered)

# Enable auto-start
sudo systemctl enable nodered.service

# Start service
sudo systemctl start nodered.service
```

### Project Integration

```bash
# Create project directory
mkdir my-node-red-project
cd my-node-red-project

# Initialize Node-RED project
node-red --userDir ./

# Install additional nodes
npm install node-red-contrib-mqtt
npm install node-red-contrib-influxdb
npm install node-red-dashboard
```

## Configuration

### Settings File

```javascript
// settings.js - Main configuration file
module.exports = {
  // HTTP settings
  uiPort: process.env.PORT || 1880,
  uiHost: '0.0.0.0',

  // Runtime settings
  flowFile: 'flows.json',
  credentialSecret: process.env.NODE_RED_CREDENTIAL_SECRET || 'a-secret-key',

  // Security settings
  adminAuth: {
    type: 'credentials',
    users: [
      {
        username: 'admin',
        password: '$2b$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.',
        permissions: '*',
      },
    ],
  },

  // HTTP Node settings
  httpNodeAuth: {
    user: 'user',
    pass: '$2b$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.',
  },

  // Function node settings
  functionGlobalContext: {
    process: process,
    moment: require('moment'),
    axios: require('axios'),
  },

  // Logging
  logging: {
    console: {
      level: 'info',
      metrics: false,
      audit: false,
    },
  },

  // Editor settings
  editorTheme: {
    page: {
      title: 'My Node-RED',
      favicon: '/absolute/path/to/theme/icon',
    },
    palette: {
      theme: 'dark',
    },
  },
};
```

### Environment Variables

```bash
# Runtime environment
NODE_RED_CREDENTIAL_SECRET=your-secret-key
NODE_RED_HOME=/path/to/node-red
NODE_RED_USER_DIR=/path/to/user/directory

# HTTP settings
PORT=1880
NODE_RED_IP=0.0.0.0

# Database connections
MONGODB_URL=mongodb://localhost:27017/nodered
INFLUXDB_URL=http://localhost:8086
MQTT_BROKER=mqtt://localhost:1883

# API keys and tokens
WEATHER_API_KEY=your-weather-api-key
TELEGRAM_BOT_TOKEN=your-telegram-token
SLACK_WEBHOOK_URL=your-slack-webhook
```

### Flow Configuration

```json
{
  "flows": [
    {
      "id": "flow-1",
      "label": "Main Flow",
      "nodes": [],
      "configs": [],
      "subflows": []
    }
  ],
  "settings": {
    "flowFilePretty": true,
    "credentialSecret": "node-red-secret"
  }
}
```

## Core Features

### Visual Flow Editor

- **Purpose**: Drag-and-drop interface for creating automation flows
- **Usage**: Connect nodes with wires to define data flow and logic
- **Components**: Input nodes, processing nodes, output nodes, configuration nodes

### Flow-Based Programming

- **Purpose**: Event-driven programming model using message passing
- **Usage**: Messages flow between nodes carrying payload, topic, and metadata
- **Pattern**: Input → Processing → Output with branching and merging

### Real-Time Debugging

- **Purpose**: Monitor message flow and debug issues in real-time
- **Usage**: Deploy debug nodes and view messages in the debug panel
- **Features**: Message filtering, payload inspection, timestamp tracking

## Core Nodes Reference

### Input Nodes

#### Inject Node

```javascript
// Inject node configuration
{
    "type": "inject",
    "name": "Timer",
    "props": [
        {
            "p": "payload",
            "v": "Hello World",
            "vt": "str"
        },
        {
            "p": "topic",
            "v": "test/topic",
            "vt": "str"
        }
    ],
    "repeat": "5",  // Every 5 seconds
    "crontab": "",
    "once": false
}
```

#### HTTP In Node

```javascript
// HTTP endpoint configuration
{
    "type": "http in",
    "name": "API Endpoint",
    "url": "/api/data",
    "method": "post",
    "upload": false,
    "swaggerDoc": ""
}
```

#### MQTT In Node

```javascript
// MQTT subscriber configuration
{
    "type": "mqtt in",
    "name": "Sensor Data",
    "topic": "sensors/+/temperature",
    "qos": "0",
    "datatype": "auto",
    "broker": "mqtt-broker-config"
}
```

### Processing Nodes

#### Function Node

```javascript
// Function node example
// Input: msg object with payload, topic, etc.
// Output: modified msg object or array of msgs

// Simple data transformation
msg.payload = msg.payload * 2;
return msg;

// Multiple outputs
if (msg.payload > 100) {
  return [msg, null]; // Send to first output
} else {
  return [null, msg]; // Send to second output
}

// Asynchronous operations
const axios = global.get('axios');
axios
  .get('https://api.example.com/data')
  .then((response) => {
    msg.payload = response.data;
    node.send(msg);
  })
  .catch((error) => {
    node.error(error.message, msg);
  });

return null; // For async operations

// Context storage
let count = context.get('count') || 0;
count++;
context.set('count', count);
msg.payload = `Count: ${count}`;
return msg;

// Flow and global context
let globalData = global.get('sharedData');
let flowData = flow.get('flowVariable');
```

#### Switch Node

```javascript
// Switch node configuration
{
    "type": "switch",
    "name": "Route Messages",
    "property": "payload",
    "rules": [
        {
            "t": "gt",
            "v": "25",
            "vt": "num"
        },
        {
            "t": "between",
            "v": "15",
            "v2": "25",
            "vt": "num"
        },
        {
            "t": "else"
        }
    ]
}
```

#### Change Node

```javascript
// Change node operations
{
    "type": "change",
    "name": "Transform Data",
    "rules": [
        {
            "t": "set",
            "p": "payload.temperature",
            "pt": "msg",
            "to": "payload",
            "tot": "msg"
        },
        {
            "t": "move",
            "p": "payload.old_name",
            "pt": "msg",
            "to": "payload.new_name",
            "tot": "msg"
        },
        {
            "t": "delete",
            "p": "payload.unwanted",
            "pt": "msg"
        }
    ]
}
```

### Output Nodes

#### HTTP Response Node

```javascript
// HTTP response configuration
{
    "type": "http response",
    "name": "API Response",
    "statusCode": "200",
    "headers": {
        "content-type": "application/json"
    }
}
```

#### MQTT Out Node

```javascript
// MQTT publisher configuration
{
    "type": "mqtt out",
    "name": "Publish Data",
    "topic": "devices/sensor1/data",
    "qos": "0",
    "retain": "false",
    "broker": "mqtt-broker-config"
}
```

#### Debug Node

```javascript
// Debug node configuration
{
    "type": "debug",
    "name": "Debug Output",
    "active": true,
    "tosidebar": true,
    "console": false,
    "tostatus": false,
    "complete": "payload",
    "targetType": "msg"
}
```

## Common Commands

```bash
# Node-RED lifecycle
node-red                           # Start Node-RED
node-red --port 1881              # Start on different port
node-red --userDir ./myproject    # Specify user directory
node-red --safe                   # Start in safe mode
node-red --help                   # Show help

# Package management
npm install node-red-contrib-[package]  # Install community nodes
npm list                                 # List installed packages
npm update                              # Update packages
npm uninstall node-red-contrib-[package] # Remove packages

# Flow management
node-red-admin hash-pw              # Generate password hash
node-red-admin target              # Set target Node-RED instance
node-red-admin login               # Login to Node-RED admin API
node-red-admin list flows          # List flows via API

# System service (Linux)
sudo systemctl start nodered      # Start service
sudo systemctl stop nodered       # Stop service
sudo systemctl restart nodered    # Restart service
sudo systemctl status nodered     # Check status
```

## Integration & Workflow

### API Integration Patterns

#### REST API Client

```javascript
// HTTP Request node for API calls
{
    "type": "http request",
    "name": "Weather API",
    "method": "GET",
    "ret": "obj",
    "url": "https://api.openweathermap.org/data/2.5/weather",
    "tls": "",
    "persist": false,
    "proxy": "",
    "authType": "",
    "headers": {
        "User-Agent": "Node-RED"
    }
}

// Function node to prepare API request
msg.url = `https://api.openweathermap.org/data/2.5/weather?q=${msg.payload.city}&appid=${env.get('WEATHER_API_KEY')}`;
return msg;
```

#### Webhook Processing

```javascript
// Webhook flow pattern
[
  {
    type: 'http in',
    url: '/webhook/github',
    method: 'post',
  },
  {
    type: 'function',
    func: `
            // Validate webhook signature
            const crypto = require('crypto');
            const signature = msg.req.headers['x-hub-signature-256'];
            const payload = JSON.stringify(msg.payload);
            const secret = env.get('GITHUB_WEBHOOK_SECRET');
            
            const expectedSignature = 'sha256=' + crypto
                .createHmac('sha256', secret)
                .update(payload)
                .digest('hex');
            
            if (signature !== expectedSignature) {
                msg.statusCode = 401;
                msg.payload = 'Unauthorized';
                return msg;
            }
            
            // Process webhook payload
            if (msg.payload.action === 'opened') {
                msg.topic = 'pr_opened';
                msg.payload = {
                    repo: msg.payload.repository.name,
                    pr_number: msg.payload.number,
                    title: msg.payload.pull_request.title
                };
            }
            
            return msg;
        `,
  },
  {
    type: 'http response',
  },
];
```

### MQTT Integration

#### MQTT Broker Configuration

```javascript
// MQTT broker node configuration
{
    "id": "mqtt-broker",
    "type": "mqtt-broker",
    "name": "Local Broker",
    "broker": "localhost",
    "port": "1883",
    "clientid": "node-red-client",
    "usetls": false,
    "protocolVersion": "4",
    "keepalive": "60",
    "cleansession": true,
    "birthTopic": "node-red/status",
    "birthQos": "0",
    "birthPayload": "online",
    "closeTopic": "node-red/status",
    "closeQos": "0",
    "closePayload": "offline",
    "willTopic": "node-red/status",
    "willQos": "0",
    "willPayload": "offline"
}
```

#### IoT Device Communication

```javascript
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
```

### Database Integration

#### InfluxDB Time Series

```javascript
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
```

### Automation Workflows

#### Home Automation Flow

```javascript
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
```

## Best Practices

### Flow Design Patterns

#### Error Handling

```javascript
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
```

#### Rate Limiting

```javascript
// Rate limiting pattern
{
    "type": "function",
    "func": `
        const now = Date.now();
        const lastCall = context.get('lastCall') || 0;
        const rateLimit = 1000; // 1 second

        if (now - lastCall < rateLimit) {
            node.warn('Rate limit exceeded, dropping message');
            return null;
        }

        context.set('lastCall', now);
        return msg;
    `
}
```

#### Message Batching

```javascript
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
```

### Performance Optimization

#### Memory Management

```javascript
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
```

#### Async Processing

```javascript
// Non-blocking async operations
{
    "type": "function",
    "func": `
        const processAsync = async (data) => {
            try {
                const result = await heavyProcessing(data);
                msg.payload = result;
                node.send(msg);
            } catch (error) {
                node.error(error.message, msg);
            }
        };

        // Don't block the event loop
        setImmediate(() => processAsync(msg.payload));

        return null; // Don't return msg synchronously
    `
}
```

## Version Control and Environments

### Git Integration

#### Flow Version Control

```json
// .gitignore for Node-RED projects
flows_*.json.backup
.flows.json.backup
*_cred.json
node_modules/
.npm/
.sessions.json
```

#### Project Structure

```
node-red-project/
├── flows/
│   ├── development.json
│   ├── staging.json
│   └── production.json
├── settings/
│   ├── development.js
│   ├── staging.js
│   └── production.js
├── package.json
├── README.md
└── .gitignore
```

#### Environment-Specific Flows

```javascript
// Environment switching function
const loadEnvironmentFlows = (environment) => {
  const fs = require('fs');
  const path = require('path');

  const flowsFile = path.join(__dirname, 'flows', `${environment}.json`);
  const settingsFile = path.join(__dirname, 'settings', `${environment}.js`);

  process.env.NODE_RED_FLOWS = flowsFile;
  process.env.NODE_RED_SETTINGS = settingsFile;
};

// Usage
const env = process.env.NODE_ENV || 'development';
loadEnvironmentFlows(env);
```

### Deployment Strategies

#### CI/CD Pipeline

```yaml
# GitHub Actions workflow
name: Node-RED Deploy
on:
  push:
    branches: [main]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3

      - name: Setup Node.js
        uses: actions/setup-node@v3
        with:
          node-version: '18'

      - name: Install dependencies
        run: npm install

      - name: Validate flows
        run: node scripts/validate-flows.js

      - name: Deploy to staging
        run: |
          scp flows/staging.json user@staging-server:/opt/node-red/
          ssh user@staging-server "sudo systemctl restart nodered"

      - name: Run tests
        run: npm test

      - name: Deploy to production
        if: success()
        run: |
          scp flows/production.json user@prod-server:/opt/node-red/
          ssh user@prod-server "sudo systemctl restart nodered"
```

#### Blue-Green Deployment

```bash
#!/bin/bash
# Blue-green deployment script

BLUE_PORT=1880
GREEN_PORT=1881
HEALTH_CHECK_URL="http://localhost"

# Deploy to green environment
echo "Deploying to green environment..."
NODE_RED_PORT=$GREEN_PORT node-red --userDir ./green &
GREEN_PID=$!

# Wait for startup
sleep 10

# Health check
if curl -f "$HEALTH_CHECK_URL:$GREEN_PORT/health"; then
    echo "Green environment healthy, switching traffic..."

    # Update load balancer configuration
    # Switch nginx upstream or update DNS

    # Stop blue environment
    kill $BLUE_PID

    echo "Deployment complete"
else
    echo "Green environment unhealthy, rolling back..."
    kill $GREEN_PID
    exit 1
fi
```

## Common Use Cases

### IoT Data Processing Pipeline

**Scenario**: Process sensor data from multiple IoT devices
**Implementation**:

```javascript
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
```

**Expected Result**: Processed and validated sensor data with anomaly detection and alerting

### API Gateway and Service Integration

**Scenario**: Create an API gateway that aggregates multiple microservices
**Implementation**:

```javascript
// API Gateway flow
const apiGateway = {
  flows: [
    {
      id: 'api-gateway',
      label: 'API Gateway',
      nodes: [
        // API endpoint
        {
          type: 'http in',
          url: '/api/v1/+',
          method: 'get',
        },

        // Authentication middleware
        {
          type: 'function',
          name: 'Authentication',
          func: `
                        const token = msg.req.headers.authorization;
                        
                        if (!token || !token.startsWith('Bearer ')) {
                            msg.statusCode = 401;
                            msg.payload = { error: 'Unauthorized' };
                            return [null, msg]; // Send to error output
                        }
                        
                        // Validate JWT token (simplified)
                        try {
                            const jwt = require('jsonwebtoken');
                            const decoded = jwt.verify(token.substring(7), process.env.JWT_SECRET);
                            msg.user = decoded;
                            return [msg, null]; // Send to success output
                        } catch (error) {
                            msg.statusCode = 401;
                            msg.payload = { error: 'Invalid token' };
                            return [null, msg];
                        }
                    `,
          outputs: 2,
        },

        // Route to appropriate service
        {
          type: 'switch',
          property: 'req.url',
          rules: [
            { t: 'regex', v: '^/api/v1/users', case: false },
            { t: 'regex', v: '^/api/v1/orders', case: false },
            { t: 'regex', v: '^/api/v1/products', case: false },
            { t: 'else' },
          ],
        },

        // User service call
        {
          type: 'function',
          name: 'User Service',
          func: `
                        const baseUrl = process.env.USER_SERVICE_URL || 'http://user-service:3000';
                        msg.url = baseUrl + msg.req.url.replace('/api/v1', '');
                        msg.method = msg.req.method;
                        msg.headers = {
                            'Content-Type': 'application/json',
                            'X-User-ID': msg.user.id
                        };
                        return msg;
                    `,
        },

        // HTTP request to service
        {
          type: 'http request',
          method: 'use',
          ret: 'obj',
        },

        // Response formatting
        {
          type: 'function',
          name: 'Format Response',
          func: `
                        // Add response metadata
                        const response = {
                            data: msg.payload,
                            timestamp: new Date().toISOString(),
                            requestId: msg._msgid
                        };
                        
                        msg.payload = response;
                        msg.headers = {
                            'Content-Type': 'application/json',
                            'X-Response-Time': Date.now() - msg.req.timestamp
                        };
                        
                        return msg;
                    `,
        },

        // HTTP response
        {
          type: 'http response',
        },
      ],
    },
  ],
};
```

**Expected Result**: Full-featured API gateway with authentication, routing, and response formatting

### Industrial Automation Control

**Scenario**: Monitor and control industrial equipment via Modbus and OPC-UA
**Implementation**:

```javascript
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
```

**Expected Result**: Automated industrial control system with sensor monitoring and safety controls

## Troubleshooting

### Common Issues

#### Memory Leaks

**Problem**: Node-RED process memory usage continuously grows
**Symptoms**: Slow performance, eventual crashes, high memory usage
**Solution**:

```javascript
// Identify memory leaks
// 1. Check context usage
context.keys().forEach((key) => {
  const value = context.get(key);
  console.log(`Context ${key}: ${JSON.stringify(value).length} bytes`);
});

// 2. Clear unused context
context.set('largeData', undefined);

// 3. Use external storage for large data
const redis = require('redis');
const client = redis.createClient();
```

#### Flow Deployment Failures

**Problem**: Flows fail to deploy with cryptic errors
**Symptoms**: Red triangle indicators, deploy button remains active
**Solution**:

```bash
# Check Node-RED logs
journalctl -u nodered -f

# Validate flow JSON
node -e "console.log(JSON.parse(require('fs').readFileSync('flows.json')))"

# Safe mode start
node-red --safe

# Clear cache
rm -rf ~/.node-red/.sessions.json
```

#### MQTT Connection Issues

**Problem**: MQTT nodes show disconnected status
**Symptoms**: No message flow, connection errors in debug
**Solution**:

```javascript
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
```

### Debug Mode

#### Enable Verbose Logging

```javascript
// settings.js logging configuration
logging: {
    console: {
        level: "debug",
        metrics: true,
        audit: true
    },
    file: {
        level: "info",
        filename: "/var/log/node-red/node-red.log",
        maxFiles: 5,
        maxSize: "10MB"
    }
}
```

#### Flow Debugging Techniques

```javascript
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
```

## Security Considerations

### Authentication and Authorization

#### Secure Admin Interface

```javascript
// settings.js security configuration
module.exports = {
  adminAuth: {
    type: 'credentials',
    users: [
      {
        username: 'admin',
        password: '$2b$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.',
        permissions: '*',
      },
    ],
    sessionExpiryTime: 86400, // 24 hours
    tokens: {
      expiresIn: '7d',
    },
  },

  // HTTP endpoint authentication
  httpNodeAuth: {
    user: 'api-user',
    pass: '$2b$08$zZWtXTja0fB1pzD4sHCMyOCMYz2Z6dNbM6tl8sJogENOMcxWV9DN.',
  },

  // HTTPS configuration
  https: {
    key: require('fs').readFileSync('private-key.pem'),
    cert: require('fs').readFileSync('certificate.pem'),
  },
};
```

#### API Security

```javascript
// API security middleware
{
    "type": "function",
    "name": "Security Middleware",
    "func": `
        // Rate limiting
        const ip = msg.req.connection.remoteAddress;
        const rateKey = 'rate_' + ip;
        let requests = context.get(rateKey) || [];
        const now = Date.now();

        // Clean old requests (1 minute window)
        requests = requests.filter(time => now - time < 60000);

        if (requests.length >= 100) { // 100 requests per minute
            msg.statusCode = 429;
            msg.payload = { error: 'Rate limit exceeded' };
            return [null, msg];
        }

        requests.push(now);
        context.set(rateKey, requests);

        // Input validation
        const allowedPaths = ['/api/data', '/api/status', '/api/health'];
        if (!allowedPaths.includes(msg.req.url)) {
            msg.statusCode = 404;
            msg.payload = { error: 'Not found' };
            return [null, msg];
        }

        // Sanitize headers
        delete msg.req.headers['x-forwarded-for'];

        return [msg, null];
    `,
    "outputs": 2
}
```

### Data Protection

#### Encryption at Rest

```javascript
// Encrypt sensitive data in context
{
    "type": "function",
    "func": `
        const crypto = require('crypto');
        const algorithm = 'aes-256-cbc';
        const key = process.env.ENCRYPTION_KEY;

        if (!key) {
            node.error('Encryption key not configured');
            return null;
        }

        // Encrypt payload
        const iv = crypto.randomBytes(16);
        const cipher = crypto.createCipher(algorithm, key);
        let encrypted = cipher.update(JSON.stringify(msg.payload), 'utf8', 'hex');
        encrypted += cipher.final('hex');

        // Store encrypted data
        context.set('encrypted_data', {
            data: encrypted,
            iv: iv.toString('hex')
        });

        return msg;
    `
}
```

## Advanced Configuration

### Custom Node Development

#### Simple Input Node

```javascript
// custom-sensor-node.js
module.exports = function (RED) {
  function CustomSensorNode(config) {
    RED.nodes.createNode(this, config);
    const node = this;

    // Configuration
    this.sensorType = config.sensorType;
    this.interval = config.interval || 5000;

    // Simulated sensor data
    this.timer = setInterval(() => {
      let value;
      switch (this.sensorType) {
        case 'temperature':
          value = 20 + Math.random() * 10;
          break;
        case 'humidity':
          value = 50 + Math.random() * 30;
          break;
        default:
          value = Math.random() * 100;
      }

      const msg = {
        payload: {
          value: value,
          unit: this.sensorType === 'temperature' ? '°C' : '%',
          timestamp: new Date().toISOString(),
        },
        topic: `sensor/${this.sensorType}`,
      };

      node.send(msg);
    }, this.interval);

    // Cleanup on close
    this.on('close', () => {
      if (this.timer) {
        clearInterval(this.timer);
      }
    });
  }

  RED.nodes.registerType('custom-sensor', CustomSensorNode);
};
```

#### Node HTML Template

```html
<!-- custom-sensor-node.html -->
<script type="text/javascript">
  RED.nodes.registerType('custom-sensor', {
    category: 'input',
    color: '#a6bbcf',
    defaults: {
      name: { value: '' },
      sensorType: { value: 'temperature', required: true },
      interval: { value: 5000, required: true, validate: RED.validators.number() },
    },
    inputs: 0,
    outputs: 1,
    icon: 'file.png',
    label: function () {
      return this.name || 'Custom Sensor';
    },
  });
</script>

<script type="text/html" data-template-name="custom-sensor">
  <div class="form-row">
    <label for="node-input-name"><i class="icon-tag"></i> Name</label>
    <input type="text" id="node-input-name" placeholder="Name" />
  </div>
  <div class="form-row">
    <label for="node-input-sensorType"><i class="fa fa-thermometer"></i> Sensor Type</label>
    <select id="node-input-sensorType">
      <option value="temperature">Temperature</option>
      <option value="humidity">Humidity</option>
      <option value="pressure">Pressure</option>
    </select>
  </div>
  <div class="form-row">
    <label for="node-input-interval"><i class="fa fa-clock-o"></i> Interval (ms)</label>
    <input type="number" id="node-input-interval" placeholder="5000" />
  </div>
</script>

<script type="text/html" data-help-name="custom-sensor">
  <p>A custom sensor node that generates simulated sensor data.</p>
  <h3>Outputs</h3>
  <dl class="message-properties">
    <dt>payload <span class="property-type">object</span></dt>
    <dd>Sensor data including value, unit, and timestamp</dd>
    <dt>topic <span class="property-type">string</span></dt>
    <dd>Sensor topic in format "sensor/{type}"</dd>
  </dl>
</script>
```

### Performance Tuning

#### Memory Optimization

```javascript
// settings.js performance configuration
module.exports = {
  // Increase Node.js memory limit
  nodeOptions: '--max-old-space-size=4096',

  // Optimize garbage collection
  runtimeState: {
    enabled: false,
    ui: false,
  },

  // Reduce logging in production
  logging: {
    console: {
      level: process.env.NODE_ENV === 'production' ? 'warn' : 'info',
      metrics: false,
      audit: false,
    },
  },

  // Connection pooling
  httpRequestTimeout: 120000,
  httpMaxRedirects: 20,

  // Context storage optimization
  contextStorage: {
    default: 'memoryOnly',
    file: {
      module: 'localfilesystem',
      config: {
        flushInterval: 30,
      },
    },
  },
};
```

## Useful Resources

- **Official Node-RED Documentation**: https://nodered.org/docs/
- **Node-RED Library**: https://flows.nodered.org/
- **GitHub Repository**: https://github.com/node-red/node-red
- **Community Forum**: https://discourse.nodered.org/
- **Docker Hub**: https://hub.docker.com/r/nodered/node-red
- **Cookbook**: https://cookbook.nodered.org/
- **Stack Overflow Tag**: node-red
- **YouTube Channel**: https://www.youtube.com/c/NodeRED

## AI Assistant Guidelines

When helping with Node-RED development:

1. **Always suggest current Node-RED version 3.1+** and compatible Node.js versions
2. **Provide complete flow examples** with proper node configuration
3. **Include error handling patterns** in function nodes
4. **Consider performance implications** of flow designs
5. **Suggest appropriate community nodes** when built-in nodes are insufficient
6. **Include security considerations** for production deployments
7. **Provide testing strategies** for flow validation
8. **Reference official documentation** for complex scenarios

### Flow Generation Rules

- Generate flows that follow Node-RED best practices
- Use appropriate node types for specific use cases
- Include proper error handling and validation
- Implement efficient message passing patterns
- Consider scalability and performance requirements
- Include debugging and monitoring capabilities
- Follow security guidelines for production use
- Provide clear documentation and naming conventions

### Code Generation for Function Nodes

```javascript
// Template for robust function nodes
// Input validation
if (!msg.payload) {
  node.warn('Empty payload received');
  return null;
}

try {
  // Main processing logic
  const result = processData(msg.payload);

  // Output validation
  if (result !== null && result !== undefined) {
    msg.payload = result;
    return msg;
  } else {
    node.warn('Processing returned null result');
    return null;
  }
} catch (error) {
  // Error handling
  node.error(`Processing failed: ${error.message}`, msg);

  // Optional: Send to error output
  const errorMsg = {
    topic: 'error',
    payload: {
      error: error.message,
      original: msg.payload,
      timestamp: new Date().toISOString(),
    },
  };

  return [null, errorMsg]; // For nodes with multiple outputs
}
```
