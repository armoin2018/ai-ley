# values-development.yaml
replicaCount: 1
image:
  tag: development
app:
  environment: development
  logLevel: debug
resources:
  limits:
    cpu: 200m
    memory: 256Mi
  requests:
    cpu: 100m
    memory: 128Mi
autoscaling:
  enabled: false

# values-staging.yaml
replicaCount: 2
image:
  tag: staging
app:
  environment: staging
  logLevel: info
ingress:
  hosts:
    - host: staging.myapp.com
      paths:
        - path: /
          pathType: Prefix

# values-production.yaml
replicaCount: 5
image:
  tag: stable
app:
  environment: production
  logLevel: warn
resources:
  limits:
    cpu: 1000m
    memory: 1Gi
  requests:
    cpu: 500m
    memory: 512Mi
autoscaling:
  enabled: true
  minReplicas: 5
  maxReplicas: 20

# Deploy to different environments
helm install myapp-dev ./charts/web-app -f values-development.yaml -n development
helm install myapp-staging ./charts/web-app -f values-staging.yaml -n staging
helm install myapp-prod ./charts/web-app -f values-production.yaml -n production