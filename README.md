# Docker Reversed SSH Tunnel

Create a lightweight Alpine Linux based SSH tunnel to a host.  Uses pure SSH, no fluff.

For single TCP port applications (database/webserver/debugging access) a SSH tunnel is far faster and simpler than using a VPN like OpenVPN; see this excellent [blog post](https://blog.backslasher.net/ssh-openvpn-tunneling.html) for more info.

For example I use it to create a SSH tunnel from a GCP Kubernetes cluster into an on prem bastion host in order to talk to an on prem MySQL database; it SSHs onto the internal LAN and connects me to the internal on prem MySQL server.

Inspired by https://github.com/iadknet/docker-ssh-client-light and [GCP CloudSQL Proxy](https://cloud.google.com/sql/docs/mysql/sql-proxy)

**FORKED FROM jujhars13/docker-ssh-tunnel/** but reversed the tunnel direction. (more details about tunneling [here](https://iximiuz.com/en/posts/ssh-tunnels/))

## Required Parameters

| Variable           | Description                                                       | Required |
| ------------------ | ----------------------------------------------------------------- | -------- |
| `SSH_PORT`         | Port number for SSH (defaults to 22)                              | No       |
| `SSH_USER`         | Username for the SSH connection (default: root)                   | No       |
| `CONTAINER_IP`     | IP address of the container (default: 127.0.0.1)                  | No       |
| `CONTAINER_PORT`   | The port you want to expose on the container (default: 80)        | No       |
| `REMOTE_IP`        | IP/Domain of the machine that will expose your app (the host)     | Yes      |
| `REMOTE_PORT`      | Remote port that will be exposed on the host (default: 80)        | No       |


Note: Remember to inject/mount your private SSH key into the container to `/ssh_key/id_rsa`.

## Repos

gcr.io: `docker pull gcr.io/kalitsune/docker-reversed-ssh-tunnel`
Docker Hub: `docker pull kalithekitsune/docker-reversed-ssh-tunnel`

## Example

please refer to the [examples/docker-compose.yml](/examples/docker-compose.yaml) file for an example.

## Recommandations

if you want to use an open-ssh docker container, you can use [this linux-server.io image mod](https://github.com/linuxserver/docker-mods/tree/openssh-server-ssh-tunnel)