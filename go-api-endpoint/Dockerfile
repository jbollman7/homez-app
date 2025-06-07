# Use the official Golang image as the base image
#FROM golang:1.24-alpine
FROM golang:1.24

# Set environment variables
ENV GIN_MODE=release
# Listen on Port 8080
ENV PORT=8080

# Set the working directory inside the container
WORKDIR /app

# Copy go.mod and go.sum files first to leverage Docker cache
COPY go.mod go.sum ./
RUN go mod download

# Copy the rest of the application code
COPY . .

# Build the Go application
RUN go build -o web-service-gin .

# Expose the port the app runs on
EXPOSE $PORT

# Command to run the executable
CMD ["./web-service-gin"]

