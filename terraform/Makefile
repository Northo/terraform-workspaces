.PHONY: init make_workspace ensure_workspace plan apply help check-env

# Default environment; override by running: make ENV=<desired_workspace>
ENV ?= dev

# Map prod to the default workspace; otherwise, use the provided ENV value.
ifeq ($(ENV),prod)
   WORKSPACE = default
else
   WORKSPACE = $(ENV)
endif

# Check if ENV is set; exits if not.
check-env:
	@if [ -z "$(ENV)" ]; then \
	  echo "Error: ENV variable is not specified. Please run make <target> ENV=<workspace>"; \
	  exit 1; \
	fi

# Ensure that the workspace exists. If not, prompt for creating it.
ensure_workspace: check-env
	@echo "Checking if variable file '$(ENV).tfvars' exists..."; \
	if [ ! -f "$(ENV).tfvars" ]; then \
	  echo "Error: $(ENV).tfvars does not exist"; \
	  exit 1; \
	else \
	  echo "Variable file '$(ENV).tfvars' exists."; \
	fi
	@echo "Checking if workspace '$(WORKSPACE)' exists..."
	@if terraform workspace list | grep -w $(WORKSPACE) > /dev/null; then \
	  echo "Workspace '$(WORKSPACE)' exists."; \
	else \
	  read -p "Workspace '$(WORKSPACE)' does not exist. Create it? [y/N]: " resp && \
	  if [ "$$resp" = "y" ] || [ "$$resp" = "Y" ]; then \
	    terraform workspace new $(WORKSPACE); \
	  else \
	    echo "Workspace creation cancelled. Exiting."; \
	    exit 1; \
	  fi; \
	fi

init:
	terraform init

make_workspace: check-env
	terraform workspace new $(WORKSPACE)

plan: ensure_workspace
	terraform workspace select $(WORKSPACE)
	terraform plan -var-file $(ENV).tfvars

apply: ensure_workspace
	terraform workspace select $(WORKSPACE)
	terraform apply -var-file $(ENV).tfvars

help:
	@echo "Usage: make [target] ENV=<workspace>"
	@echo ""
	@echo "Available targets:"
	@echo "  init           - Initialize Terraform configuration"
	@echo "  make_workspace - Explicitly create the workspace"
	@echo "  plan           - Generate an execution plan (workspace creation confirmed)"
	@echo "  apply          - Apply the plan (workspace creation confirmed)"

