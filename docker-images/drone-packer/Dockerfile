FROM alpine:3.9

ADD docker-images/drone-packer/inc/entrypoint.sh /entrypoint.sh

RUN apk --no-cache add --upgrade ansible wget nodejs npm && \
  wget https://releases.hashicorp.com/packer/1.4.5/packer_1.4.5_linux_amd64.zip -O /usr/local/bin/packer.zip && \
    cd /usr/local/bin && unzip packer.zip

ENTRYPOINT ["/entrypoint.sh"]
