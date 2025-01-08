# Provided as IS - Use at own risk 
# create a network called jenkins
# FIX Issue if network already exists
docker network create jenkins
mkdir -p jenkins-docker-certs
mkdir -p jenkins-data
# start the docker in Docker container
docker run --name jenkins-docker --rm --detach --privileged --network jenkins --network-alias docker  --env DOCKER_TLS_CERTDIR=/certs --volume jenkins-docker-certs:/certs/client  --volume jenkins-data:/var/jenkins_home   --publish 2376:2376  docker:dind
# Create the docker image.. 
# Fix issue if dockerfile is not found
docker build -t jenkins-blueocean:2.479.2 . 
# start the Jenkins server
docker run --name jenkins-blueocean --restart=on-failure --detach --network jenkins --env DOCKER_HOST=tcp://docker:2376   --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1   --volume jenkins-data:/var/jenkins_home   --volume jenkins-docker-certs:/certs/client:ro  -v $HOME:/data  --publish 8080:8080 --publish 50000:50000 jenkins-blueocean:2.479.2
