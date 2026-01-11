// custom-sensor-node.js
module.exports = function (RED) {
  function CustomSensorNode(config) {
    RED.nodes.createNode(this, config);
    const node = this;

    // Configuration
    this.sensorType = config.sensorType;
    this.interval = config.interval || 5000;

    // Simulated sensor data
    this.timer = setInterval(() => {
      let value;
      switch (this.sensorType) {
        case 'temperature':
          value = 20 + Math.random() * 10;
          break;
        case 'humidity':
          value = 50 + Math.random() * 30;
          break;
        default:
          value = Math.random() * 100;
      }

      const msg = {
        payload: {
          value: value,
          unit: this.sensorType === 'temperature' ? '°C' : '%',
          timestamp: new Date().toISOString(),
        },
        topic: `sensor/${this.sensorType}`,
      };

      node.send(msg);
    }, this.interval);

    // Cleanup on close
    this.on('close', () => {
      if (this.timer) {
        clearInterval(this.timer);
      }
    });
  }

  RED.nodes.registerType('custom-sensor', CustomSensorNode);
};