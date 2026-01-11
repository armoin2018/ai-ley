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