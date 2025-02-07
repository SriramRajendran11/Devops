#!/bin/bash
#
# Common setup for all servers (Control Plane and Nodes)

set -euxo pipefail

# Variable Declaration
## Add support Install CRIO Runtime
curl -fsSL https://pkgs.k8s.io/addons:/cri-o:/prerelease:/main/deb/Release.key |
    gpg --dearmor -o /etc/apt/keyrings/cri-o-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/cri-o-apt-keyring.gpg] https://pkgs.k8s.io/addons:/cri-o:/prerelease:/main/deb/ /" |
    tee /etc/apt/sources.list.d/cri-o.list
sudo apt-get update -y
sudo apt-get install -y software-properties-common curl apt-transport-https ca-certificates jq

echo "Base SW installed." 

COUNT=`lsb_release -a | grep -c Debian` 
BASEDIR=/etc/systemd/resolved.conf.do
FILE=dns_servers.conf 
if [ ${COUNT} -gt 0 ]; then 
    echo "Hacking it for Debian instead of Ubuntu" 
    BASEDIR=/etc/resolvconf/resolv.conf.d
    FILE=head
fi 
# DNS Setting
if [ ! -d /etc/systemd/resolved.conf.d ]; then
	sudo mkdir /etc/systemd/resolved.conf.d/
fi
cat <<EOF | sudo tee ${BASEDIR}/${FILE} 
[Resolve]
DNS=${DNS_SERVERS}
EOF

if [ ${COUNT} -eq 0 ]; then 
	sudo systemctl restart systemd-resolved 2>&1 >/dev/null 
fi 

# disable swap
sudo swapoff -a

# keeps the swaf off during reboot
(crontab -l 2>/dev/null; echo "@reboot /sbin/swapoff -a") | crontab - || true


# Create the .conf file to load the modules at bootup
cat <<EOF | sudo tee /etc/modules-load.d/k8s.conf
overlay
br_netfilter
EOF

sudo modprobe overlay
sudo modprobe br_netfilter

# sysctl params required by setup, params persist across reboots
cat <<EOF | sudo tee /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-iptables  = 1
net.bridge.bridge-nf-call-ip6tables = 1
net.ipv4.ip_forward                 = 1
EOF

# Apply sysctl params without reboot
sudo sysctl --system

#if [ -f /vagrant/vbox.iso ]; then 
	#sudo mount -o loop /vagrant/vbox.iso /mnt 
	#sudo apt-get install -y build-essential linux-headers-$(uname -r) dkms cri-o
	#sudo /mnt/VBoxLinuxAdditions.run 
	#echo "Oracle VBOX Installed Successfully" 
#else
	sudo apt-get install -y cri-o
#fi 

sudo systemctl daemon-reload
sudo systemctl enable crio --now
sudo systemctl start crio.service

echo "CRI runtime installed successfully"

sudo mkdir -p /etc/apt/keyrings
curl -fsSL https://pkgs.k8s.io/core:/stable:/v$KUBERNETES_VERSION_SHORT/deb/Release.key | sudo gpg --dearmor -o /etc/apt/keyrings/kubernetes-apt-keyring.gpg
echo "deb [signed-by=/etc/apt/keyrings/kubernetes-apt-keyring.gpg] https://pkgs.k8s.io/core:/stable:/v$KUBERNETES_VERSION_SHORT/deb/ /" | sudo tee /etc/apt/sources.list.d/kubernetes.list

sudo apt-get update && sudo apt-get install -y kubelet="$KUBERNETES_VERSION" kubectl="$KUBERNETES_VERSION" kubeadm="$KUBERNETES_VERSION"

# Disable auto-update services
sudo apt-mark hold kubelet kubectl kubeadm cri-o


local_ip="$(ip --json a s | jq -r '.[] | if .ifname == "eth1" then .addr_info[] | if .family == "inet" then .local else empty end else empty end')"
cat > /etc/default/kubelet << EOF
KUBELET_EXTRA_ARGS=--node-ip=$local_ip
${ENVIRONMENT}
EOF
