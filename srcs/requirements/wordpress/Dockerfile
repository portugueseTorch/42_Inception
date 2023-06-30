FROM debian:oldstable

# Update and install dependencies
RUN apt-get update && apt-get install -y \
	wget curl bash \
	php7.4 php-cgi php-fpm php-mysql php-mbstring

# Installing WP-CLI, making the file executable and adding it to PATH
RUN curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar \
	&& chmod +x wp-cli.phar \
	&& mv wp-cli.phar /usr/local/bin/wp

# Copy the www.conf file into the container
COPY ./conf/www.conf /etc/php/7.4/fpm/pool.d/

# Make the run directory to allow FPM to run
RUN mkdir /run/php/

# Copy the Wordpress Script into the container, and set it as entrypoint
COPY ./tools/setup_wordpress.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_wordpress.sh

# Set directory
WORKDIR /var/www/html/

ENTRYPOINT [ "/usr/local/bin/setup_wordpress.sh" ]

CMD [ "/usr/sbin/php-fpm7.4", "-F" ]
