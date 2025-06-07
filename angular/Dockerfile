FROM node:24

WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install -g @angular/cli

COPY . .
RUN npm ci

RUN npm run build
EXPOSE 4200
CMD ["ng", "serve", "--host", "0.0.0.0"]
