# remove old containers and images
docker rm -f $(docker ps -qa) 
docker rmi -f $(docker images -qa) 
docker system prune --volumes -f
sudo systemctl stop  --now docker.service docker.socket
sudo systemctl disable --now docker.service docker.socket
# remove
sudo apt-get purge  -y fuse-overlayfs docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin && sudo apt-get autoremove -y 
echo "All done." 
