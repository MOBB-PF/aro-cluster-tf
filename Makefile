######################
# Define a variable for the Terraform examples directory
TERRAFORM_DIR := .
# TERRAFORM_DIR := examples/rosa-classic-public
# TERRAFORM_DIR := examples/rosa-classic-public-with-byo-vpc
# TERRAFORM_DIR := examples/rosa-classic-public-with-byo-vpc-byo-iam-byo-oidc
# TERRAFORM_DIR := examples/rosa-classic-public-with-idp-machine-pools
# TERRAFORM_DIR := examples/rosa-classic-public-with-unmanaged-oidc

######################
# Log into your AWS account before running this make file.
# Create .env file with your ROSA token. This file will be ignored by git.
# format.
# RHCS_TOKEN=<ROSA TOKEN>

# include .env
# export $(shell sed '/^\#/d; s/=.*//' .env)
TF_LOG=DEBUG
######################
.EXPORT_ALL_VARIABLES:

# Run make init \ make plan \ make apply \ make destroy

init:
	@cd $(TERRAFORM_DIR) && terraform init -input=false -lock=false -no-color -reconfigure
.PHONY: init

plan: format validate
	@cd $(TERRAFORM_DIR) && terraform plan -lock=false -out=.terraform-plan
.PHONY: plan

apply:
	@cd $(TERRAFORM_DIR) && terraform apply .terraform-plan
.PHONY: apply

destroy:
	@cd $(TERRAFORM_DIR) && terraform destroy -auto-approve -input=false
.PHONY: destroy

output:
	@cd $(TERRAFORM_DIR) && terraform output > tf-output-parameters
.PHONY: output

format:
	@cd $(TERRAFORM_DIR) && terraform fmt

validate:
	@cd $(TERRAFORM_DIR) && terraform validate
