# Configure BIOS Settings

## Purpose

Configure firmware settings required for consistent Fedora installation and operation.

The objective is to establish a known-good firmware baseline before operating system deployment.

---

## Prerequisites

* Installation media prepared
* Target hardware assembled
* Keyboard, monitor, and display connected

---

## Firmware Standards

### UEFI Boot Mode

#### Rationale

UEFI is required for:

* Modern bootloader support
* EFI System Partitions
* Consistent recovery procedures
* Future operating system compatibility

#### Validation

Verify the system is configured for:

* `UEFI`

and not

```
Legacy BIOS
CSM
Legacy + UEFI
```

##### Expected Result

The system boots exclusively using UEFI firmware.

---

### Secure Boot

#### Rationale

A lot of operational workflows and bootable media tools like Ventoy may rquire custom kernel modules or third-party drivers.

The platform standard is:

* `Disabled`

unless a future security standard explicitly requires Secure Boot

#### Validation

Verify:

* Secure Boot = `Disabled`

##### Expected Result

* Confirmation of changes on exit
* Fedora installer boots without Secure Boot restrictions

---

## Boot Order

### Rationale

Installation media should have temporary priority during provisioning. This avoids accidental booting from stale OS installs.

### Validation

Boot menu displays:

* `UEFI:<USB_DEVICE_NAME>`

##### Expected Result

The installer launches without manual firmware intervention.

---

## SATA Mode

### Rationale

Linux software RAID is used throughout the platform. Motherboard RAID functionality is not used.

### Validation

Verify:

* `AHCI` is selected

#### Expected Result

OS detects individual storage devices directly.

---

## Firmware Update

### Rationale

Firmware updates should be applied before platform deployment when practical.

Updating firmware after Active Directory deployment introduces unnecessary operational risk.

### Validation

Record:

* Motherboard model
* Firmware version
* Firmware release date

in Inventory documentation.

##### Expected Result

Current firmware baseline documented.

---

## TPM

#### Rationale

TPM is not currently required for Samba Active Directory operation. Where available, TPM should remain enabled.

Enabling TPM preserves future security and attestation capabilities without affecting current platform operations.

#### Validation

Verify:

- TPM = Enabled

##### Expected Result

The operating system can access TPM functionality if required by future platform standards.

---

## Recovery

If firmware settings become unknown:

1. Load motherboard defaults
2. Reapply documented settings
3. Revalidate installation media detection
4. Restart provisioning process
