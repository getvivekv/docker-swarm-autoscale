FROM alpine:3.6
RUN apk add --no-cache openssh
COPY entrypoint.sh /
ENTRYPOINT ["/entrypoint.sh"]
