
# Docker SSH Tunnel

[![](https://badge.imagelayers.io/jujhars13/docker-ssh-tunnel:latest.svg)](https://imagelayers.io/?images=jujhars13/docker-ssh-tunnel:latest 'Get your own badge on imagelayers.io')

Used to create a lightweight SSH tunnel to a bastion host, then proxy a db/service from there.  Uses pure SSH, no fluff

For example I use it to create an SSH tunnel into a public facing bastion host, there it SSHs onto the internal LAN and connects me to MySQL all from Kubernetes.

 Alpine Linux based.

Inspired by https://github.com/iadknet/docker-ssh-client-light 

### required params
```bash
## required variables
# port on your machine/k8s cluster
LOCAL_PORT=3312
REMOTE_PORT=3306
# OPTIONAL defaults to 127.0.0.1
REMOTE_SERVER_IP="my.internal.mariadb.server"
# the bastion/host you're connecting to
SSH_BASTION_HOST="bastion.host"
# OPTIONAL defaults to 22
SSH_PORT=2297
SSH_USER="tunnel_user"

# also be sure to inject/mount your private ssh key into the container to /ssh_key/id_rsa
```

### Example
```bash

docker run -it --rm \
-e LOCAL_PORT=3306 \
-e REMOTE_PORT=3306 \
-e SSH_BASTION_HOST=34.135.248.162 \
-e SSH_USER=jujhar \
-e SSH_PORT=2297 \
-v ~/.ssh/id_rsa:/ssh_key/id_rsa:ro \
jujhars13/docker-ssh-tunnel
```

## TODO
- [ ] add example k8s manifest