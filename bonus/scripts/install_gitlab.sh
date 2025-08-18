#!/bin/bash
set -e

kubectl create namespace gitlab

helm repo add gitlab https://charts.gitlab.io/
helm repo update

helm install gitlab gitlab/gitlab \
  -n gitlab \
  -f ../confs/gitlab_values.yaml \
  --timeout 600s

echo "rdv sur http://gitlab.gitlab.local/"