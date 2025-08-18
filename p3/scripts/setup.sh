#!/bin/bash
set -e

k3d cluster create mycluster \
  --servers 1 --servers-memory 3G \
  --agents 1 --agents-memory 8G \
#   -p "8080:80@loadbalancer" \
#   -p "8443:443@loadbalancer" \

# Création des namespaces
kubectl create namespace argocd
kubectl create namespace dev

# Installation d'Argocd dans le namespace argocd
kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

# Attente pour que les pods ArgoCD soient en cours d'exécution
echo "Attente que les pods ArgoCD soient prêts..."
kubectl wait --for=condition=ready pod --all -n argocd --timeout=180s

# Forward port 9090 to access ArgoCD UI or CLI locally
kubectl port-forward svc/argocd-server -n argocd 9090:80 &

# Générer le mot de passe initial
PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)

# Connexion à ArgoCD
argocd login localhost:9090 --insecure --username admin --password "$PASSWORD"

if [ $? -eq 0 ]; then
    echo "Connexion réussie à ArgoCD."
else
    echo "Échec de la connexion à ArgoCD."
    exit 1
fi

# Création de l'application sur ArgoCD
argocd app create mon-app \
    --repo https://github.com/Thebelovedcookie/mmahfoud.git \
    --path k8s \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace dev \

# Synchronisation de l'application depuis GitHub
argocd app sync mon-app

sleep 10

kubectl port-forward svc/wil-playground 8888:8888 -n dev &

echo "rdv to https://localhost:9090/ to get argo cd" "username: admin" "mdp :" $PASSWORD
echo "rdv to http://localhost:8888/ to see the app"