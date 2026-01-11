#include <ESP8266WiFi.h>

const int SLEEP_TIME = 30 * 60 * 1000000; // 30 minutes in microseconds

void setup() {
  Serial.begin(115200);
  
  // Connect to WiFi quickly
  WiFi.mode(WIFI_STA);
  WiFi.begin("SSID", "PASSWORD");
  
  // Wait for connection with timeout
  int timeout = 0;
  while (WiFi.status() != WL_CONNECTED && timeout < 20) {
    delay(500);
    timeout++;
  }
  
  if (WiFi.status() == WL_CONNECTED) {
    // Read sensor and send data
    float temperature = readTemperature();
    sendDataToServer(temperature);
  }
  
  // Enter deep sleep
  ESP.deepSleep(SLEEP_TIME);
}

void loop() {
  // Never reached due to deep sleep
}