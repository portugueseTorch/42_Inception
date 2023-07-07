#!/bin/bash

# Start mariadb service, and upgrade
service mariadb start
mysql_upgrade --force

# Check if the database already exists before proceding with setup
if [ -d "/var/lib/mysql/$MYSQL_DB_NAME" ]
then
	echo -e "\033[1;33mMariaDB already setup\033[0m"
else

# Proceed with secure instalation:
# 	- enable UNIX socket authentication (Y)
# 	- change root password (Y)
# 	- insert new password
# 	- repeat new password
# 	- remove anonymous users (Y)
# 	- disallow remote login (n)
# 	- remove test database (Y)
# 	- reload privileges table (Y)
mysql_secure_installation << EOF

Y
Y
$MYSQL_DB_ROOT_PASSWORD
$MYSQL_DB_ROOT_PASSWORD
Y
n
Y
Y
EOF

# Grant all privileges to root, and create the database if it doesn't yet exist
mariadb -u root << EOF
GRANT ALL ON *.* TO 'root'@'%' IDENTIFIED BY '$MYSQL_DB_ROOT_PASSWORD'; FLUSH PRIVILEGES;
CREATE DATABASE IF NOT EXISTS $MYSQL_DB_NAME; GRANT ALL ON $MYSQL_DB_NAME.* TO '$MYSQL_DB_USER'@'%' IDENTIFIED BY '$MYSQL_DB_PASSWORD'; FLUSH PRIVILEGES;
EOF

mariadb -u $MYSQL_DB_USER -p$MYSQL_DB_PASSWORD $MYSQL_DB_NAME < /usr/local/bin/wordpress.sql

fi

service mariadb stop

exec "$@"
