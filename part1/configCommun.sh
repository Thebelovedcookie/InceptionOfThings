#Install dependencies for K3s cluster

#Update package list
apt-get update -y

#Install required packages
apt-get install -y curl git apt-transport-https

apt-get install net-tools

KUBECTL_VERSION=$(curl -s https://storage.googleapis.com/kubernetes-release/release/stable.txt)
curl -LO https://storage.googleapis.com/kubernetes-release/release/${KUBECTL_VERSION}/bin/linux/amd64/kubectl

chmod +x kubectl
sudo mv kubectl /usr/local/bin/

kubectl version --client