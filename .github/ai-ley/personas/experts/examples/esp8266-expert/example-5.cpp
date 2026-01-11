#include <ESP8266WebServer.h>
#include <LittleFS.h>

ESP8266WebServer server(80);

void setup() {
  // Initialize file system
  if (!LittleFS.begin()) {
    Serial.println("Failed to mount file system");
    return;
  }
  
  // Setup routes
  server.on("/", handleRoot);
  server.on("/api/status", HTTP_GET, handleStatus);
  server.onNotFound(handleNotFound);
  
  server.begin();
}

void handleRoot() {
  // Serve from flash to save RAM
  File file = LittleFS.open("/index.html", "r");
  if (!file) {
    server.send(404, "text/plain", "File not found");
    return;
  }
  
  server.streamFile(file, "text/html");
  file.close();
}

void loop() {
  server.handleClient();
  yield(); // Allow ESP8266 to handle WiFi stack
}