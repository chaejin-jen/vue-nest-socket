NAME = vue-nest-socket

# Check your env_file
# cp /home/${USER}/ft_transcendence/backend/.env ./

all: up

cp:
	cp ./.env.sample ./backend/.env
	cp ./nginx.conf ./frontend/nginx.conf
	cp ./Dockerfile.front ./frontend/Dockerfile
	cp ./Dockerfile.back ./backend/Dockerfile

init:
	git submodule update --init --recursive

dev-switch:
	cd frontend && git switch develop

dev:
	@echo "Building ${NAME}-dev ...\n"
	@mkdir -p /home/${USER}/transcendence/data/upload
	@mkdir -p /home/${USER}/transcendence/data/postgresql
	@mkdir -p /home/${USER}/transcendence/data/postgresql-log
	@docker compose -f .docker/docker-compose.yml up --build

build:
	@echo "Building ${NAME} ...\n"
	@mkdir -p /home/${USER}/transcendence/data/upload
	@mkdir -p /home/${USER}/transcendence/data/postgresql
	@mkdir -p /home/${USER}/transcendence/data/postgresql-log
	@docker compose -f docker-compose.yml up --build

up:
	@echo "Starting ${NAME} ...\n"
	@mkdir -p /home/${USER}/transcendence/data/upload
	@mkdir -p /home/${USER}/transcendence/data/postgresql
	@mkdir -p /home/${USER}/transcendence/data/postgresql-log
	@docker compose -f ./docker-compose.yml up

dev-up:
	@echo "Starting ${NAME} ...\n"
	@mkdir -p /home/${USER}/transcendence/data/upload
	@mkdir -p /home/${USER}/transcendence/data/postgresql
	@mkdir -p /home/${USER}/transcendence/data/postgresql-log
	@docker compose -f .docker/docker-compose.yml up

start:
	@echo "Starting ${NAME} ...\n"
	@docker compose -f ./docker-compose.yml start

stop:
	@echo "Stopping ${NAME} ...\n"
	@docker compose -f ./docker-compose.yml stop

down:
	@echo "Shuting Down ${NAME} ...\n"
	@docker compose -f ./docker-compose.yml down

dev-down:
	@echo "Shuting Down ${NAME}-dev ...\n"
	@docker compose -f .docker/docker-compose.yml down

clear:
	@su -c 'rm -rf /home/${USER}/transcendence/data'

clean: down clear
	@echo "Cleaning ${name} ... (keep images)\n"
	@docker volume rm test_db_volumes test_uploads_volumes

fclean: clear
	@echo "Total Cleaning ...\n"
	@docker stop $$(docker ps -aq)
	@docker system prune --all --force --volumes
	@docker network prune --force
	@docker volume rm test_db_volumes test_uploads_volumes

re: fclean all

.PHONY	: all build down re clean fclean
