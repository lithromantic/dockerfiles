FROM williamyeh/dash

ADD  rootfs.tar.gz  /

ENV HOST=127.0.0.1   \
    NAME=unspecified

EXPOSE 8649

VOLUME ["/etc/ganglia/conf.d"]

# for convenience
COPY docker-entrypoint.sh  /entrypoint.sh
COPY gmond.conf            /etc/ganglia/

# Define default command.
ENTRYPOINT ["/entrypoint.sh"]

CMD envsubst < gmond_demo.conf > gmond.conf && \
    ["gmond"]

