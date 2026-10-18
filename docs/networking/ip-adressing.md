```
VERIZON FIOS
│
└── Router / Firewall
    │
    ├── VLAN 10 - Infrastructure
    │   └── 10.10.10.0/24
    │       ├── smith-lab-dc01
    │       ├── smith-lab-runner01
    │       └── smith-lab-app01
    │
    ├── VLAN 20 - Applications
    │   └── 10.10.20.0/24
    │       ├── smith-docs
    │       ├── git
    │       ├── vaultwarden
    │       └── future application services
    │
    ├── VLAN 30 - DMZ
    │   └── 10.10.30.0/24
    │       ├── reverse-proxy01
    │       └── future public services
```

Benefit becomes clear here:

If app01 dies:

```
New hardware
↓
Install Fedora
↓
Install libvirt
↓
OpenTofu Apply
↓
Restore VM disks
↓
Ansible Apply
↓
Services Online
```

VM addresses never change:

```
git01   = 10.10.20.10
docs01  = 10.10.20.20
```

Only hypervisor changes.

## Management / Infrastructure VLAN

```
VLAN 10
10.10.10.0/24

dc01
dc02
runner01
hypervisors
switches
ups
```

This is where AD, DNS, Ansible, OpenTofu, and management traffic lives.

Nothing here should be directly exposed to the internet.

Contains physical infrastructure assets.

## Server / Application VLAN

```
VLAN 20
10.10.20.0/24

Physical Hosts
Domain Controllers
Hypervisors
Automation Hosts
Network Equipment
UPS Devices
```

Can talk to infrastructure.

May be reverse proxied.

Contains application workloads regardless of the physical host executing them.

# DMZ / Public Services

```
VLAN 30
10.10.30.0/24

Virtual Machines
Containers
Internal Services
```

Internet-facing systems.

These should not have unrestricted access back into:

```
smith-lab-dc01
smith-lab-runner01
```

# Client VLAN

```
VLAN 40
10.10.40.0/24

workstations
laptops
phones
```

Domain-joined clients.

# Lab VLAN

```
VLAN 50
10.10.50.0/24

test VMs
sandbox servers
breaking-things-on-purpose
```

This ends up being incredibly useful.

# Storage VLAN (Later)

```
VLAN 60
10.10.60.0/24

nas01
backup01
```

Could wait years before you need this.
