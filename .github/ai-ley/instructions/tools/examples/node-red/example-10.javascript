// MQTT subscriber configuration
{
    "type": "mqtt in",
    "name": "Sensor Data",
    "topic": "sensors/+/temperature",
    "qos": "0",
    "datatype": "auto",
    "broker": "mqtt-broker-config"
}