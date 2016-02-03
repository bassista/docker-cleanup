FROM alpine:latest

RUN apk add --update bash grep curl

ENV VERSION 1.7.1
RUN curl -sS https://get.docker.com/builds/Linux/x86_64/docker-$VERSION > /usr/bin/docker-$VERSION && \
    curl -sS https://get.docker.com/builds/Linux/x86_64/docker-$VERSION.sha256 > /usr/bin/docker-$VERSION.sha256 && \
    cd /usr/bin/ && sha256sum -c /usr/bin/docker-$VERSION.sha256 && \
    chmod u+x /usr/bin/docker-$VERSION  && \
    ln -s /usr/bin/docker-$VERSION /usr/bin/docker

# Install cleanup script
ADD run.sh /run.sh
ADD docker-cleanup-volumes.sh /docker-cleanup-volumes.sh

ENV CLEAN_PERIOD **None**
ENV DELAY_TIME **None**
ENV KEEP_IMAGES **None**
ENV LOOP true

ENTRYPOINT ["/run.sh"]
