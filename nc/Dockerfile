FROM alpine:latest
RUN apk add --no-cache netcat-openbsd
EXPOSE 4444
ENTRYPOINT ["nc", "-lvnp", "4444"]