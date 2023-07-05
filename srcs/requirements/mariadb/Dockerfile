FROM debian:oldstable

# Update and install mariadb server and client
RUN apt-get update && apt-get install -y \
	mariadb-server mariadb-client

# Make the necessary directory for mysql to run (similar to PHP-FPM)
RUN mkdir -p /var/run/mysqld && \
	chown -R mysql:mysql /var/run/mysqld && \
	chmod 777 /var/run/mysqld

# Copy the setup script into the container and give it execution rights
COPY ./tools/setup_mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_mariadb.sh

# Copy the configuration files to their respective locations
COPY ./conf/wordpress.sql /usr/local/bin/
COPY ./conf/mysqld.conf /etc/mysql/my.cnf

ENTRYPOINT [ "setup_mariadb.sh" ]

EXPOSE 3306

CMD [ "mysqld", "--bind-address=0.0.0.0" ]