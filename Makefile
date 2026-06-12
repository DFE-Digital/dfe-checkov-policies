POLICY ?= cip
ENV ?= development
CHECKOV_IMAGE ?= bridgecrew/checkov:latest
COMPOSE_FILE := docker/docker-compose.yaml

.PHONY: test test-cip test-elz tf-fmt build-cip run-cip build-elz run-elz down help

# Default target
help:
	@echo "Usage:"

	@echo "	make test-cip : Run Checkov tests for 'cip' policy set (defaults to development env)"
	@echo "	make test-elz : Run Checkov tests for 'elz' policy set (defaults to development env)"
	@echo "	make test POLICY=<name> ENV=<env> : Run Checkov tests for a specific policy and environment"
	@echo "	make tf-fmt : Run Terraform fmt recursively across the project"

test:
	@if [ ! -d "tests/$(POLICY)" ]; then echo "Error: Test directory not found: tests/$(POLICY)"; exit 1; fi
	@if [ ! -d "policies/$(POLICY)" ]; then echo "Error: Policy directory not found: policies/$(POLICY)"; exit 1; fi
	@if [ ! -f "tests/$(POLICY)/environments/$(ENV).tfvars" ]; then echo "Error: Var file not found: tests/$(POLICY)/environments/$(ENV).tfvars"; exit 1; fi
	@echo "Running Checkov tests for policy set '$(POLICY)' using '$(ENV).tfvars'"
	docker run --rm \
		-v "$(CURDIR)/tests/$(POLICY):/tests" \
		-v "$(CURDIR)/policies/$(POLICY):/policies/$(POLICY)" \
		-v "$(CURDIR)/policies/common:/policies/common" \
		-v "$(CURDIR)/tests/$(POLICY)/environments:/envs" \
		$(CHECKOV_IMAGE) \
		-d "/tests" --var-file "/envs/$(ENV).tfvars" \
		--external-checks-dir "/policies" \
		--skip-check "CKV*" \
		--soft-fail \
		--output cli

test-cip:
	@$(MAKE) test POLICY=cip ENV=$(ENV)

test-elz:
	@$(MAKE) test POLICY=elz ENV=$(ENV)

tf-fmt:
	terraform fmt -recursive

down:
	docker-compose -f $(COMPOSE_FILE) down

build-cip:
	docker-compose -f $(COMPOSE_FILE) build --no-cache checkov-cip

run-cip:
	docker-compose -f $(COMPOSE_FILE) run --rm checkov-cip

build-elz:
	docker-compose -f $(COMPOSE_FILE) build --no-cache checkov-elz

run-elz:
	docker-compose -f $(COMPOSE_FILE) run --rm checkov-elz