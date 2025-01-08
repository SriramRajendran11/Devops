echo "Try to set permissions" 
mkdir -p /home/ansible/.ssh
chmod 700 /home/ansible/.ssh
touch /home/ansible/.ssh/authorized_keys
chown -R ansible /home/ansible

echo "Try to start SSHD" 
if [ -f /usr/sbin/sshd ]; then 
	echo "Starting SSHD" 
        /usr/sbin/sshd -D 
else 
	while true 
	do
		sleep 100
		echo "waking up"
	done 
fi 
