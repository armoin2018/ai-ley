#include "esp_bt.h"
#include "esp_gap_ble_api.h"
#include "esp_gatts_api.h"

static void gatts_event_handler(esp_gatts_cb_event_t event, esp_gatt_if_t gatts_if,
                               esp_ble_gatts_cb_param_t *param) {
    switch (event) {
        case ESP_GATTS_REG_EVT:
            esp_ble_gap_set_device_name("ESP32_Device");
            esp_ble_gap_config_adv_data(&adv_data);
            break;
            
        case ESP_GATTS_READ_EVT:
            esp_gatt_rsp_t rsp;
            memset(&rsp, 0, sizeof(esp_gatt_rsp_t));
            rsp.attr_value.handle = param->read.handle;
            rsp.attr_value.len = 4;
            rsp.attr_value.value[0] = 0x01;
            esp_ble_gatts_send_response(gatts_if, param->read.conn_id, 
                                       param->read.trans_id, ESP_GATT_OK, &rsp);
            break;
    }
}