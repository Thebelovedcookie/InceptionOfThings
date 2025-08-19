#!/bin/bash

# Variables
GITLAB_URL="http://gitlab.gitlab.local"
PRIVATE_TOKEN="glpat-ndBw5WzjUwgQGsMkX_m6"
PROJECT_NAME="mon-projet-de-test"

echo "Création du projet GitLab \"$PROJECT_NAME\"..."

# Vérifie si le projet existe déjà
PROJECT_EXISTS=$(curl -s --header "PRIVATE-TOKEN: $PRIVATE_TOKEN" "$GITLAB_URL/api/v4/projects/root%2F$PROJECT_NAME")

if [[ "$PROJECT_EXISTS" == *"\"id\":"* ]]; then
  echo "⚠️ Le projet existe déjà, on passe au clonage."
else
  # Création du projet
  CREATE_PROJECT_RESPONSE=$(curl -s --request POST "$GITLAB_URL/api/v4/projects" \
    --header "PRIVATE-TOKEN: $PRIVATE_TOKEN" \
    --data "name=$PROJECT_NAME")

  PROJECT_URL=$(echo "$CREATE_PROJECT_RESPONSE" | grep -o '"http_url_to_repo":"[^"]*' | cut -d':' -f2- | tr -d '"')

  if [[ -z "$PROJECT_URL" ]]; then
    echo "❌ Erreur lors de la création du projet."
    echo "$CREATE_PROJECT_RESPONSE"
    exit 1
  fi

  echo "✅ Projet créé : $PROJECT_URL"
fi

# Construction de l'URL Git avec le token
CLONE_URL="http://root:${PRIVATE_TOKEN}@gitlab.gitlab.local/root/${PROJECT_NAME}.git"

echo "Clonage du dépôt..."
git clone "$CLONE_URL"

if [[ $? -ne 0 ]]; then
  echo "❌ Échec du clonage."
  exit 1
fi

echo "✅ Dépôt cloné avec succès."


PASSWORD=$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d)
argocd login localhost:9090 --insecure --username admin --password "$PASSWORD"
if [ $? -eq 0 ]; then
    echo "Connexion réussie à ArgoCD."
else
    echo "Échec de la connexion à ArgoCD."
    exit 1
fi

# Création de l'application sur ArgoCD
argocd app create mon-app2 \
    --repo $CLONE_URL \
    --dest-server https://kubernetes.default.svc \
    --dest-namespace dev \

# Synchronisation de l'application depuis GitHub
argocd app sync mon-app2
