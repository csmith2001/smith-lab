# Current State

```
sudo usermod -s /usr/sbin/nologin svc_infra
sudo usermod -s /usr/sbin/nologin svc_caddy
sudo usermod -s /usr/sbin/nologin svc_vaultwarden

sudo passwd -l svc_infra
sudo passwd -l svc_caddy
sudo passwd -l svc_vaultwarden
```

Results:

```
No interactive login
No password login
No SSH login (because nologin shell)
Ownership/accounting only
```

## Create Automation User

Non-interactive login set for svc users

```
sudo usermod -s /bin/bash svc_infra
```

Results:

```
No password login
SSH key login allowed
Interactive shell available
Can own rootless Podman runtime
Can be used by Ansible
Not intended for human use
```

### Note

```
Locking a password does NOT disable SSH key authentication.
The shell (/bin/bash vs nologin) determines whether a session can be started.
```

## Create SSH Login

```
sudo su svc_infra
cd~

pwd
ls -alhrt

mkdir ~/.ssh
cd ~/.ssh

touch authorized_keys
chmod 600 ~/.ssh/authorized_keys
chmod -R 700 ~/.ssh
chown -R svc_infra:svc_infra ~/.ssh
```

```
Goal:
Allow DEV\csmith to SSH into Linux hosts using AD credentials.

Requirements:
- Domain users visible via getent
- Automatic home directory creation
- SSH using AD credentials
- Allow selected AD groups sudo
- Preserve local break-glass account (debian-admin)
- Managed entirely by Ansible
```
