# Managed Kubernetes services
# AWS EKS
eksctl create cluster --name production-cluster --region us-west-2 --nodegroup-name standard-workers --node-type m5.xlarge --nodes 3 --nodes-min 1 --nodes-max 4

# Google GKE
gcloud container clusters create production-cluster --zone us-central1-a --num-nodes 3 --machine-type n1-standard-4 --enable-autoscaling --min-nodes 1 --max-nodes 10

# Azure AKS
az aks create --resource-group myResourceGroup --name production-cluster --node-count 3 --node-vm-size Standard_D4s_v3 --enable-addons monitoring --generate-ssh-keys

# Configure kubectl for cluster access
aws eks update-kubeconfig --region us-west-2 --name production-cluster
gcloud container clusters get-credentials production-cluster --zone us-central1-a
az aks get-credentials --resource-group myResourceGroup --name production-cluster