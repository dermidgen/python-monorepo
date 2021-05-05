.PHONY: container clean_container

# Use ./dist as build context to avoid .venv and other files from creating a fat build context
# Docker builds only install from artifacts in ./dist. We can avoid .dockerignore by adjusting
# the build context.
container:
	docker build -t $(shell basename $(CURDIR)):latest -f ./Dockerfile ./dist

clean_container:
	-docker rmi -f $(shell basename $(CURDIR)):latest
