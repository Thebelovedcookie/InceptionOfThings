Creer un cluester avec k3d est vraiment tres simple et rapide.

Apres avoir utiliser le script d'installation:

1. Vérifier que k3d est installé

		k3d version

	Tu devrais voir quelque chose comme :

		k3d version v5.x.x
		k3s version v1.29.x-k3s1 (default)

2. Créer un cluster local

		k3d cluster create mon-cluster

	Cette commande :

		Lance un server k3s et des nœuds workers dans des conteneurs Docker
		Configure automatiquement kubectl pour pointer sur ce cluster

3. Vérifier que le cluster tourne

		kubectl get nodes

	Tu devrais voir :

		NAME                       STATUS   ROLES                  AGE   VERSION
		k3d-mon-cluster-server-0   Ready    control-plane,master   1m    v1.29.x+k3s1


4. Supprimer un cluster

		k3d cluster delete mon-cluster
