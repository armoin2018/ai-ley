# Check pod status and events
kubectl describe pod pod-name
kubectl get events --field-selector involvedObject.name=pod-name

# Check logs
kubectl logs pod-name
kubectl logs pod-name --previous  # Previous container logs

# Debug with temporary container
kubectl run debug --image=busybox -it --rm -- /bin/sh

# Check resource constraints
kubectl top pod pod-name
kubectl describe node node-name