sudo apt-get update && sudo apt-get install -y uidmap iptables dbus-user-session fuse-overlayfs
#docker is already installed 
if [ -f /usr/bin/docker ]; then 
	docker rm -f $(docker ps -qa) 
	docker rmi -f $(docker images -qa) 
	sudo systemctl stop  --now docker.service docker.socket
	sudo systemctl disable --now docker.service docker.socket
	./remove_root_docker.sh 
else
	echo "Docker not installed moving on" 	
	# install docker.. 
	#./install_docker.sh 
fi
# now we have a root docker installed 
export FORCE_ROOTLESS_INSTALL=1
# Note that this will remove docker binaries..
curl -fsSL https://get.docker.com/rootless | sh 
c=$(grep -c '^.*#ROOTLESS' $HOME/.bashrc) 
if [ ${c} -le 0 ]; then 
	echo "export PATH=/home/${USER}/bin:\$PATH #ROOTLESS DOCKER"  >> $HOME/.bashrc
fi 
systemctl --user start docker
systemctl --user enable  docker
sudo loginctl enable-linger $(whoami)
sudo usermod -aG docker $USER 
if [ -f /etc/wsl.conf ]; then 
	sudo cp wslsample.conf /etc/wsl.conf 
	sudo cp resolvsample.conf /etc/resolv.conf 
fi 
echo "All done. Please log out and log back to see changes" 
