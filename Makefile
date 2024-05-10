# **************************************************************************** #
#                                                                              #
#                                                         :::      ::::::::    #
#    Makefile                                           :+:      :+:    :+:    #
#                                                     +:+ +:+         +:+      #
#    By: aelbrahm <aelbrahm@student.1337.ma>        +#+  +:+       +#+         #
#                                                 +#+#+#+#+#+   +#+            #
#    Created: 2024/04/29 09:22:56 by aelbrahm          #+#    #+#              #
#    Updated: 2024/05/04 10:51:36 by aelbrahm         ###   ########.fr        #
#                                                                              #
# **************************************************************************** #

#================================#
#         COLORS                 #
#================================#
BLU = \033[34;1m
CYN = \033[36;1m
PRP = \033[35;1m
GRN = \033[32;1m 
RED = \033[31;1m
YLW = \033[33;1m
C_CLS = \033[0m

#================================#
#         GLOBAL_VARIABLE        #
#================================#

P_NAME = inception
COMPOSE_CMD = docker-compose
COMPOSE_PATH = ./srcs/docker-compose.yaml
RUN = bash
HOST=/Users/aelbrahm/Desktop/data
VM=/home/aelbrahm/data
VOLUME_DIR_SCRIPT=srcs/requirements/wordpress/tools/mk_dir.sh
#================================#
#            RULES               #
#================================#
all: VLM_DIR build

VLM_DIR: 
		printf "\033[32;1m Start building... \033[0m\n"
		chmod +x $(VOLUME_DIR_SCRIPT)
		$(RUN) $(VOLUME_DIR_SCRIPT)


build:
		$(COMPOSE_CMD) -f $(COMPOSE_PATH) --project-name $(P_NAME) up --build

start:
		$(COMPOSE_CMD) -f $(COMPOSE_PATH) --project-name $(P_NAME) start

stop:
		$(COMPOSE_CMD) -f $(COMPOSE_PATH) --project-name $(P_NAME) stop

re:
	@printf "Rebuild configuration $(P_NAME)...\n"
	@$(COMPOSE_CMD) -f ./srcs/docker-compose.yml --env-file srcs/.env up -d --build

down: stop
	@$(COMPOSE_CMD) -f $(COMPOSE_PATH) --project-name $(P_NAME) down


clean: down
		docker system prune -a
		rm -rf $(VM)/wordpress/*
		rm -rf $(VM)/mariadb/*
fclean: 
	printf "\033[32;1mTotal clean of all configurations docker\033[0m\n"
	$(COMPOSE_CMD) -f $(COMPOSE_PATH) --project-name $(P_NAME) down -v
	docker system prune --all --force --volumes
	docker network prune --force
	docker volume prune --force
	rm -rf $(VM)/wordpress/*
	rm -rf $(VM)/mariadb/*

.SILENT : VLM_DIR build clean fclean down