# CloudWatch Logs Insights queries
aws logs start-query \
    --log-group-name "/aws/lambda/my-function" \
    --start-time $(date -d '1 hour ago' +%s) \
    --end-time $(date +%s) \
    --query-string 'fields @timestamp, @message | filter @message like /ERROR/ | sort @timestamp desc | limit 20'