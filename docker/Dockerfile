FROM node:14-alpine as node_builder
WORKDIR /app
COPY ./ /app
ARG env=prod

# Install only locked dependencies from package-lock.json (faster)
RUN npm ci && \
    npm run build -- --prod

FROM centos:7

# Make directories with permissions and install required packages
RUN groupadd --gid 5606 webapp && \
    useradd -ms /bin/false -d /app node && \
    yum install -y epel-release && \
    mkdir -p /app/data && \
    mkdir -p /app/uploads && \
    mkdir -p /app/thumbnail && \
    mkdir -p /webdata/ && \
    chown -R node:node /app && \
    (curl -sL https://rpm.nodesource.com/setup_14.x | bash -) && \
    yum install -y nodejs && \
    npm install -g pm2@2.5.0 && \
    yum install -y libreoffice && \
    usermod -aG 5606 node && \
    ln -s /webdata /app/webdata

# Copy source code and configuration files to the app directory
COPY --from=node_builder /app/dist/ /app/dist/
COPY ./views /app/views
COPY ./package.json /app
COPY ./package-lock.json /app
COPY ./src/elasticSearch/aoemapping.json /app
COPY ./src/elasticSearch/aoecollectionmapping.json /app
COPY ./h5p/core /app/webdata/h5p/core

RUN (cd /app && npm install --only=production) && \
    npm uninstall -g npm

EXPOSE 3000
WORKDIR /app
CMD ["node", "dist/server.js"]
