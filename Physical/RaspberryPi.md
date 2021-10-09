# Raspberry Pis

## Status

| Board Type          | Arch     | Status     |
|:-------------------:|:--------:|:----------:|
| RPI 2B version 1.2+ | aarch64  | Not tested |
| RPI 2B              | armv7    | Not tested |
| RPI 3B & 3B+        | aarch64  | Working    |
| RPI 3B & 3B+        | armv7    | Not tested |
| RPI 4B              | aarch64  | Not tested |
| RPI 4B              | armv7    | Not tested |

## Creating a disk image

For aarch64 RPI3:

```
create-alpine-disk-image \
  --arch aarch64 --physical rpi2 --script-filename create.sh
sudo ./create.sh
```

For armv7 RPI2:

```
create-alpine-disk-image \
  --arch armv7 --physical rpi2 --script-filename create.sh
sudo ./create.sh
```

## Using a disk image

- using a PC (with either a SDcard socket or with a USB-to-SDcard adaptor)
  copy the disk image onto a SDcard using 'dd'. When using a USB adaptor the
  SDcard device may be something like /dev/sdb or /dev/sdc whereas with a
  built-in SDcard reader it may be /dev/mmcblk0. For example:

```
dd if=alpine-disk-image.img of=/dev/sdb bs=1M
```

## cloud-init user-data

The disk image includes a small FAT partition (with label "cidata")
containing 3 cloud-init YAML configuration files. There is also a
sub-directory there with example files.

Simply edit these files *before* booting the Raspberry Pi the first time to
tailor things like hostname, IP address, etc.
