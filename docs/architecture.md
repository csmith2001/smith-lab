# Approach

## OpenTofu creates infrastructure

Examples:

```
Cloudflare DNS
VMs
Networks
Firewalls
Volumes
Buckets
Databases
```

OpenTofu is desired architecture written as code

## Ansible configures infrastructure

Examples:

```
Install packages
Create directories
Deploy compose files
Configure services
Manage users
System settings
```

Ansible enforces architecture through automated deployment

---

**Current State `09/27/2026 19:41:22`:**

* smith-lab created (Debian 13)
  * Was having issues with Proxmox VE 9.2 ISO Installer
    * Balena etcher and running `sudo dd=if/home/csmith/Downloads/proxmox-ve_9.2-1.iso of=/dev/sda bs=4M status=progress`
* Hostname: `smith-lab`
* IP address reserved in Gateway
* OS drive installed
* 4 TB NVMe untouched
* 1 TB NVMe untouched
* Service backups safe
