# Fedora Runner Installation

## Purpose

This runbook is designed to go over the manual installation method for a runner on smith-lab.xyz.

---

## Prerequisites

* Installation media prepared
* Target hardware assembled
* Keyboard, monitor, and display connected
* BIOS configured

---

## Ventoy GRUB Menu

### Rationale

* Choose configured Operating System img file
* `Boot in normal mode`

### Validation

Verify:

* Selected img file displays in boot menu
* File checksum matches checksum from Fedora Everything [page](https://fedoraproject.org/misc/#everything) using the provide instructions
  * On the selected install, click the checkboard with the checkmark icon

##### Expected Result

Selected img file boots.

---

## Fedora GRUB Menu

### Rationale

Choose:

* Install Fedora `xx`

### Validation

Verify:

* Fedora install scripts begin

##### Expected Results

Anaconda installer menu pops up on `WELCOME TO FEDORA` screen.

---

## Welcome to Fedora

### Rationale

Choose:

* Desired language of choice

### Validation

Verify:

* Text is legible

#### Expected Results

Fedora intaller is set to `English (United States)`

---

## Installation Summary

### Rationale

Begin install confiuguration from any of the following sections:

* LOCALIZATION
  * Keyboard
  * Language Support
  * Time & Date
* SOFTWARE
  * Installation Source
  * Software Selection
* SYSTEM
  * Installation Destination
  * Network & Host Name
* USER SETTINGS
  * Root Account
  * User Creation

### Validation

Verify:

* Selected menu opens

#### Expected Results

Fedora installer menu opens to selected menu and options are configurable.

---

## Keyboard

### Rationale

By default, this will match selected language in Welcome to Fedora menu.

If not, choose:

* Selected language

### Validation

Verify:

* On text menus, type in placeholder test

#### Expected Results

Keyboard keystrokes input text as per configured keyboard language settings.

---

## Language Support

### Rationale

By default, this will match selected language in Welcome to Fedora menu.

If not, choose:

* Selected language

### Validation

Verify:

* On menus, text is legible

#### Expected Results

Fedora intaller is set to English (United States.

---

## Time & Date

### Rationale

By default, this will be set to **Automatic date & time**.

If not, choose:

* Automatic date & time

### Validation

Verify:

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

```
Base Environment
Fedora Server Edition

Additional software for Selected Environment
Container Management
Domain Membership
Headless Management
System Tools
```
