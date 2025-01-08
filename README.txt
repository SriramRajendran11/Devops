This contains the scripts for installing minikube on a WSL2 (windows 11 Home Edition) Ubuntu 22.04 LTS distro. 
It also contains scripts for installing prometheus, Grafana and ELK stacks
Adapt as neccessary 

It also contains scripts for some docker and vagrant/virtual box demos

dockerfiles_ansible = Build docker images for Ansible master and nodes and run them using docker-compose
docker - 
		Contains how to build a docker image for Jenkins and start the same
		Contains example on why we need multi-stage builds
		A sample LAMP application using docker-compose
vagrant-ansible -
		Contains information on starting Ansible master and nodes on Separate Oracle Virtual Box instances
Vagrant-kubeadm-Kubernetes
		Build a master/2 node Kubernetes cluster using Oracle Virtual Box 
