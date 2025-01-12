A simplistic approach to build ansible master node and client. 

To start with: 
	# build the Ansible Server image 
	docker build -f DockerfileAnsible -t ansible-docker . 
	# build the Ansible managed Nodes
	docker build -f DockerfileAnsibleNode -t ansible-node . 
	# now start the nodes
	docker compose up -d 

You will need to create a user ansible if not already created and set its password in the first time on each node
e.g. usage: 
	 docker exec -it 

The usage is you do a docker exec to the master node and ssh-copy-id its public key to nodes for user ansible. 
Then corresponding ssh's will not require password and the master node can be used to run playbooks on the nodes. 
