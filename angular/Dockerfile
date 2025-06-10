FROM node:24-alpine3.22 AS build

WORKDIR /usr/src/app
COPY package.json package-lock.json ./
RUN npm install -g @angular/cli

# Install python for deps
# # install python3 + symlink to “python” + C/C++ toolchain
RUN apk add --no-cache \
      python3 \
      make \
      g++ \
    && ln -sf /usr/bin/python3 /usr/bin/python
RUN npm ci
COPY . .
RUN ng build --configuration production

# Stage 2: Serve the application
FROM nginx:alpine

COPY --from=build /usr/src/app/dist/homez-app /usr/share/nginx/html/homez-app
COPY nginx.conf /etc/nginx/conf.d/default.conf
EXPOSE 80
CMD ["nginx", "-g", "daemon off;"]
