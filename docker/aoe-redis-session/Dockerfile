FROM redis:6.2.4-alpine

WORKDIR /redis
COPY ./docker/aoe-redis-session/redis.conf /usr/local/etc/redis/redis.conf
COPY ./docker/aoe-redis-session/init.sh ./

RUN chmod +x init.sh

EXPOSE 6379
