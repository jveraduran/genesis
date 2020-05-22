FROM vault:1.0.2

RUN apk update && apk add openssh && apk add jq

ADD inc/entrypoint.sh /entrypoint.sh

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]
