#include <ArduinoLowPower.h>

void enterSleepMode() {
  // Disable unnecessary peripherals
  Serial.end();
  
  // Set wake-up interrupt
  LowPower.attachInterruptWakeup(digitalPinToInterrupt(2), wakeUp, RISING);
  
  // Enter sleep mode
  LowPower.deepSleep();
}

void wakeUp() {
  // Re-initialize peripherals
  Serial.begin(115200);
}