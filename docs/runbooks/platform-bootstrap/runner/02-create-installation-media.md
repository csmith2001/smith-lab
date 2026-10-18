# Creating Installation Media

## Purpose

Create bootable installation media for the Smith Lab platform. Installation media is required before firmware configuration and operating system deployment can begin. Ventoy is the preferred solution because installation media can be centrally managed and updated without repeatedly reimaging USB devices.

---

## Preferred Method: Ventoy

### Rationale

Ventoy is the standard media solution for SmithLab. There is no need to repeatedly reformat and reflash a USB drive. Simply copy supported image files to the Ventoy partition and boot them directly using [Grub](https://www.gnu.org/software/grub/) baked right in.

#### Benefits

* Multiple installation images on a single USB device
* No repeated re-flashing
* Drag-and-drop image management
* Folder-based image organization
* Supports:
  * [ISO](https://en.wikipedia.org/wiki/Optical_disc_image)
  * [WIM](https://en.wikipedia.org/wiki/Windows_Imaging_Format)
  * [IMG](https://en.wikipedia.org/wiki/Disk_image)
  * [VHD(x)](https://en.wikipedia.org/wiki/VHD_(file_format))
  * [EFI files](https://en.wikipedia.org/wiki/UEFI)

This simplifies long-term maintenance and allows operating system installers, recovery tools, diagnostic environments, and firmware utilities to coexist on a single USB device.

### Procedure

* Download Ventoy:

  * Visit: [downloads page](https://www.ventoy.net/en/download.html)
  * Download the latest `linux.tar.gz` file
* Extract the archive:

  ```Shell
  cd ~/Downloads
  tar -xzf ventoy-*.tar.gz
  rm -rf ventoy-*.tar.gz
  cd ventoy-*
  ```
* Insert the USB drive
* Identify the device:

  ```Shell
  lsblk -f
  ```

  Example:

  ```
  sdX
  ├─sdX1
  └─sdX2
  ```
* Install Ventoy:

  ```Shell
  sudo ./Ventoy2Disk.sh -i /dev/sdX
  ```

### Validation

Verify partition layout:

```Shell
lsblk -f
```

#### Expected Result

```
sdX
├─sdX1 exfat   Ventoy
└─sdX2 vfat    VTOYEFI
```

The Fedora installation image exists on the Ventoy partition and is visible from the Ventoy boot menu.

### Recovery

If Ventoy installation fails:

1. Confirm the correct target device was selected
2. Re-run the Ventoy2Disk.sh
3. Remove and reconnect the USB device
4. Validate the Ventoy partition layout again

If corruption is suspected, recreate the device from scratch.

---

## Alternative Method: USB Flashing Tools

Tools such as:

* [Balena Etcher](https://etcher.balena.io/)
* [Rufus](https://rufus.ie/en/)
* Fedora Media Writer

can create bootable installation media. These solutions are functional but do not provide th emedia management advanatages of Ventoy. A new operationg system image typically requires the device to be recreated.

### Expected Result

The selected application successfully writes the Fedora image to the target USB device.

The resulting partition layout depends on the imaging tool and Fedora release.

---

## Alternative Method: sudo dd (Data Destroyer)

### Purpose

Create bootable installation media through a direct block-level write operation. This method is documented for DR and compatability scenarios. Ventoy remains the preferred approach.

### **Warning**

dd writes directly to block devices. The target device is completely overwritten.

This operation destroys:

* Existing partitions
* Existing filesystems
* Existing data
* Existing boot records

Selecting the wrong device can result in unrecoverable data loss.

### Procedure

1. Inset USB drive
2. Identify the device:
3. Unmount the USB drive:

   ```Shell
   sudo umount /dev/sdX*
   ```
4. Write the ISO:

   ```Shell
   sudo dd \
     if=Fedora-*.iso \
     of=/dev/sdX \
     bs=4M \
     status=progress \
     oflag=sync
   ```
5. Flush Pending Writes:

   ```Shell
   sync
   ```

### Validation

Identify storage block devices:

```Shell
lsblk -f
sudo fdisk -l /dev/sdX
```

##### Expected Result

The device contains the partition layout embedded within the Fedora image.

The layour will not resemble a Ventoy installation.

```
├─sdX1 iso9660 Fedora-E-dvd-x86_64-44
└─sdX2 vfat
```

Partition numbering and labels may differ between Fedora releases

### Recovery

If the wrong device was selected:

* Stop using the device immediately
* Do not create new filesystems
* Do not create new partitions
* Assess whether data recovery is required

Prevention is the only reliable mitigation.

Always backup before executing `sudo dd`.
