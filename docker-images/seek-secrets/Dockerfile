FROM python:3.7.4-alpine3.10

RUN apk update && \
    apk add libffi-dev openssl-dev gcc musl-dev git

RUN pip install --upgrade pip && pip install trufflehog slackclient

RUN mkdir /rules
ADD docker-images/seek-secrets/inc/entrypoint.sh /
COPY docker-images/seek-secrets/rules/regexes.json /rules/

ENTRYPOINT ["/entrypoint.sh"]
