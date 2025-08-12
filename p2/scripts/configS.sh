#Install dependencies for K3s cluster

#Update package list
apt-get update -y

#Install required packages
apt-get install -y curl git apt-transport-https net-tools

ln -s /usr/local/bin/k3s /usr/local/bin/kubectl

#Install of k3s
curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110" sh -


# wait for 
until kubectl get node 2>/dev/null; do
  echo "Attente de K3s..."
  sleep 2
done

#Move the config app file
cp /vagrant_apps/ingress.yaml /etc/rancher/k3s/ingress.yaml
cp /vagrant_apps/app1.yaml /etc/rancher/k3s/app1.yaml
cp /vagrant_apps/app2.yaml /etc/rancher/k3s/app2.yaml
cp /vagrant_apps/app3.yaml /etc/rancher/k3s/app3.yaml

cd ~
mkdir -p /home/vagrant/.kube

cp /etc/rancher/k3s/k3s.yaml /home/vagrant/.kube/config

chown -R vagrant:vagrant /home/vagrant/.kube

kubectl apply -f /etc/rancher/k3s/ingress.yaml
kubectl apply -f /etc/rancher/k3s/app1.yaml
kubectl apply -f /etc/rancher/k3s/app2.yaml
kubectl apply -f /etc/rancher/k3s/app3.yaml

kubectl get all -A
chmod 644 /etc/rancher/k3s/k3s.yaml
chown vagrant /etc/rancher/k3s/k3s.yaml

export KUBECONFIG=$HOME/.kube/config >> ~/.bashrc