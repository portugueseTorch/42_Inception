FROM debian:oldstable

RUN apt-get update && apt-get install -y \
	mariadb-server mariadb-client

RUN mkdir -p /var/run/mysqld \
	&& chown -R mysql:mysql /var/run/mysqld \
	&& chmod 777 /var/run/mysqld

COPY ./conf/mysqld.conf /etc/mysql/my.cnf

COPY ./tools/setup_mariadb.sh /usr/local/bin/
RUN chmod +x /usr/local/bin/setup_mariadb.sh

EXPOSE 3306

CMD [ "bash" ]
