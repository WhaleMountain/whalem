FROM golang:rc-alpine3.12 AS builder

RUN apk add --no-cache git && \
    git clone https://github.com/WhaleMountain/filegea.git /tmp/filegea && \
    cd /tmp/filegea \
    go build

FROM alpine:3.12

RUN mkdir -p /opt/filegea/Data
COPY --from=builder /tmp/filegea/main /opt/filegea/filegea

USER filegea

EXPOSE 1270
CMD ["/opt/filegea/filegea"]