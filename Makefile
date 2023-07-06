COMPOSE_DIR = ./srcs/docker-compose.yml

all: env
	@echo "\033[0;33mBuilding Containers...\033[0m"
	@docker compose -f $(COMPOSE_DIR) up -d --build
	@echo "\033[0;32m[ Inception successfully built! ]\033[0m"

down:
	@if [ -f srcs/.env ] ; then docker compose -f $(COMPOSE_DIR) down; fi;

env:
	@if [ ! -f srcs/.env ] ; then\
		echo "\033[0;33m[WARNING]: .env file not specified, assuming default...\033[0m";\
		if [ ! -f ~/data/.env ] ; then\
			echo "\033[0;31m[ERROR]: Fatal: .env not found\033[0m";\
			exit 1;\
		else\
			cp ~/data/.env srcs/;\
		fi;\
	fi;

clean: down
	@echo "\033[0;33mCleaning Up...\033[0m"
	@docker system prune -fa

fclean: clean
	@if [ -f srcs/.env ] ; then rm srcs/.env; fi;
	@echo "\033[1;31mAll Inception files cleaned!\033[0m"

re: fclean all
