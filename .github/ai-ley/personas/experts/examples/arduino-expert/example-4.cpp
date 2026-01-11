#include <Wire.h>
#include <SensorLibrary.h>

SensorClass sensor;

void setup() {
  Serial.begin(115200);
  Wire.begin();
  
  if (!sensor.begin()) {
    Serial.println("Sensor initialization failed!");
    while (1);
  }
}

void loop() {
  float value = sensor.readValue();
  
  if (sensor.isDataReady()) {
    Serial.print("Sensor Value: ");
    Serial.println(value);
  }
  
  delay(1000);
}