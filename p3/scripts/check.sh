#!/bin/bash

# Vérifier si Docker est déjà installé
if ! command -v docker &> /dev/null
then
    echo "Docker n'est pas installé, installation en cours..."
    
    # Installation de Docker
    curl -fsSL https://get.docker.com | sh
    sudo usermod -aG docker $USER
    newgrp docker
else
    echo "Docker est déjà installé. Docker already install"
fi

# Vérifier si Kubernetes (kubectl) est installé
if ! command -v kubectl &> /dev/null
then
    echo "kubectl n'est pas installé, installation en cours..."
    
    # Installation de kubectl
    curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
    chmod +x kubectl
    sudo mv kubectl /usr/local/bin/
else
    echo "kubectl est déjà installé. kubectl already install."
fi

# Vérifier si k3d est installé
if ! command -v k3d &> /dev/null
then
    echo "k3d n'est pas installé, installation en cours..."
    
    # Installation de k3d
    curl -s https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash
else
    echo "k3d est déjà installé. k3d already install."
fi

# Vérifier si ArgoCD est installé
if ! command -v argocd &> /dev/null
then
    echo "ArgoCD CLI n'est pas installé, installation en cours..."
    
    # Installation de ArgoCD CLI
    curl -sSL -o argocd https://github.com/argoproj/argo-cd/releases/latest/download/argocd-linux-amd64
    chmod +x argocd
    sudo mv argocd /usr/local/bin/
else
    echo "ArgoCD CLI est déjà installé. ArgoCD CLI already install."
fi