```
DC Fedora Installation
├── Purpose
├── Requirements
├── Disk Layout
├── Fedora Installation
├── First Boot
├── Storage Configuration
├── Network Configuration
├── Samba AD Provisioning
├── Service Accounts
├── Validation
└── Lessons Learned
```

# Domain Controller Fedora Installation

## Purpose

This runbook is designed to go over the manual installation method for a Domain Controller on smith-lab.xyz.

## Requirements

Text

## Fedora Installation

### Disk Layout

Minimum 2 disks RAID1 configuration for all disks unless otherwise specified.

```
NAME           SIZE FSTYPE                      MOUNTPOINTS
disk1 
├── disk1part1 1-nG EFI System Partition (vfat) /boot/EFI
├── disk1part2 2-nG linux_raid_member
│   └─ md0          ext4                        /boot
└── disk1part3 nG   linux_raid_member
	└─ md0          btrfs                       /
```
