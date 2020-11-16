FROM alpine:3.12
MAINTAINER Jujhar Singh <jujhar+docker@jujhar.com>

LABEL org.label-schema.vcs-url="e.g. https://github.com/jujhars13/docker-ssh-tunnel"

RUN apk --no-cache add openssh-client bash

ADD run.sh /run.sh

# Security fix for CVE-2016-0777 and CVE-2016-0778
RUN echo -e 'Host *\nUseRoaming no' >> /etc/ssh/ssh_config

ENTRYPOINT ["sh", "-c", "/run.sh"]
