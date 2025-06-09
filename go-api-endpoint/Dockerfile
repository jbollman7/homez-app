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
RUN apk add --no-cache sqlite-libs

WORKDIR /app

# Copy in the compiled binary and the seeded DB
COPY --from=builder /app/web-service-gin .
COPY --from=builder /app/housing.db .

EXPOSE 8080
CMD ["./web-service-gin"]
