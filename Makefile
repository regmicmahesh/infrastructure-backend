.PHONY: env
.DEFAULT_GOAL := help

SHELL := /bin/bash
TMP ?= /tmp
OS ?= $(shell uname -s | tr '[:upper:]' '[:lower:]')
APP_ROOT ?= $(shell 'pwd')
TERRAFORM ?= $(APP_ROOT)/vendor/terraform
TERRAFORM_VERSION ?= 1.0.9
TERRAFORM_URL ?= https://releases.hashicorp.com/terraform/$(TERRAFORM_VERSION)/terraform_$(TERRAFORM_VERSION)_$(OS)_amd64.zip
# export README_DEPS ?= docs/targets.md docs/terraform.md
TARGETS_DOC_PATH ?= docs/targets.md
TERRAFORM_DOCS_PATH ?= docs/terraform.md
export DEFAULT_HELP_TARGET ?= help

# Environment variables for terraform plans and applys
KUBECTL ?= /usr/local/bin/kubectl
KUBECTL ?= $(APP_ROOT)/vendor/kubectl
KUBECTL_VERSION ?= v1.16.2
KUBECTL_URL ?= https://dl.k8s.io/$(KUBECTL_VERSION)/bin/$(OS)/amd64/kubectl


export ENVIRONMENT_OVERRIDE_PATH ?= $(APP_ROOT)/env/Makefile.override.dev

include $(APP_ROOT)/env/Makefile
-include $(ENVIRONMENT_OVERRIDE_PATH)
include $(APP_ROOT)/targets/Makefile
include $(APP_ROOT)/targets/Makefile.helpers


SELF ?= make

SOURCE_FILES = $(wildcard common/*/*.tf) \
			$(wildcard commons/*/*.tf) \
			$(wildcard modules/*/*.tf) \
			$(wildcard *.tf)


# ANSI escape codes for green and no color
GREEN = \033[0;32m
NC = \033[0m

## Display help for all targets
help:
	@printf "Available targets:\n\n"
	@$(SELF) -s help-generate
	@printf "Available docker targets:\n\n"
	@$(SELF) -s help-generate-docker

## Show current override file path
current:
	@echo -e "current => $(GREEN)$(ENVIRONMENT_OVERRIDE_PATH)$(NC)"

# Base image for kubernetes deployment
IMAGE_NAME ?= regmicmahesh/infrastructure-baked-dependencies:latest

# Alias command for docker's `make` executable
DOCKER_RUN ?=  \
		docker run \
		--rm \
		-v $(APP_ROOT):/app \
		-w /app \
		--entrypoint make \
		--env TF_VAR_availability_zones='$(TF_VAR_availability_zones)' \
		--env AWS_ACCESS_KEY_ID=$(AWS_ACCESS_KEY_ID) \
		--env AWS_SECRET_ACCESS_KEY=$(AWS_SECRET_ACCESS_KEY) \
		--env TF_CLI_CONFIG_FILE=$(TF_CLI_CONFIG_FILE) \
		--env TF_WORKSPACE=$(TF_WORKSPACE) \
		--env TF_VAR_region=$(TF_VAR_region) \
		--env TF_VAR_route53_root_domain_name=$(TF_VAR_route53_root_domain_name) \
		--env TF_VAR_stage=$(TF_VAR_stage) \
		$(IMAGE_NAME) \



## Fetch all the required plugins and modules
docker/terraform-init:
	@$(DOCKER_RUN) terraform-init

## Create new terraform workspace
docker/terraform-create-workspace:
	@$(DOCKER_RUN) terraform-create-workspace

## List terraform workspaces
docker/terraform-list-workspace:
	@$(DOCKER_RUN) terraform-list-workspace

## Auto Format terraform modules
docker/terraform-format:
	@$(DOCKER_RUN) terraform-format

## Generate terraform plan
docker/terraform-plan:
	@$(DOCKER_RUN) terraform-plan

## Generate terraform plan and output plan to file `plan.tfstate`
docker/terraform-plan-out:
	@$(DOCKER_RUN) terraform-plan-out

## Apply terraform plan
docker/terraform-apply:
	@$(DOCKER_RUN) terraform-apply

## Destroy terraform plan
docker/terraform-destroy:
	@$(DOCKER_RUN) terraform-destroy

## Validate terraform modules
docker/terraform-validate:
	@$(DOCKER_RUN) terraform-validate

## Generate Terraform Output
docker/terraform-output:
	@$(DOCKER_RUN) terraform-output

## Lint check Terraform
docker/terraform-lint:
	$(DOCKER_RUN) terraform-lint

## Lint terraform code
docker/lint:
	$(DOCKER_RUN) lint
