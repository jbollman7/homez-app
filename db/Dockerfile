# Start with a lightweight base image
FROM alpine:latest

# set initial path
WORKDIR /db

# Copy seed script
COPY ./seed-script.sh /db/seed-script.sh

# Install SQLite
RUN apk update && apk add sqlite

# Install JQ
RUN apk add jq

# Install Bash to run seed script
#RUN apk add --no-cache bash

RUN chmod +x /db/seed-script.sh

#RUN /bin/bash -c "/db/seed-script.sh"
#RUN sh /db/seed-script.sh

# Set the default command to open SQLite
CMD ["sqlite3", "housing.db"]
#CMD ["sh", "-c", "/db/seed-script.sh && exec sqlite3 housing.db"]

