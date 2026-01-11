#include <WiFiNINA.h>
#include <PubSubClient.h>

WiFiClient wifiClient;
PubSubClient mqttClient(wifiClient);

void setup() {
  connectWiFi();
  mqttClient.setServer("mqtt.broker.com", 1883);
  mqttClient.setCallback(messageCallback);
}

void publishSensorData(float value) {
  String payload = "{\"sensor\":\"temperature\",\"value\":" + String(value) + "}";
  mqttClient.publish("sensors/data", payload.c_str());
}