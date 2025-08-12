#!/bin/bash
sudo apt update

# Uninstall all conflicting packages of Docker
for pkg in docker.io docker-doc docker-compose docker-compose-v2 podman-docker containerd runc; do
    sudo apt-get remove -y $pkg
done

#install Docker
curl -fsSL https://get.docker.com | sh
sudo usermod -aG docker $USER

#install kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo mv kubectl /usr/local/bin/

#Install current latest release of k3d
curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
chmod +x argocd
sudo mv argocd /usr/local/bin/