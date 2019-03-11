.PHONY: all

info: intro commands outro
intro:
	@echo "     _            _             "
	@echo "    | |          | |            "
	@echo "  __| | ___   ___| | _____ _ __ "
	@echo " / _  |/ _ \ / __| |/ / _ \ |__|"
	@echo "| (_| | (_) | (__|   <  __/ |   "
	@echo " \____|\___/ \___|_|\_\___|_|   "
	@echo ""
outro:
	@echo ""

commands:
	@echo "Available commands:"
	@echo ""
	@echo "Command                      Description"
	@echo "-------                      -----------"
	@echo "make info                    Show the available make commands"
	@echo "make build                   Build all containers to run the application"
	@echo "make start                   Start the containers to run the application"
	@echo "make cleanup                 Cleanup the stopped and running containers and container images"
	@echo ""

build: build-containers
start: containers-start
cleanup: containers-cleanup

build-containers: intro containers-prepare outro

containers-prepare:
	@echo "=== Calling start because docker-compose executes build automatically ==="
	make start 

containers-start:
	@echo "=== Starting all conatiners ==="
	./scripts/run.sh

containers-cleanup:
	@echo "=== Cleaning up everything ==="
	./scripts/cleanup.sh