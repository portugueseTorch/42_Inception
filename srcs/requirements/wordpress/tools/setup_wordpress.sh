#!/bin/bash

# Check if Wordpress is already installed
if [ -f ./wp-config.php ]
then
	echo -e "\033[1;33mWordpress already setup\033[0m"
else
	# Download Wordpress, move contents to current directory, and delete garbage
	wget http://wordpress.org/latest.tar.gz
	tar xfz latest.tar.gz
	mv wordpress/* .
	rm -rf ./wordpress/
	rm -f latest.tar.gz

	# Modify the wp-config-sample.php to add the variables defined in env
	sed -i 's/database_name_here/$MYSQL_DATABASE/g' wp-config-sample.php
	sed -i 's/username_here/$MYSQL_USER/g' wp-config-sample.php
	sed -i 's/password_here/$MYSQL_PASSWORD/g' wp-config-sample.php
	sed -i 's/localhost/$MYSQL_HOST/g' wp-config-sample.php
	# sed -i 's/database_name_here/hi there/g' wp-config-sample.php
	# sed -i 's/username_here/hi there/g' wp-config-sample.php
	# sed -i 's/password_here/hi there/g' wp-config-sample.php
	# sed -i 's/localhost/hi there/g' wp-config-sample.php
	cp wp-config-sample.php wp-config.php

fi

exec "$@"
