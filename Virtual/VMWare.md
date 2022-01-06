# VMWare

## Status

## Status

| Arch     | Boot type | Bootloader | Status     |
|:--------:|:---------:|:----------:|:----------:|
| x86      | BIOS      | Grub       | Not tested |
| x86      | BIOS      | Syslinux   | Not tested |
| x86_64   | BIOS      | Grub       | Not tested |
| x86_64   | BIOS      | Syslinux   | Not tested |
| x86_64   | UEFI      | Grub       | Not tested |
| x86_64   | UEFI      | Syslinux   | Not tested |

## Creating a disk image

For x86_64 BIOS VMs:

```
create-alpine-disk-image \
  --boottype bios --virtual vmware --script-filename create.sh
sudo ./create.sh
```

For x86_64 UEFI VMs:

```
create-alpine-disk-image \
  --virtual vmware --script-filename create.sh
sudo ./create.sh
```

## Importing a disk image

- convert the RAW image to a VMDK image:
```
qemu-img convert -f raw -O vmdk alpine-3.14.img alpine-3.14.vmdk
```

- create a new VM in VMWare

Select the storage controller to be VMware Paravirtual.
Select the network controller to be Enhanced vmxnet.

Import the VMDK file created above.

## cloud-init user-data

The following is the minimum user-data you should specify:

```
# Set default user's password (for console login use)
password: test

# Authorised Keys: add to those of the default user
ssh_authorized_keys:
  - ssh-rsa SSH-paste-rest-of-public-key-here
```
