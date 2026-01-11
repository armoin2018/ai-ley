#!/bin/bash
# Blue-green deployment script

BLUE_PORT=1880
GREEN_PORT=1881
HEALTH_CHECK_URL="http://localhost"

# Deploy to green environment
echo "Deploying to green environment..."
NODE_RED_PORT=$GREEN_PORT node-red --userDir ./green &
GREEN_PID=$!

# Wait for startup
sleep 10

# Health check
if curl -f "$HEALTH_CHECK_URL:$GREEN_PORT/health"; then
    echo "Green environment healthy, switching traffic..."

    # Update load balancer configuration
    # Switch nginx upstream or update DNS

    # Stop blue environment
    kill $BLUE_PID

    echo "Deployment complete"
else
    echo "Green environment unhealthy, rolling back..."
    kill $GREEN_PID
    exit 1
fi