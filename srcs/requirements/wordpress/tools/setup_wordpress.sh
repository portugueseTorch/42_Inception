#!/bin/bash

# Check if Wordpress is already installed
if [ -f wp-config.php ]
then
	echo -e "\033[1;33mWordpress already setup\033[0m"
else

	sleep 2
	# Download Wordpress, move contents to current directory, and delete garbage
	wget http://wordpress.org/latest.tar.gz
	tar -xf latest.tar.gz
	mv wordpress/* .
	rm -rf wordpress
	rm -f latest.tar.gz

	# Modify the wp-config-sample.php to add the variables defined in env
	sed -i "s/username_here/$MYSQL_DB_USER/g" wp-config-sample.php
	sed -i "s/password_here/$MYSQL_DB_PASSWORD/g" wp-config-sample.php
	sed -i "s/localhost/$MYSQL_HOSTNAME/g" wp-config-sample.php
	sed -i "s/database_name_here/$MYSQL_DB_NAME/g" wp-config-sample.php
	cp wp-config-sample.php wp-config.php

	# To setup redis, we need to edit the wp-config.php. We need to set the redis host,
	# define the port for redis, define the wp cache key salt (security measure), define
	# a redis password and a redis client. Allways include the --allow-root: else, the
	# execution of the commands can be restricted from being executed as root.
	wp config set --allow-root WP_REDIS_HOST redis
	wp config set --allow-root --raw WP_REDIS_PORT 6379 # --raw adds 6379 as number instead of '6379'
	wp config set --allow-root WP_CACHE_KEY_SALT $DOMAIN_NAME
	wp config set --allow-root WP_REDIS_CLIENT phpredis

	# Install the redis-cache plugin and activate it right away with --activate, update
	# all plugins and enable redis
	wp plugin install --allow-root --activate redis-cache
	wp plugin update --allow-root --all
	wp redis enable --allow-root

fi

exec "$@"
