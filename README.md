# Smith-Lab

Infrastructure as Code and platform engineering repository for Smith-Lab.

## Overview

Smith-Lab is a personal homelab environment built around:

- OpenTofu
- Ansible
- Podman
- Cloudflare
- Fedora (Runtime) / Debian Linux (ProxMox Host)
- Samba Active Directory

The goal is to maintain a reproducible platform where infrastructure definitions, service definitions, networking, storage, and DNS are managed as code.

## Architecture

OpenTofu acts as the system model and source of truth.

Ansible consumes those definitions to configure hosts and deploy services.

```text
OpenTofu
    ↓
Infrastructure Model

Ansible
    ↓
Configuration & Deployment

Podman
    ↓
Application Runtime
```

## Repository Layout

## Domain Model

### Hosts

Defines physical and virtual systems.

Examples:

- smith-lab
- fedora-desktop
- fedora-dell
- nvr

### Services

Defines workloads hosted by the platform.

Examples:

- GitLab
- Vaultwarden
- Samba AD
- Caddy Reverse Proxy

### DNS

Defines publically accessible endpoints.

Examples:

- git.smith-lab.xyz
- vault.smith-lab.xyz
- ad.smith-lab.xyz

### Networking

Defines network topology and addressing.

Examples:

- LAN
- VLANs
- Gateways

### Storage

Defines storage locations and service data roots.

Examples:

- Containers
- Media
- Backups

## Goals

- Infrastructure as Code
- Reproducible deployments
- Disaster recovery readiness
- Self-hosted services
- Domain-integrated Linux Environment

## Status

Active development
