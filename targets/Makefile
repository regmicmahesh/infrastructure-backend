BODY ?= {"request": {"branch":"dev"}}
## Fetch all the required plugins and modules
terraform-init:
	@terraform init -input=false -upgrade

## Auto Format terraform modules
terraform-format:
	@for file in $(SOURCE_FILES) ; do \
      terraform fmt $$file ; \
  done

## Create new terraform workspace
terraform-create-workspace:
	@terraform workspace new $(TF_WORKSPACE)

## List workspaces
terraform-list-workspace:
	@terraform workspace list

## Generate terraform plan
terraform-plan: terraform-init
	@terraform plan

## Generate terraform plan out to the file `plan.tfstate`
terraform-plan-out: terraform-init
	@terraform plan -out $(OUTFILE)

## Apply terraform plan
terraform-apply: terraform-init
	@terraform apply -input=false -auto-approve


## Generate terraform destroy plan out to the file `destroy-plan.tfstate`
terraform-destroy-plan-out: terraform-init
	@terraform plan -destroy -out=$(DESTROY_OUTFILE)

## Destroy terraform infrastructure from outfile
terraform-destroy-from-outfile: terraform-init
	@terraform destroy -auto-approve $(DESTROY_OUTFILE)

## Apply terraform plan from outfile
terraform-apply-from-outfile: terraform-init
	@terraform apply $(OUTFILE)

## Destroy terraform plan
terraform-destroy: terraform-init
	@terraform destroy -input=false -auto-approve

## Validate terraform modules
terraform-validate: terraform-init
	@terraform validate

## Generate Terraform Output
terraform-output:
	@terraform output -json

## Lint check Terraform
terraform-lint: terraform-init
	@FAIL=`for file in $(SOURCE_FILES); do terraform fmt -check $$file; done`; \
	[ -z "$$FAIL" ] || (echo -e "Terraform configuration needs linting. Run $(GREEN)make terraform-format$(NC) These file(s) needs formatting\n"; for file in $$FAIL; do tput setaf 6; echo "* $$file"; tput sgr0; done; echo; exit 1)

## Lint terraform code
lint:
	$(SELF) terraform-init terraform-lint terraform-validate
