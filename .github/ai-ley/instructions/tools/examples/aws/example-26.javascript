// Custom CloudWatch metrics
const AWS = require('aws-sdk');
const cloudwatch = new AWS.CloudWatch();

async function publishCustomMetric(metricName, value, unit = 'Count') {
  const params = {
    Namespace: 'MyApp/Performance',
    MetricData: [
      {
        MetricName: metricName,
        Value: value,
        Unit: unit,
        Timestamp: new Date(),
      },
    ],
  };

  try {
    const result = await cloudwatch.putMetricData(params).promise();
    console.log('Metric published:', result);
  } catch (error) {
    console.error('Error publishing metric:', error);
  }
}

// Usage
publishCustomMetric('UserRegistrations', 1);
publishCustomMetric('ResponseTime', 150, 'Milliseconds');