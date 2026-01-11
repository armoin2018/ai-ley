# Minikube installation and setup
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube-linux-amd64
sudo install minikube-linux-amd64 /usr/local/bin/minikube

# Start local cluster
minikube start --driver=docker --cpus=4 --memory=8192
minikube addons enable ingress
minikube addons enable dashboard
minikube addons enable metrics-server

# Kind (Kubernetes in Docker) setup
go install sigs.k8s.io/kind@v0.20.0
kind create cluster --config=kind-config.yaml

# Docker Desktop Kubernetes
# Enable Kubernetes in Docker Desktop settings

# Verify cluster access
kubectl cluster-info
kubectl get nodes
kubectl get pods --all-namespaces