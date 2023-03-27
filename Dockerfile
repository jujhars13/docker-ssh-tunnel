FROM alpine:3.16
MAINTAINER Kalitsune <fanny@kalitsune.cloud>

LABEL maintainer="Kalitsune fanny@kalitsune.cloud" \
      org.label-schema.vcs-url="e.g. https://github.com/Kalitsune/reverse-ssh-tunnel"

RUN apk --no-cache add openssh-client

ADD run.sh /run.sh

ENV SSH_PORT=22
ENV SSH_USER=root
ENV CONTAINER_IP=127.0.0.1
ENV CONTAINER_PORT=80
ENV REMOTE_IP=""
ENV REMOTE_PORT=80

# Security fix for CVE-2016-0777 and CVE-2016-0778
RUN echo -e 'Host *\nUseRoaming no' >> /etc/ssh/ssh_config

ENTRYPOINT ["/bin/sh", "-c", "/run.sh"]