FROM debian:oldstable

# Install nginx and openssl
RUN apt-get update && \
	apt-get install -y nginx openssl

# Create the folder to store the TSL certification
RUN mkdir /etc/nginx/ssl

# Create a new ssl key: RSA key with 4096 bits, self-signed using
# sha256 hashing, valid for 365 days and with no encryption
# We will then output the key into files stored in the directory
# created on the previous RUN
RUN openssl req -newkey rsa:4096 \
	-x509 -sha256 -days 365 -nodes \
	-subj "/CN=gda-cruz.42.fr/O=42/C=PT/L=Lisbon" \
	-out /etc/nginx/ssl/gda-cruz.crt \
	-keyout /etc/nginx/ssl/gda-cruz.key

COPY ./conf/nginx.conf /etc/nginx/conf.d/
COPY ./index.html /var/www/html/

EXPOSE 443

CMD [ "nginx", "-g", "daemon off;" ]
