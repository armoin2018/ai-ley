# Package.json scripts
{
  "scripts": {
    "dev:start": "vagrant up && vagrant ssh",
    "dev:clean": "vagrant destroy -f && vagrant up",
    "dev:provision": "vagrant provision",
    "dev:status": "vagrant global-status"
  }
}

# Makefile integration
.PHONY: dev-start dev-clean dev-ssh
dev-start:
	vagrant up

dev-clean:
	vagrant destroy -f
	vagrant up

dev-ssh:
	vagrant ssh