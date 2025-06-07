# # Use the official Golang image as the base image
# FROM golang:1.24
#
# # Set environment variables
# ENV GIN_MODE=release
# # Listen on Port 8080
# ENV PORT=8080
#
# # Set the working directory inside the container
# WORKDIR /app
#
# # Copy go.mod and go.sum files first to leverage Docker cache
# COPY go.mod go.sum ./
# RUN go mod download
#
# # Copy the rest of the application code
# COPY . .
#
# # Build the Go application
# RUN go build -o web-service-gin .
#
# # Expose the port the app runs on
# EXPOSE $PORT
#
# # Command to run the executable
# CMD ["./web-service-gin"]
# FROM alpine:latest
#
# # set initial path
# WORKDIR /db
#
# # Copy seed script
# COPY ./seed-script.sh /db/seed-script.sh
#
# # Install SQLite
# RUN apk update && apk add sqlite
#
# # Install JQ
# RUN apk add jq
#
# # Install Bash to run seed script
# #RUN apk add --no-cache bash
#
# RUN chmod +x /db/seed-script.sh
#
# #RUN /bin/bash -c "/db/seed-script.sh"
# #RUN sh /db/seed-script.sh
#
# # Set the default command to open SQLite
# CMD ["sqlite3", "housing.db"]
# #CMD ["sh", "-c", "/db/seed-script.sh && exec sqlite3 housing.db"]
# 1) builder: compile with CGO + seed the DB
# ─────────────────────────────────────────────────────────────
# 1) BUILD & SEED STAGE
# ─────────────────────────────────────────────────────────────
FROM golang:1.24-alpine AS builder

# Install prerequisites for go-sqlite3 + bash for seeding
RUN apk add --no-cache \
      gcc \
      musl-dev \
      sqlite-dev \
      pkgconfig \
      bash \
      jq

WORKDIR /app

# 1a) Copy module files, download deps
COPY go.mod go.sum ./
RUN go mod download

# 1b) Copy seed script _and_ your app code into the same dir
COPY ./seed-script.sh .
COPY . .

# 1c) Make sure CGO is on so go-sqlite3 will compile C code
ENV CGO_ENABLED=1

# 1d) Run the seed script BEFORE building, so housing.db is created here
RUN chmod +x seed-script.sh \
 && ./seed-script.sh

# 1e) Now compile your Go app
RUN go build -o web-service-gin .

# ─────────────────────────────────────────────────────────────
# 2) RUNTIME STAGE
# ─────────────────────────────────────────────────────────────
FROM alpine:latest

# Pull in only the SQLite *library* (no CLI)
RUN apk add --no-cache sqlite-libs sqlite

WORKDIR /app

# Copy in the compiled binary and the seeded DB
COPY --from=builder /app/web-service-gin .
COPY --from=builder /app/housing.db .

EXPOSE 8080
CMD ["./web-service-gin"]


