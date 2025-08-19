#!/bin/bash

set -e

if command -v helm &> /dev/null; then
    echo "Helm est déjà installé : $(helm version --short)"
else
    echo "Helm n'est pas installé. Installation en cours..."
    curl https://raw.githubusercontent.com/helm/helm/main/scripts/get-helm-3 | bash
fi

kubectl create namespace gitlab

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm install gitlab gitlab/gitlab \
  -n gitlab \
  -f ../confs/gitlab_values.yaml \
  --timeout 600s

echo "rdv sur http://gitlab.gitlab.local/"