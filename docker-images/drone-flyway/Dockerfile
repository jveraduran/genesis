FROM vault:1.0.2

RUN apk update && \
    apk add openssh && \ 
    apk add jq && \
    apk --update add postgresql-client

RUN apk add maven --update-cache --repository http://dl-4.alpinelinux.org/alpine/edge/community/ --allow-untrusted \
	&& rm -rf /var/cache/apk/*

RUN apk update &&  \                                                                                                                                                                                                                        
    apk add ca-certificates wget && \                                                                                                                                                                                                      
    update-ca-certificates

RUN wget -O consul.zip https://releases.hashicorp.com/consul/1.5.1/consul_1.5.1_linux_amd64.zip && unzip consul.zip -d /usr/local/bin && chmod u+x /usr/local/bin/consul && rm consul.zip

ENV MAVEN_HOME /usr/share/java/maven-3
ENV PATH $PATH:$MAVEN_HOME/bin

ADD docker-images/drone-flyway/inc/entrypoint.sh /

RUN chmod +x /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]