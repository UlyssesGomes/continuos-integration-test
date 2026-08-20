# First Step
FROM golang:1.23 AS builder

WORKDIR /app

COPY go.mod go.sum ./
RUN go mod download

COPY . .

RUN CGO_ENABLED=0 GOOS=linux go build -o main .

# Second Step
FROM ubuntu:latest

WORKDIR /app

ENV HOST=localhost PORT=5432
ENV USER=root PASSWORD=root DB_NAME=root

COPY --from=builder /app/main .

EXPOSE 8000

CMD [ "./main" ]
