
REPO_NAME ?= liquidapp
DEV_PRO := liquidev
REL_PRO := liquidrel
DEV_FILE := docker/dev/docker-compose.yml
REL_FILE := docker/release/docker-compose.yml


.PHONY: devtest build release clean

devtest:
	
	@ echo "Pulling latest images..."
	@ docker-compose -p $(DEV_PRO) -f $(DEV_FILE) pull db 
	@ echo "Building images..."
	@ docker-compose -p $(DEV_PRO) -f $(DEV_FILE) build --pull web
	@ echo "Ensuring database is ready..."
	@ docker-compose -p $(DEV_PRO) -f $(DEV_FILE) run --rm agent
	@ echo "Running tests..."
	@ docker-compose -p $(DEV_PRO) -f $(DEV_FILE) up web

release:
	@ echo "Starting release env"
	@ echo "Building images..."
	@ docker-compose -p $(REL_PRO) -f $(REL_FILE) build web
	@ echo "Ensuring database is ready..."
	@ docker-compose -p $(REL_PRO) -f $(REL_FILE) run --rm agent-db
	@ echo "Starting release env services"
	@ docker-compose -p $(REL_PRO) -f $(REL_FILE) up -d lb
	@ echo "Ensuring HAproxy is ready..."
	@ docker-compose -p $(REL_PRO) -f $(REL_FILE) run --rm agent-db
	@ echo "Scaling web services"
	@ docker-compose -p $(REL_PRO) -f $(REL_FILE) scale web=3
	@ echo "Running tests..."
	@ docker-compose -p $(REL_PRO) -f $(REL_FILE) run --rm test


clean:
	@ echo "Destroying dev env"
	@ docker-compose -p $(DEV_PRO) -f $(DEV_FILE) kill
	@ docker-compose -p $(DEV_PRO) -f $(DEV_FILE) rm --all -f -v
	@ echo "Destroying Release env"
	@ docker-compose -p $(REL_PRO) -f $(REL_FILE) kill
	@ docker-compose -p $(REL_PRO) -f $(REL_FILE) rm --all -f -v
	@ echo "Removing dangling objects"
	@ docker images -q -f dangling=true -f label=application=$(REPO_NAME) | xargs -I ARGS docker rmi -f ARGS
	@ echo "Clean complete"
