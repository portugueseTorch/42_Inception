FROM debian:oldstable

# Install Redis
RUN apt-get update && apt-get install -y \
	redis

# Create the necessary folder for redis and a new user
RUN mkdir -p /var/run/redis

# Give the necessary permissions to the redis user
RUN chown -R redis:redis /var/run/redis/ /var/lib/redis

# Copy the setup script for Redis and give it execution rights
COPY ./tools/setup_redis.sh /usr/local/bin
RUN chmod +x /usr/local/bin/setup_redis.sh

# Define the user as redis
USER redis

# Run the configuration script
ENTRYPOINT [ "setup_redis.sh" ]

EXPOSE 6379

CMD [ "redis-server", "/etc/redis/redis.conf" ]
