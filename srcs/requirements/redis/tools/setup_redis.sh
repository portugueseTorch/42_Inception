#!/bin/bash

if [ ! -f /etc/redis/redis.conf.bak ];
then
	cp /etc/redis/redis.conf /etc/redis/redis.conf.bak

	sed -i "s|bind 127.0.0.1|#bind 127.0.0.1|g" /etc/redis/redis.conf
	sed -i "s|protected-mode yes|protected-mode no|g" /etc/redis/redis.conf
	sed -i "s|# unixsocket /var/run/redis/redis-server.sock|unixsocket /var/run/redis/redis-server.sock|g" /etc/redis/redis.conf
	sed -i "s|# unixsocketperm 700|unixsocketperm 770|g" /etc/redis/redis.conf
	sed -i "s|# tls-protocols \"TLSv1.2 TLSv1.3\"|tls-protocols \"TLSv1.3\"|g" /etc/redis/redis.conf
	sed -i "s|always-show-logo yes|always-show-logo no|g" /etc/redis/redis.conf
	sed -i "s|# maxmemory <bytes>|maxmemory 256mb|g" /etc/redis/redis.conf
	sed -i "s|# maxmemory-policy noeviction|maxmemory-policy allkeys-lfu|g" /etc/redis/redis.conf

fi

redis-server --protected-mode no