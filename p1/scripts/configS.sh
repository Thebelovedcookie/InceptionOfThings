#Install dependencies for K3s cluster

#Update package list
apt-get update -y

#Install required packages
apt-get install -y curl git apt-transport-https

apt-get install net-tools

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110" sh -

while [ ! -f /var/lib/rancher/k3s/server/node-token ]; do
    echo "[INFO] Waiting for k3s to generate node-token..."
    sleep 2
done

mkdir -p /vagrant/shared

cp /var/lib/rancher/k3s/server/node-token /vagrant/shared
cd ~
mkdir -p /home/vagrant/.kube
cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config
chown -R vagrant:vagrant /home/vagrant/.kube
chmod 644 /etc/rancher/k3s/k3s.yaml
chown vagrant /etc/rancher/k3s/k3s.yaml

export KUBECONFIG=$HOME/.kube/config >> ~/.bashrc