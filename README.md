# Sample Code and Presentations
This contains the scripts for installing minikube on a WSL2 (windows 11 Home Edition) Ubuntu 22.04 LTS distro. 
It also contains scripts for installing prometheus, Grafana and ELK stacks
Adapt as neccessary 

It also contains scripts for some docker and vagrant/virtual box demos

# CAUTION
I am not adding any sample files for resolv.conf or WSL Conf
A sample file will look like this: 
```
[boot]
systemd=true
[network]
generateResolvConf=true
``` 
In such cases, you will need to add the following to the /etc/resolv.conf file 
```
# add Google DNS server 
nameserver 8.8.8.8
```
In addition, for minikube to run properly in WSL2 under rootless docker, make the following changes to %USERPROFILES%\.wslconfig 

```
[wsl2]
memory=12GB # Limits VM memory in WSL 2 to 12 GB
processors=4 # Makes the WSL 2 VM use four virtual processors
kernelCommandLine = cgroup_no_v1=all
```
Memory and processors are "added" sugar. 

Shutdown WSL2 and restart. 
Add the following changes to /etc/fstab
```
cgroup2 /sys/fs/cgroup cgroup2 rw,nosuid,nodev,noexec,relatime,nsdelegate 0 0
```
Reboot WSL

in the WSL2 instance where minikube is being added, run the following code: 
```
sudo mkdir -p /etc/systemd/system/user@.service.d
cat <<EOF | sudo tee /etc/systemd/system/user@.service.d/delegate.conf
[Service]
Delegate=cpu cpuset io memory pids
EOF
sudo systemctl daemon-reload
```
Install minikube as normal. see the code in startminikube.sh and adapt as needed.

# Change History
Jan 31 2025 - Added Support for running minikube under rootless docker.  
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
Top level folder structure 
.
├── cheatsheets						Contains Cheay Sheets for git, Docker, Kubernetes
├── docker						Code related to Docker	
├── dockerfiles_ansible					Using DOcker and Ansible together	
├── kubernetes						Kubernetes code	
├── presentations					presentations
├── SampleCodes						Sample codes that can be resused in Jenkins jobs and pipelines
├── terraform						Code related to Terraform
├── vagrant_ansible					Using ansible and vagrant together
└── vagrant-kubeadm-kubernetes				Provisisoning Kubernetes with 1 master and 2 worker nodes	


1. docker
    1.  jenkins - contains instructions on how to build and run jenkins as a docker image
    2.  lamp-dockercompose - A sample LAMP application using docker-compose
    3.  multi-build - Contains example on why we need multi-stage builds
    4.  samples - Misc. Samples for Docker 

2. dockerfiles_ansible - Build docker images for Ansible. Read the Instructions file found in this directory on how to use it. In particular it build the master/nodes and runs them as docker compose up -d. 
3. kubernetes
     1. deploy  - contains sample for deploying application using
          1. yaml - raw deployment using yml/kustomization. There are sub folders here for deploying apache, phpmyadmin and mysql into kubernetes
          2. helm - install apps using helm 
     2. logging - scripts and yml files to install prometheus/grafana/ELK on minikube
4. presentations 
5. vagrant_ansible - Contains information on starting Ansible master and nodes on Separate Oracle Virtual Box instances
6. vagrant_kubeadm-kubernete - Build a master/2 node Kubernetes cluster using Oracle Virtual Box 

7. cheatsheet  
8. SampleCodes 
8. terraform  

		
