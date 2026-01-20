.PHONY: help dev-apply prod-apply dev-destroy prod-destroy

.DEFAULT_GOAL := help

help: ## Show this help message and exit
	@awk 'BEGIN {FS = ":.*##"; printf "\nUsage:\n  make \033[36m<target>\033[0m\n\nTargets:\n"} /^[a-zA-Z0-9_-]+:.*?##/ { printf "  \033[36m%-25s\033[0m %s\n", $$1, $$2 }' $(MAKEFILE_LIST)

git: ## Git pull code and Terraform local state clean
	git pull
	rm -f .terraform/terraform.tfstate

dev-apply: git ## Terraform DEV Env Apply
	terraform init -backend-config=env-dev/state.tfvars
	terraform apply -auto-approve -var-file=env-dev/main.tfvars

prod-apply: git ## Terraform PROD Env Apply
	terraform init -backend-config=env-prod/state.tfvars
	terraform apply -auto-approve -var-file=env-prod/main.tfvars

dev-destroy: git ## Terraform DEV Env Destroy
	terraform init -backend-config=env-dev/state.tfvars
	terraform destroy -auto-approve -var-file=env-dev/main.tfvars

prod-destroy: git ## Terraform PROD Env Destroy
	terraform init -backend-config=env-prod/state.tfvars
	terraform destroy -auto-approve -var-file=env-prod/main.tfvars