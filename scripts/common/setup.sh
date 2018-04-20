# Refer: https://kubernetes.io/docs/setup/independent/install-kubeadm/

echo ">> Install Docker"
yum install -y docker
systemctl enable docker && systemctl start docker

echo ">> Install kubeadm, kubelet, and kubectl"
cat <<EOF > /etc/yum.repos.d/kubernetes.repo
[kubernetes]
name=Kubernetes
baseurl=https://packages.cloud.google.com/yum/repos/kubernetes-el7-\$basearch
enabled=1
gpgcheck=1
repo_gpgcheck=1
gpgkey=https://packages.cloud.google.com/yum/doc/yum-key.gpg https://packages.cloud.google.com/yum/doc/rpm-package-key.gpg
EOF
setenforce 0
yum install -y kubelet kubeadm kubectl
systemctl enable kubelet && systemctl start kubelet

# Some users on RHEL/CentOS 7 have reported issues with traffic being
# routed incorrectly due to iptables being bypassed.
echo ">> Enable bridge-nf-call-iptables"
cat <<EOF >  /etc/sysctl.d/k8s.conf
net.bridge.bridge-nf-call-ip6tables = 1
net.bridge.bridge-nf-call-iptables = 1
EOF
sysctl --system

# To meet with:
# [ERROR Swap]: running with swap on is not supported. Please disable swap
echo ">> Swap off"
swapoff -a

echo ">> Install utilities(to trouble-shoot)"
yum install -y net-tools tcpdump bind-utils nmap-ncat