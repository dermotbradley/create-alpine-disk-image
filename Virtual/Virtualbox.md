# Virtualbox

## Status

## Status

| Arch     | Boot type | Bootloader | Status     |
|:--------:|:---------:|:----------:|:----------:|
| x86      | BIOS      | Grub       | Working    |
| x86      | BIOS      | Syslinux   | Working    |
| x86_64   | BIOS      | Grub       | Working    |
| x86_64   | BIOS      | Syslinux   | Working    |
| x86_64   | UEFI      | Grub       | Working    |
| x86_64   | UEFI      | Syslinux   | Working    |

## Creating a disk image

For x86_64 BIOS VMs:

```
create-alpine-disk-image \
  --boottype bios --virtual virtualbox --script-filename create.sh
sudo ./create.sh
```

For x86_64 UEFI VMs:

```
create-alpine-disk-image \
  --virtual virtualbox --script-filename create.sh
sudo ./create.sh
```

## Importing a disk image

- convert the RAW image to a VDI image:
```
VBoxManage convertfromraw alpine-3.14.img alpine-3.14.vdi --format VDI
```

- create a new VM in Virtualbox

```
Select the "New" icon.

In the "Hard Disk" section select "Do not add a virtual hard disk", then
click on "Create" button.

Now on the main screen select the Alpine virtual machine and click on
"Settings" icon. Click on the "Storage" icon. Right-click on the "Controller:
IDE" entry and select "Remove Controller". Next click on the 1st icon at
bottom to add a new storage controller, and select "virtio-scsi". Next with
"Controller: VirtIO" highlighted click on the 2nd icon next to it ("Adds
hard disk") which brings up the "Hard Disk Selector" dialog box. In the
dialog box click the "Add" icon, then pick the VDI file of the Alpine image and
click on "Open" button, then back in the dialog click on "Choose" button.

Click on the "Network" icon. Click on "Advanced", then change the "Adapter
Type" to "Paravirtualised Network (virtio-net)" and click "OK" button.

Finally click on "OK" button.
```

## cloud-init user-data

The following is the minimum user-data you should specify:

```
# Set default user's password (for console login use)
password: test

# Authorised Keys: add to those of the default user
ssh_authorized_keys:
  - ssh-rsa SSH-paste-rest-of-public-key-here
```
