# Route 53 health checks for failover
aws route53 create-health-check \
    --caller-reference $(date +%s) \
    --health-check-config Type=HTTPS,ResourcePath=/health,FullyQualifiedDomainName=api.example.com,Port=443