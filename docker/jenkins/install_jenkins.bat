REM Provided as IS - Use at own risk 

REM create a network called jenkins
REM FIX Issue if network already exists
REM WE DO NOT USE THE DEFAULT BRIDGE 
docker network create jenkins
REM create folders for volume mapping 
REM again fix if already exists
mkdir jenkins-docker-certs
mkdir jenkins-data

REM start the docker in Docker container. This is the secret sauce that allows docker to be run inside 
REM jenkins which is itself running inside docker. 
docker run --name jenkins-docker --rm --detach --privileged --network jenkins --network-alias docker  --env DOCKER_TLS_CERTDIR=/certs --volume jenkins-docker-certs:/certs/client  --volume jenkins-data:/var/jenkins_home   --publish 2376:2376  docker:dind

REM Create the docker image.. 
REM Fix issue if dockerfile is not found
docker build -t myjenkins-blueocean:2.479.2-1 . 

REM start the Jenkins server
docker run --name jenkins-blueocean --restart=on-failure --detach --network jenkins --env DOCKER_HOST=tcp://docker:2376   --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1   --volume jenkins-data:/var/jenkins_home   --volume jenkins-docker-certs:/certs/client:ro   --publish 8080:8080 --publish 50000:50000 myjenkins-blueocean:2.479.2-1
