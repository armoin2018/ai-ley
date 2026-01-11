# Test DNS resolution
kubectl run dns-debug --image=busybox -it --rm -- nslookup service-name

# Check service endpoints
kubectl get endpoints service-name
kubectl describe service service-name

# Test network connectivity
kubectl exec -it pod-name -- nc -zv service-name port

# Check network policies
kubectl get networkpolicies
kubectl describe networkpolicy policy-name