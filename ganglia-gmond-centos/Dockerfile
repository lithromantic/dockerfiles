FROM centos:6

ENV HOST=127.0.0.1   \
    NAME=unspecified

RUN rpm -Uvh https://dl.fedoraproject.org/pub/epel/epel-release-latest-6.noarch.rpm &&\
    yum install -y  ganglia-gmond &&\
    yum clean all

EXPOSE 8649

CMD envsubst < gmond_demo.conf > gmond.conf && \
    service gmond restart
