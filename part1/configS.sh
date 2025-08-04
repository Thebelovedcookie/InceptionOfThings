#Install dependencies for K3s cluster

curl -sfL https://get.k3s.io | INSTALL_K3S_EXEC="--node-ip=192.168.56.110" sh -

while [ ! -f /var/lib/rancher/k3s/server/node-token ]; do
    echo "[INFO] Waiting for k3s to generate node-token..."
    sleep 2
done

mkdir -p /vagrant/shared

cp /var/lib/rancher/k3s/server/node-token /vagrant/shared