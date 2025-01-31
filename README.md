# Sample Code and Presentations
This contains the scripts for installing minikube on a WSL2 (windows 11 Home Edition) Ubuntu 22.04 LTS distro. 
It also contains scripts for installing prometheus, Grafana and ELK stacks
Adapt as neccessary 

It also contains scripts for some docker and vagrant/virtual box demos

# Change History 
Jan 31 2025 - Added support for Rootless Docker installation - USE AT YOUR OWN RISK
Jan 25 2025 - Added Support for creating a Debian Virtual Box using Terraform

# SW
1. WSL2 Ubuntu 22/24 instance (NB: DOcker Desktop integration is turned off for same)
2. Optional: Oracle Virtual box/Vagrant
3. Terraform 

# How to get started
1. Install WSL2 (with Updates)
2. Install Ubuntu 22. 04 from Microsoft Store
3. Log in to Ubuntu 
4. Optional - make your unix user be part of sudoers group with no passwd. (Ref any ubuntu how-to for this)
5. install git if not already installed
    
       sudo apt-get update && apt-get install -y git 
6. clone this directory and navigate to it. We will assume it's DevOps
7. make all .sh files excecutable
   
       find . -name "*.sh" -exec chmod +x {} \; 

8. Optional: make all files have an UNIX EOL ending. There are multiple options - hence not recommending anything here. 
9. As normal user, run

     ./install_docker.sh 

10. Exit out of the Ubuntu window (close it ) and re-open it. You should now be able to see an empty output if you run 

         docker ps
11. If you have an error, try the below 
      * Make yourself part of docker group 
            
            sudo usermod -aG docker <yourusername> 
       * log out of Ubuntu, log back in again and try this agains

               docker ps        
12. navigate to the kuberetes folder and run 

        ./install_helm.sh 
        ./install_kubectl.sh 
        ./install_minikube.sh 


## Folder Structure
1. docker
    1.  jenkins - contains instructions on how to build and run jenkins as a docker image
    2.  lamp-dockercompose - A sample LAMP application using docker-compose
    3.  multi-build - Contains example on why we need multi-stage builds
2. dockerfiles_ansible - Build docker images for Ansible. Read the Instructions file found in this directory on how to use it. In particular it build the master/nodes and runs them as docker compose up -d. 
3. kubernetes
     1. deploy  - contains sample for deploying application using
          1. yaml - raw deployment using yml/kustomization
          2. helm - install apps using helm
     2. logging - scripts and yml files to install prometheus/grafana/ELK on minikube
4. presentations 
5. vagrant_ansible - Contains information on starting Ansible master and nodes on Separate Oracle Virtual Box instances
6. vagrant_kubeadm-kubernete - Build a master/2 node Kubernetes cluster using Oracle Virtual Box 
 
 

		
