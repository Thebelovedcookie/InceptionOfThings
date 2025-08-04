#Install dependencies for K3s cluster

while [ ! -f /vagrant/shared/node-token ]; do
  echo "En attente du token K3s..."
  sleep 2
done

export K3S_URL=https://192.168.56.110:6443
export K3S_TOKEN=$(cat /vagrant/shared/node-token)

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.111" sh -