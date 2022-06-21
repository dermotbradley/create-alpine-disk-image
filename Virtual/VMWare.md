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

The basic form is:

```
qemu-img convert -f raw -O vmdk -o adapter_type=lsilogic alpine-3.14.img alpine-3.14.vmdk
```

The ```-o adapter_type=lsilogic``` option indicates that a scsi controller
should be stored in the VMDK metadata rather than the default IDE controller.

It appears that some versions of VMWare products may not like the above and so
the ```subformat``` option may also need to be specified with a value of
either ```monolithicFlat``` or ```streamOptimized``` rather than the default
value of ```monolithicSparse```.

Multiple options are comma separate and so to select SCSI and monolithicFlat
the option list would be:

```
-o adapter_type=lsilogic,subformat=monolithicFlat
```

The "adapter_type" option provides no way to specify PVSCSI which would be
the optimal storage controller to use for a VM - this can however be
selected when creating the VM in the VMware admin interface (i.e. VSphere).

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
