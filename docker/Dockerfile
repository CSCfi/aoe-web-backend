ARG AOE_DOCKER_REGISTRY
FROM node:18.18.2-alpine3.18 as node_builder
WORKDIR /app
COPY ./ /app

# Install only locked dependencies from package-lock.json
RUN npm ci && \
    npm run build -- --omit=dev

FROM $AOE_DOCKER_REGISTRY/aoe-oracle-base:latest
# Preinstalled contents of aoe-oracle-base image:
# FROM oraclelinux:8.8
# RUN groupadd --gid 5606 webapp && \
#     useradd -ms /bin/false -d /app node && \
#     mkdir -p /app/data && \
#     mkdir -p /app/uploads && \
#     mkdir -p /app/thumbnail && \
#     mkdir -p /webdata/ && \
#     chown -R node:node /app && \
#     yum update -y && \
#     yum install -y epel-release && \
#     yum install -y curl && \
#     yum install -y https://rpm.nodesource.com/pub_18.x/nodistro/repo/nodesource-release-nodistro-1.noarch.rpm && \
#     yum install -y nodejs --setopt=nodesource-nodejs.module_hotfixes=1 && \
#     npm install -g pm2@2.5.0 && \
#     yum install -y libreoffice && \
#     usermod -aG 5606 node && \
#     ln -s /webdata /app/webdata

COPY --from=node_builder /app/dist/ /app/dist/
COPY ./views /app/views
COPY ./package.json /app
COPY ./package-lock.json /app
COPY ./src/search/aoemapping.json /app
COPY ./src/search/aoecollectionmapping.json /app

RUN (cd /app && npm ci) && \
    npm uninstall -g npm

EXPOSE 3000
WORKDIR /app
CMD ["node", "dist/server.js"]
