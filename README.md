# create-alpine-disk-image

A Shell script designed for easily creating cloud-init enabled, server oriented, disk images of Alpine Linux. The script, and the secondary script it creates, can be run on Alpine, Debian, or Ubuntu host machines - you do not need a machine running Alpine to create a disk image.

The script itself, create-alpine-disk-image, is designed to be run as any user - **it does not need root privileges** - as all that it actually does is to create another, secondary, script which is tailored to produce the required disk image when run.

The (created) secondary script must be run with 'root' privileges (whether via doas/su/sudo or directly as 'root' user) as it requires privileges in order to create loopback devices, partitions disk images, etc.

---
**NOTE: This script is a work-in-progress and not yet stable. The initial
aim is to fully test QEMU VM and Raspberry Pi disk images and then a few
Cloud provider images.**

---

The script is based on an Ansible playbook which I've developed over the past
12+ months for creating tailored Alpine disk images for use with QEMU VMs,
physical PCs, and Raspberry Pis.

Features:

- runs in "Sys" mode, i.e. runs-from-disk rather than runs-from-RAM.
- creates "raw" disk images inside a chroot environment.
- supports aarch64, armv7, x86, and x86_64 architectures. Uses ```binfmt``` and
```qemu-user``` to create images for architectures other than that of the machine running the script.
- supports images for Cloud, physical machine, and VM use.
- ideal for use by a CI/CD pipeline to easily create multiple disk images.
- images for use with any specific Cloud Provider(s) do not have to be built in
that Cloud (although they can be).
- supports Alpine releases from 3.13 onwards (including Edge).
- cloud-init is used for system configuration (for physical machines YAML files
are stored in a small FAT partition).
- resultant disk images are intended for server, rather than desktop, use.

More information regarding specific features can be found here: (Features/)


## Host packages required

Alpine:

- blkid
- busybox
- cryptsetup (optional)
- e2fsprogs
- lvm2 (optional)
- parted
- qemu-aarch64 (optional)
- qemu-arm (optional)
- qemu-openrc (optional)
- qemu-x86 (optional)
- qemu-x86_64 (optional)
- util-linux

Debian / Ubuntu:

- binfmt-support (optional)
- coreutils
- cryptsetup-bin (optional)
- e2fsprogs
- lvm2 (optional)
- mount
- parted
- qemu-user-static (optional)
- wget

## Cloud images

The ```generic``` cloud disk image works with multiple cloud providers.

Individual cloud provider specific images (with provider-specific tools built-in) can also be built for:

- Aliyun (Alibaba Cloud)
- AWS
- Azure
- Bigstep
- Brightbox
- Digitalocean
- E24
- Exoscale
- Google
- Hetzner
- Hyperone
- IBM Cloud
- Oracle Cloud
- Rootbox
- Scaleway
- Tencent
- Upcloud
- Vultr

Resultant disk images then need to be imported into whichever Clouds using cloud-specific method(s). More information on this is detailed in individual READMEs in the Cloud directory.

## Physical machine images

Can create disk images for the follow machines:

- pc (x86 and x86_64), either BIOS or UEFI based, using either Syslinux or GRUB as bootloader
- rpi2, a Raspberry Pi model 2b (armv7 and also, **only** for late-model 2b's, aarch64)
- rpi3, a Raspberry Pi model 3b (aarch64 and armv7)
- rpi4, a Raspberry Pi model 4b (aarch64 and armv7)


## VM images

Can create disk images for the following hypervisors:

- Libvirtd
- Openstack
- ProxMox
- QEMU
- RHEVm
- Virtualbox
- VMware
- VSphere

Resultant disk images can then be converted using ```qemu-img convert``` to the required format for the hypervisor, i.e. OVA, QCOW2.

## Examples

The only mandatory option to specify is ```--script-filename``` to indicate the name of the secondary script to be created. With no other options specified the default is to build a x86_64 image running Alpine Edge for use with the QEMU hypervisor:

```
create-alpine-disk-image --script-filename create.sh
su -c ./create.sh
```

Build a **generic** x86_64 Cloud image running Alpine 3.13 that can be used with multiple Cloud Providers:

```
create-alpine-disk-image --cloud generic --release 3.13 --script-filename create.sh
sudo ./create.sh
```

Build a AWS x86_64 image running Alpine 3.13:

```
create-alpine-disk-image --cloud aws --release 3.13 --script-filename create.sh
sudo ./create.sh
```

Build a AWS aarch64 image running Alpine Edge:

```
create-alpine-disk-image --cloud aws --aarch aarch64 --script-filename create.sh
su -c create.sh
```

Build a Raspberry Pi 4 aarch64 image running Alpine 3.13:

```
create-alpine-disk-image --physical rpi4 --release 3.13 --script-filename create.sh
sudo ./create.sh
```

Build a Raspberry Pi 3 armv7 image running Alpine Edge:

```
create-alpine-disk-image --physical rpi3 --arch armv7 --script-filename create.sh
sudo ./create.sh
```
