ARG AOE_DOCKER_REGISTRY
FROM node:18.18.2-alpine3.18 as node_builder
# FROM node:16.20.2-alpine3.18 as node_builder
# FROM node:14-alpine as node_builder
WORKDIR /app
COPY ./ /app

# Install only locked dependencies from package-lock.json (faster)
RUN npm ci && \
    npm run build -- --omit=dev

FROM $AOE_DOCKER_REGISTRY/aoe-oracle-base:latest

# Copy source code and configuration files to the app directory
COPY --from=node_builder /app/dist/ /app/dist/
# COPY ./cert /app/cert
# COPY ./.env /app
COPY ./views /app/views
COPY ./package.json /app
COPY ./package-lock.json /app
COPY ./src/search/aoemapping.json /app
COPY ./src/search/aoecollectionmapping.json /app
# COPY ./h5p/core /app/webdata/h5p/core

RUN (cd /app && npm ci) && \
    npm uninstall -g npm

EXPOSE 3000
WORKDIR /app
CMD ["node", "dist/server.js"]
