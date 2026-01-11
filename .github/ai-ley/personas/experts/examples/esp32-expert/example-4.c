#include "freertos/FreeRTOS.h"
#include "freertos/task.h"
#include "freertos/queue.h"

QueueHandle_t sensorQueue;

void sensorTask(void *parameter) {
    sensor_data_t data;
    
    while (1) {
        // Read sensor data
        data.value = readSensor();
        data.timestamp = xTaskGetTickCount();
        
        // Send to processing task
        xQueueSend(sensorQueue, &data, portMAX_DELAY);
        
        vTaskDelay(pdMS_TO_TICKS(1000));
    }
}

void processingTask(void *parameter) {
    sensor_data_t data;
    
    while (1) {
        if (xQueueReceive(sensorQueue, &data, portMAX_DELAY)) {
            // Process data
            processData(&data);
            
            // Send to cloud if WiFi connected
            if (isWiFiConnected()) {
                sendToCloud(&data);
            }
        }
    }
}