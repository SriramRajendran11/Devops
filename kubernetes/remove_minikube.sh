sudo apt-get purge -y minikube && sudo apt-get autoremove -y 
if  [ -d $HOME/.minikube ] ; then 
   rm -rf $HOME/.minikube
fi 

