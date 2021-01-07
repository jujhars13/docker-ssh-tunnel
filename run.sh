#!/bin/sh
# create an ssh tunnel to a bastion host, then tunnel into db from there

# required variables
# LOCAL_PORT=3312
# REMOTE_PORT=3306
# REMOTE_SERVER_IP="my.internal.mariadb.server" # defaults to 127.0.0.1
# SSH_BASTION_HOST="bastion.host"
# SSH_PORT=22 # defaults to 22
# SSH_USER="tunnel_user"

if [ -z ${REMOTE_SERVER_IP+x} ]; then
    REMOTE_SERVER_IP="127.0.0.1"
fi

if  [ -z ${SSH_PORT+x} ] ; then
    SSH_PORT="22"
fi

if [ -z ${LOCAL_PORT+x} ] || [ -z ${REMOTE_PORT+x} ] || [ -z ${SSH_BASTION_HOST+x} ] || [ -z ${SSH_USER+x} ] ; then 
    echo "some vars are not set"; 
    exit 1
fi

echo "starting SSH proxy $LOCAL_PORT:$REMOTE_SERVER_IP:$REMOTE_PORT on $SSH_USER@$SSH_BASTION_HOST:$SSH_PORT"

/usr/bin/ssh \
-NTC -o ServerAliveInterval=60 \
-o GatewayPorts=true \
-o ExitOnForwardFailure=yes \
-o StrictHostKeyChecking=no \
-L $LOCAL_PORT:$REMOTE_SERVER_IP:$REMOTE_PORT \
$SSH_USER@$SSH_BASTION_HOST \
-p $SSH_PORT \
-i /ssh_key/id_rsa
