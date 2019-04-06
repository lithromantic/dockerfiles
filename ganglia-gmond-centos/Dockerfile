FROM centos:6 as build

ENV HOST=127.0.0.1   \
    NAME=unspecified

WORKDIR /usr/sbin

COPY gmond_demo.conf  /etc/ganglia/gmond.conf


RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm &&\
    yum install -y  ganglia-gmond &&\
    yum clean all


#ENTRYPOINT ["/entrypoint.sh"]

FROM gcr.io/distroless/base
COPY --from=build /usr/sbin/gmond /

COPY docker-entrypoint.sh  /entrypoint.sh

ENTRYPOINT ["/entrypoint.sh"]

EXPOSE 8649

#CMD envsubst < gmond_demo.conf > gmond.conf && \
CMD ["/entrypoint.sh"]
