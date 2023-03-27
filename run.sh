#!/bin/sh
# create an ssh tunnel to a bastion host, then tunnel into db from there

#   ==== DEFAULTS ====
#   ENV SSH_PORT=22
#   ENV SSH_USER=root
#   ENV CONTAINER_IP=127.0.0.1
#   ENV CONTAINER_PORT=80
#   ENV REMOTE_IP=""
#   ENV REMOTE_PORT=80

if [ -z ${REMOTE_IP+x} ] ; then 
    echo "please specify REMOTE_IP;"; 
    exit 1
fi

echo "starting SSH Reverse proxy $CONTAINER_IP:$CONTAINER_PORT -> $REMOTE_IP:$REMOTE_PORT as $SSH_USER@$REMOTE_IP:$SSH_PORT"

/usr/bin/ssh \
-NTC -o ServerAliveInterval=60 \
-o GatewayPorts=yes \
-o ExitOnForwardFailure=yes \
-o StrictHostKeyChecking=no \
-R *:$REMOTE_PORT:$CONTAINER_IP:$CONTAINER_PORT \
$SSH_USER@$REMOTE_IP \
-p $SSH_PORT \
-i /ssh_key/id_rsa