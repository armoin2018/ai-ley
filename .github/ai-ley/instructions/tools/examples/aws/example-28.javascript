// X-Ray tracing in Lambda function
const AWSXRay = require('aws-xray-sdk-core');
const AWS = AWSXRay.captureAWS(require('aws-sdk'));

exports.handler = async (event, context) => {
  const segment = AWSXRay.getSegment();
  const subsegment = segment.addNewSubsegment('database-query');

  try {
    // Your application code here
    const dynamodb = new AWS.DynamoDB.DocumentClient();
    const result = await dynamodb
      .get({
        TableName: 'Users',
        Key: { userId: event.userId },
      })
      .promise();

    subsegment.close();
    return { statusCode: 200, body: JSON.stringify(result) };
  } catch (error) {
    subsegment.addError(error);
    subsegment.close();
    throw error;
  }
};