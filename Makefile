COMPOSE_DIR=./srcs/docker-compose.yml

all: env
	@echo "\033[0;33mBuilding Containers...\033[0m"
	@docker compose -f $(COMPOSE_DIR) up -d --build

down:
	@docker compose -f $(COMPOSE_DIR) down

env:
	@if [ ! -f srcs/.env ] ; then\
		echo "\033[0;33m[WARNING]: .env file not specified, assuming default...\033[0m";\
		if [ ! -f ~/data/.env ] ; then\
			echo "\033[1;31mInception: ERROR: .env not found\033[0m";\
			exit 1;\
		else\
			cp ~/data/.env srcs/;\
		fi;\
	fi;

clean: down
	@echo "\033[0;33mCleaning Up...\033[0m"
	@if [ ! -z "$(docker ps -qa)" ] ; then docker stop $(docker ps -qa) ; fi;

fclean: clean
	@rm srcs/.env
	@docker system prune -fa
	@echo "\033[1;31mAll Inception files cleaned!\033[0m"

re: fclean all
