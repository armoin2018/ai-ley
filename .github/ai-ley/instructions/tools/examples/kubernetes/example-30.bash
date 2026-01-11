# Enable verbose kubectl output
kubectl --v=8 get pods

# Use kubectl debug for troubleshooting
kubectl debug pod-name -it --image=busybox

# Create debug container in existing pod
kubectl debug pod-name -it --image=busybox --target=container-name

# Copy files from pod for analysis
kubectl cp pod-name:/path/to/file ./local-file

# Port forward for debugging
kubectl port-forward pod/pod-name 8080:80

# Proxy for accessing Kubernetes API
kubectl proxy --port=8080