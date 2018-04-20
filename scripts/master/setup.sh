# Refer: https://kubernetes.io/docs/setup/independent/create-cluster-kubeadm/

echo ">> Initialize kubeadm"
kubeadm init \
  --apiserver-advertise-address=kube-master \
  --pod-network-cidr=192.168.0.0/16

echo ">> Setup kubectl"
mkdir -p $HOME/.kube
sudo cp -i /etc/kubernetes/admin.conf $HOME/.kube/config
sudo chown $(id -u):$(id -g) $HOME/.kube/config

echo ">> Install kube-router"
kubectl apply -f https://raw.githubusercontent.com/cloudnativelabs/kube-router/master/contrib/bootkube/kube-router.yaml

