A simplistic approach to build ansible master node and client. 

Step 01: 
	To start with: 
	# build the Ansible Server image 
	docker build -f DockerfileAnsible -t ansible-docker . 
	# build the Ansible managed Nodes
	docker build -f DockerfileAnsibleNode -t ansible-node . 
	# now start the nodes
	docker compose up -d 
	# add keys from nodes to master
	docker exec -it controlnode /bin/bash
		ssh-keyscan -H ansiblenode1 >> $HOME/.ssh/known_hosts # running inside docker
		ssh-keyscan -H ansiblenode2 >> $HOME/.ssh/known_hosts # running inside docker
                ssh-keyscan -H ansiblenode3 >> $HOME/.ssh/known_hosts # running inside docker


Step 02:
You will need to create a user ansible if not already created and set its password in the first time on each node
e.g. usage: 
	 docker exec -it ansiblenode1 /bin/bash 
	           sudo bash 
	 	   passwd ansible
		   exit
		   exit 
	 [Repeat for ansiblenode2, ansiblenode3.....] 

Step 03:
Next Connect from Ansible-master to each off the node 
e.g usage
	docker exec -it controlnode /bin/bash 
		ssh ansible@ansiblenode1
		[ you will be asked to enter password ] 
	 	ssh-copy-id ansible@ansiblenode1
		[ you will be asked to enter password ] 
		ssh ansible@ansiblenode1
		[no password will be required now] 
	
		[Repeat for ansiblenode2, ansiblebnode3... ] 

The usage is you do a docker exec to the master node and ssh-copy-id its public key to nodes for user ansible. 
Then corresponding ssh's will not require password and the master node can be used to run playbooks on the nodes. 

Step 04:
Add inventory file
	login to control node
	docker exec -it controlnode /bin/bash
		# create folder and files
		# As normal user
		sudo bash 
			# as root
			mkdir -p /etc/ansible/
			touch /etc/ansible/hosts
			echo ansiblenode1 >> /etc/ansible/hosts
			echo ansiblenode2 >> /etc/ansible/hosts
			echo ansiblenode3 >> /etc/ansible/hosts		
			chown -R ansible /etc/ansible
			exit
		exit


