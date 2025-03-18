@echo off
REM get the secret code for a pre-existing node called jenkins-slave. 
REM we parse the file agent.jnlp and get only the secret code for the jenkins-slave
docker exec -it jenkins-slave curl -L -s http://jenkins-blueocean:8080/computer/jenkins-slave/jenkins-agent.jnlp | sed "s/.*<application-desc><argument>\([a-z0-9]*\).*/\1\n/"