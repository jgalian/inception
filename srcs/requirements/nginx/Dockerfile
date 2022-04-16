FROM debian:buster

RUN	apt-get update && apt-get -y install nginx openssl

EXPOSE 443

RUN openssl req -newkey rsa:4096 \
		-x509 \
		-sha256 \
		-days 365 \
		-nodes \
		-out /etc/ssl/certs/inception.crt \
		-keyout /etc/ssl/private/inception.key \
		-subj "/C=ES/ST=Madrid/L=Madrid/O=42_Madrid/CN=jgalian-.42.fr"

COPY /conf/mysite.conf /etc/nginx/sites-enabled/

CMD ["nginx", "-g", "daemon off;"]
