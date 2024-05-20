FROM node:21.5.0-alpine3.19

# Arguments
ARG APP_HOME=/home/node/app
ARG CLOUD_SERVER

# Create app directory
WORKDIR ${APP_HOME}
ENV CLOUD_SERVER=$CLOUD_SERVER

# Install app dependencies
COPY package*.json ./
RUN \
  echo "*** Install npm packages ***" && \
  npm install

# Bundle app source
COPY . ./
RUN sed -i "s|\"'https://tavernai.net'; //'https://tavernai.net'; http://127.0.0.1\"|\"${CLOUD_SERVER}\"|g" config.toml
# Cleanup unnecessary files
RUN \
  echo "*** Cleanup ***" && \
  rm -rf "./.git"

EXPOSE 8000

CMD ["node", "/home/node/app/server.js"]
