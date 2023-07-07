FROM debian:oldstable

RUN apt-get update && apt-get upgrade && \
	apt-get install -y redis

RUN mkdir -p /run/redis

RUN chown -R redis:redis /run/redis/ /var/lib/redis

COPY ./tools/setup_redis.sh /usr/local/bin
RUN chmod 777 /usr/local/bin/setup_redis.sh

EXPOSE 6379

USER redis

CMD [ "sh", "/usr/local/bin/setup_redis.sh" ]