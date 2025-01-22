This is a duplication of code found in: 

git@github.com:SeshagiriSriram/vagrant-kubeadm-kubernetes.git 

This build 3 Oracle Virtual boxes for Kubernetes - not minikube 
and has 1 master node 
and 2 worker nodes joined in a kubernetes cluster 


The build can be done as below 

* vagrant up (or) 
* vagrant up controlplane | node01 | node02 

Use the latter form in case of resource constraints. 

Note that if a machine fails during initialization the 1st time around, 
* destroy the machine (also manually remove the left over remnant folder)
* rebuild using vagrant up

Once done, ssh to either node01 or node02 and enable the service like so: 

kubectl -n kubernetes-dashboard port-forward --insecure-skip-tls-verify --address <ip of node01 or node02>,localhost svc/kubernetes-dashboard-kong-proxy 8443:443 2>&1 >/dev/null & 

The dashboard can then be accessed using https://<ip>:8443 

NB: the dashboard version is very very old (2.7.1). 7.x have an issue where their ports clash with other services.
To work around this, 
- provide your own custom values.yaml file
- ensure that the kong service and pods are up and running 
- Perform a port forward of the kong service and consume the same 
