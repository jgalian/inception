FROM debian:buster

RUN apt-get update && apt-get -y install mariadb-server

EXPOSE 3306

#RUN chown -R mysql:mysql /var/lib/mysql

# En el archivo 50-server.cnf hay que comentar la linea "bind_address" para que no de error de conexión a la BBDD
COPY ./conf/50-server.cnf /etc/mysql/mariadb.conf.d/

COPY ./tools/setup.sql /var/www/
RUN service mysql start && mysql < /var/www/setup.sql && rm -f /var/www/setup.sql;
# importante poner los dos pasos del RUN en una sola línea o no funciona

CMD ["mysqld"]
