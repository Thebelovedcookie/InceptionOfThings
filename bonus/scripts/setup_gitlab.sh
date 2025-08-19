#!/bin/bash

# Variables
GITLAB_NAMESPACE="gitlab"
TOKEN_NAME="root-token-script"
TOKEN_SCOPES="api"
TOKEN_EXPIRE_DAYS=365  # 1 an

echo "Connexion au pod toolbox..."
TOOLBOX_POD=$(kubectl get pod -n "$GITLAB_NAMESPACE" -l app=toolbox -o jsonpath="{.items[0].metadata.name}")

if [[ -z "$TOOLBOX_POD" ]]; then
  echo "Erreur : aucun pod toolbox trouvé."
  exit 1
fi

# Génération du code Ruby à exécuter dans gitlab-rails console
read -r -d '' RUBY_SCRIPT <<EOF
user = User.find_by_username('root')
unless user
  puts 'Utilisateur root introuvable.'
  exit 1
end

token = PersonalAccessToken.create!(
  user: user,
  name: '$TOKEN_NAME',
  scopes: ['$TOKEN_SCOPES'],
  expires_at: $TOKEN_EXPIRE_DAYS.days.from_now
)
puts token.token
EOF

# Exécution dans le conteneur toolbox
echo "Création du token via gitlab-rails..."
kubectl exec -n "$GITLAB_NAMESPACE" -it "$TOOLBOX_POD" -- bash -c "echo \"$RUBY_SCRIPT\" | gitlab-rails console"
