```
samba_ad:
  realm: DEV.SMITH-LAB.XYZ
  workgroup: DEV

requirements:
  - samba must own tcp/53
  - samba must own udp/53
  - systemd-resolved stub listener disabled
  - resolv.conf managed by ansible
  - dns forwarder configured
```

## Non-DC Linux Servers

```
systemd-resolved enabled
DNS via DHCP/static
Cockpit enabled
Samba optional
```

## AD Domain Controllers

```
systemd-resolved running
DNSStubListener=no

Samba owns:
  TCP/53
  UDP/53

resolv.conf managed by configuration management

nameserver 127.0.0.1
search dev.smith-lab.xyz
```
