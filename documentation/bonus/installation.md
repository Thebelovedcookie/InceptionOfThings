k3d create cluster mycluster


helm repo add gitlab https://charts.gitlab.io/
helm repo update

# Création des namespaces
kubectl create namespace gitlab
kubectl create namespace argocd
kubectl create namespace dev

helm repo add gitlab https://charts.gitlab.io/
helm repo update
helm upgrade --install gitlab gitlab/gitlab \
  --timeout 600s \
  --set global.hosts.domain=example.com \
  --set global.hosts.externalIP=10.10.10.10 \
  --set certmanager-issuer.email=marianne.picard.88@live.fr

