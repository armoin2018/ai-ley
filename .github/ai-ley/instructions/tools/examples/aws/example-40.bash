# Stream CloudWatch logs
aws logs tail /aws/lambda/my-function --follow

# Query logs with insights
aws logs start-query \
    --log-group-name "/aws/apigateway/my-api" \
    --start-time 1640995200 \
    --end-time 1641081600 \
    --query-string 'fields @timestamp, @message | filter @message like /ERROR/'