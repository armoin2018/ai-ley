// MQTT publisher configuration
{
    "type": "mqtt out",
    "name": "Publish Data",
    "topic": "devices/sensor1/data",
    "qos": "0",
    "retain": "false",
    "broker": "mqtt-broker-config"
}