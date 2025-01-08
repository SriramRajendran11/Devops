# Adapt as necessary
minikube start --vm-driver=docker --container-runtime=containerd --memory 4400 --cpus 4
minikube addons enable metrics-server
