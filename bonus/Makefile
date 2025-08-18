all: 
	cd scripts && ./install_gitlab.sh

setup_gitlab:
	./scripts/setup_gitlab.sh

re : clean all

get_password:
	@echo "Password ArgoCD : $$(kubectl -n argocd get secret argocd-initial-admin-secret -o jsonpath='{.data.password}' | base64 -d)"

clean:
	./scripts/clean.sh

help:
	@printf "%-20s: %s\n" "make" "setup the project."
	@printf "%-20s: %s\n" "re" "clean, and setup the project"
	@printf "%-20s: %s\n" "get_password" "generate the ArgoCD password"
	@printf "%-20s: %s\n" "clean" "delete the K3D cluster"

.PHONY: all re clean get_password help