FROM alpine:3.6

RUN apk add --no-cache \
      bash python py-pip jq && \
    pip install awscli && \
    rm -rf /var/cache/apk/*

WORKDIR /app/

COPY entrypoint.sh /app/

ENTRYPOINT ["/app/entrypoint.sh"]
