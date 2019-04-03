FROM alpine:3.9
MAINTAINER aljg1999<aljg1999@gmail.com>


ENV HOST=127.0.0.1   \
    NAME=unspecified

ADD  rootfs.tar.gz  /
#RUN  apk --no-cache add ganglia-gmond

COPY gmond.conf   /etc/ganglia/

VOLUME ["/etc/ganglia/conf.d"]

# gmond ports
EXPOSE 8649


CMD envsubst < gmond.conf > gmond.conf && \
    /usr/local/bin/gmond