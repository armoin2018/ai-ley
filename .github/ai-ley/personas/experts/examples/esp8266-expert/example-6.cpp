#include <ESP8266WiFi.h>
#include <PubSubClient.h>

WiFiClient wifiClient;
PubSubClient client(wifiClient);

void setup() {
  WiFi.begin("SSID", "PASSWORD");
  client.setServer("mqtt.broker.com", 1883);
  client.setCallback(messageCallback);
}

void loop() {
  if (!client.connected()) {
    reconnectMQTT();
  }
  client.loop();
  
  // Publish sensor data every 30 seconds
  static unsigned long lastMsg = 0;
  unsigned long now = millis();
  if (now - lastMsg > 30000) {
    lastMsg = now;
    
    String payload = "{\"temperature\":" + String(readTemperature()) + "}";
    client.publish("sensors/temperature", payload.c_str());
  }
}

void reconnectMQTT() {
  while (!client.connected()) {
    if (client.connect("ESP8266Client")) {
      client.subscribe("commands/relay");
    } else {
      delay(5000);
    }
  }
}