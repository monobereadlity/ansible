lint-yaml:
	yamllint .

lint-ansible:
	ansible-lint

molecule:
	(cd roles/disable_suspend && molecule test -s default)

release:
	ansible-galaxy collection build

all: lint-yaml lint-ansible molecule
