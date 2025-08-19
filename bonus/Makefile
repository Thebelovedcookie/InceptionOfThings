all: 
	cd scripts && ./install_gitlab.sh

setup_gitlab:
	./scripts/setup_gitlab.sh

re : clean all

get_password:
	kubectl get secret gitlab-gitlab-initial-root-password -n gitlab -o jsonpath="{.data.password}" | base64 --decode
	
clean:
	helm repo remove gitlab
	kubectl delete namespace gitlab
	k3d cluster delete mycluster

help:
	@printf "%-20s: %s\n" "make" "setup the project."
	@printf "%-20s: %s\n" "re" "clean, and setup the project"
	@printf "%-20s: %s\n" "get_password" "generate the ArgoCD password"
	@printf "%-20s: %s\n" "clean" "delete the K3D cluster"

.PHONY: all re clean get_password help