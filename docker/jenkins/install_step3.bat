docker build -t jenkins-slave -f DF_OpenSSH . 
docker run --name jenkins-slave -itd --network jenkins --env DOCKER_HOST=tcp://docker:2376   --env DOCKER_CERT_PATH=/certs/client --env DOCKER_TLS_VERIFY=1   --volume jenkins-data:/var/jenkins_home:ro  jenkins-slave
docker exec -it jenkins-slave "ssh-keygen -b 4096 -t rsa -N '' -f ~/.ssh/id_rsa <<< y"
docker exec -it jenkins-slave "cd /tmp && curl -sO http://jenkins-blueocean:8080/jnlpJars/agent.jar"
docker exec -itd "java -jar agent.jar -url http://jenkins-blueocean:8080/ -secret 2d5b8b0e05c730bd1ee1dd141eb60029ddf8932c56472a94bdd82dd021a1deda -name jenkins-slave -webSocket -workDir /tmp"