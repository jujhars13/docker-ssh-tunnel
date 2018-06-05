
# Docker SSH Tunnel

[![dockeri.co](http://dockeri.co/image/jujhars13/docker-ssh-tunnel)](https://hub.docker.com/r/jujhars13/docker-ssh-tunnel/)

- [`latest` (*Dockerfile*)](https://github.com/jujhars13/docker-ssh-tunnel/blob/master/Dockerfile) [![](https://images.microbadger.com/badges/image/jujhars13/docker-ssh-tunnel.svg)](http://microbadger.com/images/jujhars13/docker-ssh-tunnel "Get your own image badge on microbadger.com")

Create a lightweight Alpine Linux based SSH tunnel to a host.  Uses pure SSH, no fluff.

For single port applications (database/webserver/debugging access) a SSH tunnel is faster and simpler than using a VPN.  See this excellent [blog post](https://blog.backslasher.net/ssh-openvpn-tunneling.html) for more info.
For example I use it to create a SSH tunnel from a GCP Kubernetes cluster into an on prem bastion host, there it SSHs onto the internal LAN and connects me to the internal on prem MySQL server.

Inspired by https://github.com/iadknet/docker-ssh-client-light and [GCP CloudSQL Proxy](https://cloud.google.com/sql/docs/mysql/sql-proxy)

### Required Parameters
```bash
# local port on your machine/k8s cluster
LOCAL_PORT=3306

# remote port from the machine your SSHing into
REMOTE_PORT=3306

# OPTIONAL defaults to 127.0.0.1
REMOTE_SERVER_IP="my.internal.mariadb.server"

# the bastion/host you're connecting to
SSH_BASTION_HOST="bastion.host"

# OPTIONAL defaults to 22
SSH_PORT=2297
SSH_USER="tunnel_user"
```

Also be sure to inject/mount your private ssh key into the container to /ssh_key/id_rsa

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