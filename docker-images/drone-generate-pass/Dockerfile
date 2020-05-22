FROM vault:latest

RUN apk update && apk add openssh && apk add jq && \
    apk add --no-cache openssl

ADD docker-images/drone-generate-pass/inc/entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]