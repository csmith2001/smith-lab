# smith-lab-dc01

Primary domain controller for smith-lab.xyz

## Parts Inventory

* Motherboard:

  * [MSI - B550 TOMAHAWK MAX WIFI (Socket AM4) AMD B550 ATX DDR4 Wi-Fi 6E Motherboard - Black](https://www.msi.com/Motherboard/MAG-B550-TOMAHAWK-MAX-WIFI/Specification "https://www.msi.com/Motherboard/MAG-B550-TOMAHAWK-MAX-WIFI/Specification")
* CPU:

  * [AMD - Ryzen 7 5800XT 8-Core - 16-Thread 3.8 GHz (4.8 GHz Max Boost) Socket AM4 PCI Express 4.0 Unlocked Desktop Processor - Silver](https://www.amd.com/en/products/processors/desktops/ryzen/5000-series/amd-ryzen-7-5800xt.html "https://www.amd.com/en/products/processors/desktops/ryzen/5000-series/amd-ryzen-7-5800xt.html")
* GPU:

  * [XFX - SPEEDSTER SWFT210 AMD Radeon RX 7600 Core 8GB GDDR6 PCI Express 4.0 Graphics Card - Black](https://www.xfxforce.com/shop/xfx-speedster-swft-210-amd-radeon-tm-rx-7600-core-edition "https://www.xfxforce.com/shop/xfx-speedster-swft-210-amd-radeon-tm-rx-7600-core-edition")
* RAM:

  * [CORSAIR VENGEANCE® RGB PRO 32GB (2 x 16GB) DDR4 DRAM Up To 3200MHz C16 Memory Kit — Black](https://www.corsair.com/us/en/p/memory/cmw32gx4m2e3200c16/vengeance-rgb-pro-32gb-2-x-16gb-ddr4-dram-3200mhz-c16-memory-kit-black-cmw32gx4m2e3200c16?srsltid=AU7gw4WVd-pNxYZokI_maiiLpJ5HxnQZ1Qk5eB4AySPrU74j0dvbt1g7 "https://www.corsair.com/us/en/p/memory/cmw32gx4m2e3200c16/vengeance-rgb-pro-32gb-2-x-16gb-ddr4-dram-3200mhz-c16-memory-kit-black-cmw32gx4m2e3200c16?srsltid=AU7gw4WVd-pNxYZokI_maiiLpJ5HxnQZ1Qk5eB4AySPrU74j0dvbt1g7")
* Storage:

  * 2x - [Samsung - Internal SSD 990 1TB, Read/Write Speeds Up to 7,250/6,450 MB/s (MZ V9V1T0B/AM)](https://www.samsung.com/us/memory-storage/nvme-ssd/990-nvme-ssd-sku-mz-v9v1t0b-am/ "https://www.samsung.com/us/memory-storage/nvme-ssd/990-nvme-ssd-sku-mz-v9v1t0b-am/")
* Power Supply:

  * [CORSAIR - RMe Series RM750e 80 PLUS Gold Fully Modular Low-Noise ATX 3.1 and PCIE 5.1 Power Supply - Black](https://www.corsair.com/us/en/p/psu/cp-9020295-na/rme-series-rm750e-fully-modular-low-noise-atx-power-supply-cp-9020295-na "https://www.corsair.com/us/en/p/psu/cp-9020295-na/rme-series-rm750e-fully-modular-low-noise-atx-power-supply-cp-9020295-na")

## Disk Layout

| Slot | Name                | Size   | PCIe Address | PCIe Gen |
| ---- | ------------------- | ------ | ------------ | -------- |
| M2_1 | Samsung SSD 990 1TB | 931.5G | 01:00.00     | 4.0      |
| M2_2 | Samsung SSD 990 1TB | 931.5G | 04:00.00     | 3.0      |

## Storage Architecture

### Overall

```
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS
```

```
NAME          SIZE FSTYPE            MOUNTPOINTS
nvme0n1     931.5G               
├─nvme0n1p1     1G vfat              /boot/efi
├─nvme0n1p2     2G linux_raid_member 
│ └─md0         2G ext4              /boot
└─nvme1n1p3 928.5G linux_raid_member 
  └─md1     928.4G btrfs             /
  
nvme1n1     931.5G               
├─nvme1n1p1     1G vfat          
├─nvme1n1p2     2G linux_raid_member 
│ └─md0         2G ext4              /boot
└─nvme0n1p3 928.5G linux_raid_member 
  └─md1     928.4G btrfs             /
```

### RAID Configuration

#### md0

Mounted as:
/boot

```
md0
├── RAID1
├── nvme0n1p2
└── nvme1n1p2
```

#### md1

Mounted as:
/

```
md1
├── RAID1
├── nvme0n1p3
└── nvme1n1p3
```

##### BTRFS Subvolumes

```
/
├── var
├── home
├── srv/infra
├── srv/infra/samba
└── srv/infra/bkup
```

---

## First-Boot

* ssh into box using ip (find using network gateway): `ssh admin@<IP>`
  * If re-imaging and using ssh from the same workstation: `ssh-keygen -R <IP>`
* Check for system upgrades: `sudo dnf upgrade -y`
  * If YES:
    * Check if system needs restarted: `sudo dnf needs-restarting -r`
      * If YES:
        * `sudo reboot`
  * If NO, continue

### Validation

```
hostnamectl
findmnt
lsblk -o NAME,SIZE,FSTYPE,MOUNTPOINTS
sudo btrfs subvolume list /
cat /proc/mdstat
```
