@echo off 
REM The above line is to shut up the rest of this command 

REM build the docker file for Jenkins slave that has an OpenSSH server for connection
docker build -t jenkins-slave -f DF_OpenSSH . 

REM Run the jenkins-slace in same network as jenkins
REM Also we use the same volumes and also set TLS verificaton parts
REM This is required for SSH based start 
docker run --name jenkins-slave -itd --network jenkins --env DOCKER_HOST=tcp://docker:2376   --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1   --volume jenkins-data:/var/jenkins_home:ro  jenkins-slave

REM Download the agent jar
REM NOTE all curls work because we moved to using Matrix based Security and allowing anonymous access to connec to node and start it. 
docker exec -it jenkins-slave curl -L -s http://jenkins-blueocean:8080/jnlpJars/agent.jar -o /tmp/agent.jar
echo *** done getting agent jar 

REM THIS IS A CRUEL HACK SINCE WINDOWS DOES NOT ALLOW FOR CAPTURING OUTPUT OF A COMMAND
call getSecretCode.cmd 
echo ******** Done getting secret code  

REM the below works since the output of getSecretCode.cmd only returns one row
FOR /F "delims=" %%i IN ('getSecretCode.cmd') DO set CODE=%%i

REM based on the assumption that getSecretCode.cmd wll work (since it has been set to jenkins-slave)  
echo docker exec --env CODE=%CODE% -itd jenkins-slave java -jar /tmp/agent.jar -url http://jenkins-blueocean:8080/ -secret %CODE%  -name jenkins-slave -webSocket -workDir /tmp
REM Start the agent and connect to the Jenkins server
REM note that since they are in the same network, I can refer to the container name of the jenkinss saerver as host 
docker exec --env CODE=%CODE% -itd jenkins-slave java -jar /tmp/agent.jar -url http://jenkins-blueocean:8080/ -secret %CODE%  -name jenkins-slave -webSocket -workDir /tmp

echo ******** Check your jenkins node
