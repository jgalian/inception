FROM debian:buster

RUN apt-get update && apt-get -y install php php-cli php-cgi php-fpm php-mysql php-zip wget

EXPOSE 9000

COPY ./conf/www.conf /etc/php/7.3/fpm/pool.d
COPY ./conf/wp-config.php /var/www/
COPY ./tools/wp_start.sh /var/www/

RUN chmod +x /var/www/wp_start.sh

ENTRYPOINT [ "/var/www/wp_start.sh" ]

CMD ["/usr/sbin/php-fpm7.3", "--nodaemonize"]
