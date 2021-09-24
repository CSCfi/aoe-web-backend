#!/bin/bash
DIR="$(dirname "$(readlink -f "$0")")" && cd "$DIR/../"

INSTANCE="aoe-web-backend"
IMAGE="aoe-web-backend"

docker stop $INSTANCE || echo 'Not running'
docker rm $INSTANCE || echo 'Not existing'
docker run -it -d \
  --name $INSTANCE \
  --link postgres:postgres \
  --sysctl=net.core.somaxconn=511 \
  -e "PG_URL=User ID=postgres;Password=postgres;Host=postgres;Port=5432;Database=aoe;" \
  -p 3000:3000 \
  $IMAGE
docker logs $INSTANCE -f
