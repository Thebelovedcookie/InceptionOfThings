1. Creer le cluster K3d 
		k3d cluster create mycluster --servers 1 --agents 1 -p "8888:8888@loadbalancer"
	*--servers 1 : un noeud maitre.
	*--agents 1 : un noeud esclave.
	*-p "8888:8888@loadbalancer" : redirige le port 8888 du cluster vers la machine.

	loadbalancer:

2. Creer les namespace
		kubectl create namespace argocd
		kubectl create namespace dev

	Les namespaces sont des espaces isoles dans Kubernetes.
	On dois en creer deux:
		- argocd -> pour Argo CD
		- dev -> pour l'application

3. Installer Argo CD dans le namespace `argocd`
	Depuis le manifeste officiel:
		kubectl apply -n argocd -f https://raw.githubusercontent.com/argoproj/argo-cd/stable/manifests/install.yaml

	Attendre que les pods soient prets `running` :
		kubectl get pods -n argocd

4. Acceder a l'interface Web Argo CD
	Pour acceder a l'interface web Argo CD, il faut faire un port-forward local:
			kubectl port-forward svc/argocd-server -n argocd 8080:443

	Puis ouvrir le naviguateur sur:
		https:localhost:8080
	
	Recupere le mot de passe admin par defaut avec: 
		kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d
	
5. preparer ton depot github avec les fichiers de configuration
	Cree un depot public sur github.
	Dans ce depot, ajout un dossier k8s qui contiendra au minimum:
		deployment.yaml->decrit le deploiement de l'application
		service.yaml->decrit le service pour exposer ton application

6. Se connecter a argocd sur le terminal
			argocd login localhost:8080 --insecure

			username: admin
			password: kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath="{.data.password}" | base64 -d

7. Creer une application Argo CD qui va suive ce depot github
	Via la CLI Argo CD apres t'etre connecte:

		argocd app create mon-app \
		--repo https://github.com/ton-utilisateur/ton-repo.git \
		--path k8s \
		--dest-server https://kubernetes.default.svc \
		--dest-namespace dev

8. Synchroniser l'application
	Lance la synchronisation pour que Argo CD deploie les ressources dans Kubernetes:
		argocd app sync mon-app