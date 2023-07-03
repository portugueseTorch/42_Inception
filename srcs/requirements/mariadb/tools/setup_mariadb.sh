#!/bin/bash

# Initialize DB and upgrade if needed
service mariadb start
mysql_upgrade --force

# Check if the repository where the data will be stored already exists
# If so, skip setup
if [ -d /var/lib/mysql]
then
	echo -e "\033[1;33mMariaDB already setup\033[0m"
else
# Secure login
mysql_secure_installation << EOF

Y
Y
root
root
Y
n
Y
Y
EOF

fi

exec "$@"
