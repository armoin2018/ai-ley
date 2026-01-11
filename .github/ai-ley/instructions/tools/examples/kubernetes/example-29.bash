# Check PV and PVC status
kubectl get pv,pvc
kubectl describe pvc pvc-name

# Check storage class
kubectl get storageclass
kubectl describe storageclass class-name

# Debug volume permissions
kubectl exec -it pod-name -- ls -la /mount/path
kubectl exec -it pod-name -- id