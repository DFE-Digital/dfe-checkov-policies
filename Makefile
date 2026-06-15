.DEFAULT_GOAL := help

POLICY ?= cip
ENV ?= development

CHECKOV_IMAGE ?= bridgecrew/checkov:latest

COMPOSE_FILE := docker/docker-compose.yaml
DOCKER_COMPOSE ?= docker-compose -f $(COMPOSE_FILE)

VALID_POLICIES := cip elz

TEST_DIR := tests/$(POLICY)
POLICY_DIR := policies/$(POLICY)
ENV_DIR := $(TEST_DIR)/environments
VAR_FILE := $(ENV_DIR)/$(ENV).tfvars

CHECKOV_RUN = docker run --rm \
	-v "$(CURDIR)/$(TEST_DIR):/tests" \
	-v "$(CURDIR)/$(POLICY_DIR):/policies/$(POLICY)" \
	-v "$(CURDIR)/policies/common:/policies/common" \
	-v "$(CURDIR)/$(ENV_DIR):/envs"

.PHONY: test test-cip test-elz build build-cip build-elz run run-cip run-elz \
	validate-policy validate-paths tf-fmt clean down help

# Default target
help:
	@echo "Usage:"

	@echo "	make test-cip : Run Checkov tests for 'cip' policy set (defaults to development env)"
	@echo "	make test-elz : Run Checkov tests for 'elz' policy set (defaults to development env)"
	@echo "	make test POLICY=<name> ENV=<env> : Run Checkov tests for a specific policy and environment"
	@echo "	make tf-fmt : Run Terraform fmt recursively across the project"

validate-policy:
	$(if $(filter $(POLICY),$(VALID_POLICIES)),,\
		$(error Invalid POLICY '$(POLICY)'. Valid values: $(VALID_POLICIES)))

validate-paths:
	$(if $(wildcard $(TEST_DIR)),,$(error Missing directory: $(TEST_DIR)))
	$(if $(wildcard $(POLICY_DIR)),,$(error Missing directory: $(POLICY_DIR)))
	$(if $(wildcard $(VAR_FILE)),,$(error Missing file: $(VAR_FILE)))


test: validate-policy validate-paths
	@echo "Running Checkov tests for policy set '$(POLICY)' using '$(ENV).tfvars'"
	$(CHECKOV_RUN) \
		$(CHECKOV_IMAGE) \
		-d /tests \
		--var-file /envs/$(ENV).tfvars \
		--external-checks-dir /policies \
		--skip-check CKV* \
		--soft-fail \
		--output cli

build:
	$(DOCKER_COMPOSE) build --no-cache checkov-$(POLICY)

run:
	$(DOCKER_COMPOSE) run --rm checkov-$(POLICY)

tf-fmt:
	terraform fmt -recursive

down:
	$(DOCKER_COMPOSE) down

clean:
	$(DOCKER_COMPOSE) down --volumes --remove-orphans

# Convenience aliases
test-cip:
	@$(MAKE) test POLICY=cip ENV=$(ENV)

test-elz:
	@$(MAKE) test POLICY=elz ENV=$(ENV)

build-cip:
	@$(MAKE) build POLICY=cip

build-elz:
	@$(MAKE) build POLICY=elz

run-cip:
	@$(MAKE) run POLICY=cip

run-elz:
	@$(MAKE) run POLICY=elz