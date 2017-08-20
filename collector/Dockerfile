FROM alpine:3.6
RUN apk add --no-cache curl docker jq
COPY scripts/  /
ENTRYPOINT ["/entrypoint.sh"]
