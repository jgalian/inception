#!/bin/bash

	sed -i "s/listen = \/run\/php\/php7.3-fpm.sock/listen = 9000/" "/etc/php/7.3/fpm/pool.d/www.conf";
	chown -R www-data:www-data /var/www/*;
	chown -R 755 /var/www/*;
	mkdir -p /run/php/;

if [ ! -f /var/www/html/wp-config.php ]; then
	# descargar wp-cli para gestionar wordpress desde línea de comandos
	wget https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar;
	chmod +x wp-cli.phar;
	mv wp-cli.phar /usr/local/bin/wp;

	# descargar e instalar wordpress
	mkdir -p /var/www/html
	cd /var/www/html;
	wp core download --allow-root;
	mv /var/www/wp-config.php /var/www/html/
	wp core install --allow-root --url=${WP_URL} --title=${WP_TITLE} --admin_user=${WP_ADMIN_LOGIN} --admin_password=${WP_ADMIN_PASSWORD} --skip-email
	wp user create --allow-root ${WP_USER_LOGIN} --skip-email --user_pass=${WP_USER_PASSWORD};
fi

exec "$@"
