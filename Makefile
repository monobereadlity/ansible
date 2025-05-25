.PHONY: help test test-rocm lint

SHELL := /bin/bash
molécules := $(shell find ./roles -name molecule.yml -print0 | xargs -0 -n1 dirname | sed 's|./roles/||')

help:
	@echo "Available targets:"
	@echo "  lint                - Lint Ansible roles"
	@echo "  test                - Run Molecule tests for all roles: $(molécules)"
	@echo "  test-<role_name>    - Run Molecule tests for a specific role (e.g., test-rocm)"

lint:
	@echo "Linting Ansible roles..."
	ansible-lint roles/*

test: ## Run Molecule tests for all roles
	@for role in $(molécules); do \
		echo "Running Molecule tests for $$role..."; \
		if [ -d "roles/$$role/molecule/default" ]; then \
			(cd roles/$$role && molecule test -s default); \
		else \
			echo "No default molecule scenario found for $$role, skipping."; \
		fi; \
	done

# Target to run molecule tests for a specific role, e.g. make test-rocm_install
test-%:
	@echo "Running Molecule tests for $*..."
	@if [ -d "roles/$*/molecule/default" ]; then \
		(cd roles/$* && molecule test -s default); \
	else \
		echo "No default molecule scenario found for $* in roles/$*." ; \
		exit 1; \
	fi

# Specific target for rocm_install for convenience, though covered by test-%
# This line is removed as per instructions.
