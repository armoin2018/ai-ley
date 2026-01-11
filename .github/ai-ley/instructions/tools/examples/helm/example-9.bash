#!/bin/bash
# blue-green-deploy.sh

CHART_PATH="./charts/web-app"
NAMESPACE="production"
APP_NAME="myapp"
NEW_VERSION=$1

if [ -z "$NEW_VERSION" ]; then
  echo "Usage: $0 <new-version>"
  exit 1
fi

# Get current active deployment
CURRENT_RELEASE=$(helm list -n $NAMESPACE -o json | jq -r '.[] | select(.name | startswith("'$APP_NAME'")) | .name')
CURRENT_COLOR=$(echo $CURRENT_RELEASE | sed "s/$APP_NAME-//")

# Determine new color
if [ "$CURRENT_COLOR" = "blue" ]; then
  NEW_COLOR="green"
else
  NEW_COLOR="blue"
fi

NEW_RELEASE="$APP_NAME-$NEW_COLOR"

echo "Deploying $NEW_RELEASE with version $NEW_VERSION..."

# Deploy new version
helm upgrade --install $NEW_RELEASE $CHART_PATH \
  --namespace $NAMESPACE \
  --set image.tag=$NEW_VERSION \
  --set nameOverride=$APP_NAME-$NEW_COLOR \
  --wait

# Test new deployment
echo "Testing new deployment..."
kubectl port-forward -n $NAMESPACE svc/$NEW_RELEASE 8080:80 &
PF_PID=$!
sleep 5

# Simple health check
HEALTH_CHECK=$(curl -s -o /dev/null -w "%{http_code}" http://localhost:8080/health)
kill $PF_PID

if [ "$HEALTH_CHECK" = "200" ]; then
  echo "Health check passed. Switching traffic..."

  # Update ingress to point to new deployment
  helm upgrade $NEW_RELEASE $CHART_PATH \
    --namespace $NAMESPACE \
    --set image.tag=$NEW_VERSION \
    --set nameOverride=$APP_NAME \
    --reuse-values

  echo "Traffic switched to $NEW_COLOR deployment"

  # Clean up old deployment after verification
  read -p "Remove old $CURRENT_COLOR deployment? (y/N): " -n 1 -r
  echo
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    helm uninstall $CURRENT_RELEASE -n $NAMESPACE
    echo "Old deployment removed"
  fi
else
  echo "Health check failed. Rolling back..."
  helm uninstall $NEW_RELEASE -n $NAMESPACE
  exit 1
fi