FROM centos:6

ENV HOST=127.0.0.1   \
    NAME=unspecified

COPY docker-entrypoint.sh  /entrypoint.sh
COPY gmond_demo.conf  /etc/ganglia/gmond.conf


RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm &&\
    yum install -y  ganglia-gmond &&\
    yum clean all

EXPOSE 8649

#ENTRYPOINT ["/entrypoint.sh"]

FROM gcr.io/distroless/cc
COPY --from=build /usr/sbin/gmond /
CMD ["/app"]

#CMD envsubst < gmond_demo.conf > gmond.conf && \
CMD ["/entrypoint.sh"]
