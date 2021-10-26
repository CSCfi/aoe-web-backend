FROM node:14 as node_builder
WORKDIR /app
COPY package.json /app/
RUN npm install
COPY ./ /app
ARG env=prod
# fix build issue
RUN npm run build -- --prod

########################################################################################################################

FROM centos:7

# Initialize system
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

# Copy sources and other files
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
