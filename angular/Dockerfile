FROM node:24-alpine3.22

WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install -g @angular/cli

# Install python for deps
# install python3 + symlink to “python” + C/C++ toolchain
RUN apk add --no-cache \
      python3 \
      make \
      g++ \
    && ln -sf /usr/bin/python3 /usr/bin/python

COPY . .
RUN npm ci

RUN npm run build
EXPOSE 4200
CMD ["ng", "serve", "--host", "0.0.0.0"]
#CMD ["ng", "serve", "--proxy-config", "proxy.config.json"]
