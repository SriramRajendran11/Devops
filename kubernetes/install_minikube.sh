sudo apt-get update && sudo apt-get install -y curl 
#for 1.34 or latest..
curl -LO https://storage.googleapis.com/minikube/releases/latest/minikube_latest_amd64.deb
sudo apt-get  install -y ./minikube_latest_amd64.deb && sudo apt-get clean  
rm minikube_latest_amd64.deb

# for specific version... replace 1.31.2 with the version.
#curl -L https://github.com/kubernetes/minikube/releases/download/v1.31.2/minikube-linux-amd64 -o minikube
#chmod +x minikube
#sudo mv minikube /usr/bin
#minikube start --vm-driver=docker  --mount-string="/home/sidkalpop:/data" --mount 
minikube addons enable metrics-server

