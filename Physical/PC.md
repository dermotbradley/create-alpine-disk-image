# x86 and x86_64 PCs

## Status

| Arch     | Boot type | Bootloader | Status     |
|:--------:|:---------:|:----------:|:----------:|
| x86      | BIOS      | Grub       | Not tested |
| x86      | BIOS      | Syslinux   | Not tested |
| x86_64   | BIOS      | Grub       | Working    |
| x86_64   | BIOS      | Syslinux   | Working    |
| x86_64   | UEFI      | Grub       | Working    |
| x86_64   | UEFI      | Syslinux   | Working    |

## Creating a disk image

For x86 boot type of BIOS and Syslinux bootloader is assumed.
For x86_64 boot type of UEFI and Grub bootloader is assumed.

For x86_64 BIOS-based PC using Grub ("--arch x86_86" is optional):

```
create-alpine-disk-image \
  [ --arch x86_64 ] --bootloader grub --boottype bios --physical --script-filename create.sh
sudo ./create.sh
```

For x86_64 BIOS-based PC using Syslinux:

```
create-alpine-disk-image \
  [ --arch x86_64 ] [ --bootloader syslinux ] --boottype bios --physical --script-filename create.sh
sudo ./create.sh
```

For x86_64 UEFI-based PC using Grub:

```
create-alpine-disk-image \
  [ --arch x86_64 ] [ --bootloader grub ] [ --boottype uefi ] --physical --script-filename create.sh
sudo ./create.sh
```

For x86_64 UEFI-based PC using Syslinux:

```
create-alpine-disk-image \
  [ --boottype uefi ] --bootloader syslinux --physical --script-filename create.sh
sudo ./create.sh
```

## Using a disk image

- boot the PC using an existing Linux boot media (i.e. USB stick, CDROM etc)

- copy the disk image onto a SSD or HDD using 'dd'. For example where the
  drive to write to is /dev/sdb you could run something like:

```
dd if=alpine-disk-image.img of=/dev/sdb bs=1M
```

## cloud-init user-data

The disk image includes a small FAT partition (with label "cidata")
containing 3 cloud-init YAML configuration files. There is also a
sub-directory there with example files.

Simply edit these files *before* booting the machine the first time to
tailor things like hostname, IP address, etc.
