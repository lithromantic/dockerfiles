FROM williamyeh/dash

ADD  rootfs.tar.gz  /

EXPOSE 8649

VOLUME ["/etc/ganglia/conf.d"]

# for convenience
ADD docker-entrypoint.sh  /entrypoint.sh
COPY gmond_demo.conf            /etc/ganglia/gmond.conf

#RUN chmod -R 777 /entrypoint.sh &&\
#RUN  envsubst < gmond_demo.conf > gmond.conf

# Define default command.
ENTRYPOINT ["/entrypoint.sh"]

CMD  ["gmond"]

