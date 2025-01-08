FROM jenkins/jenkins:2.479.2-jdk17
USER root
COPY ./id_rsa /tmp/id_rsa
COPY ./id_rsa.pub /tmp/id_rsa.pub
RUN apt-get update && apt-get install -y lsb-release
RUN curl -fsSLo /usr/share/keyrings/docker-archive-keyring.asc  https://download.docker.com/linux/debian/gpg
RUN echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.asc] https://download.docker.com/linux/debian $(lsb_release -cs) stable" > /etc/apt/sources.list.d/docker.list
RUN apt-get update && apt-get install -y docker-ce-cli sudo && echo "jenkins ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers && apt clean 
USER jenkins
RUN jenkins-plugin-cli --plugins "blueocean docker-workflow"
