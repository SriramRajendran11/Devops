# Adapt the below as necessary
minikube start --vm-driver=docker --container-runtime=containerd --memory 4400 --cpus 4
minikube addons enable metrics-server

# a more
#minikube start --vm-driver=docker --container-runtime=containerd --mount-string="/home/demouser:/data" --mount  --memory 10000 --cpus 4
#minikube addons enable metrics-server
#minikube addons enable default-storageclass
#minikube addons enable storage-provisioner