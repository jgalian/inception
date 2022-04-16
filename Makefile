PATH_	:=	./srcs/docker-compose.yml

all:	up

up:		# crea, re(crea) e inicia contenedores
		docker-compose -f $(PATH_) up -d --build

start:	# inicia contenedores ya creados que están parados
		docker-compose -f $(PATH_) start

stop:	# para los contenedores sin borrarlos
		docker-compose -f $(PATH_) stop

down:	# para y borra contenedores, imágenes, redes y volúmenes (creados con up)
		docker-compose -f $(PATH_) down

logs:	# muestra los logs de los servicios
		docker-compose -f $(PATH_) logs

ps:		# lista los contenedores de compose y su estado
		docker-compose -f $(PATH_) ps

status:	# imprime todos los contenedores, imágenes, volúmenes y redes creadas por docker
		@echo
		@echo ------- IMAGES -------
		@docker images
		@echo
		@echo ----- CONTAINERS -----
		@docker ps -a
		@echo
		@echo ------- VOLUMES ------
		@docker volume ls
		@echo
		@echo ------ NETWORKS ------
		@docker network ls
		@echo

mariadb:	# entra en el contenedor de mariadb
		cd ./srcs/requirements/mariadb/
		docker exec -it mariadb /bin/bash

nginx:		# entra en el contenedor de nginx
		cd ./srcs/requirements/nginx/
		docker exec -it nginx /bin/bash

wordpress:	# entra en el contenedor de wordpress
		cd ./srcs/requirements/wordpress/
		docker exec -it wordpress /bin/bash


# down -> 			para y borra contenedores, imágenes, volúmenes y redes creados con up
# system prune ->	borra contenedores, redes e imágenes que no están en uso
clean:	down
		docker system prune -f

fclean: # para y borra contenedores, imágenes, redes y volúmenes que actualmente tiene docker
		docker stop $$(docker ps -qa);\
		docker rm $$(docker ps -qa);\
		docker rmi -f $$(docker images -qa);\
		docker volume rm $$(docker volume ls -q);\
		docker network rm $$(docker network ls -q) 2>/dev/null

re:		clean all

.PHONY: all up start stop down logs ps fclean re
