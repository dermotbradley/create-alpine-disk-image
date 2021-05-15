# create-alpine-disk-image

A Shell script designed to create cloud-init enabled, server oriented, disk images of Alpine Linux. The script can be run on Alpine, Debian, or Ubuntu host machines.

The script is based on an Ansible playbook which I've developed over the past 12+ months for creating tailored Alpine disk images for use with QEMU VMs, physical PCs, and Raspberry Pis.

Features:

- creates "raw" disk images inside a chroot environment.
- supports aarch64, armv7, x86, and x86_64 architectures. Uses ```binfmt``` and ```qemu-user``` to create images for architectures other than that of the machine running the script.
- supports images for Cloud, physical machine, and VM use.
- ideal for use by a CI/CD pipeline to easily create multiple disk images.
- images for use with any specific Cloud Provider(s) do not have to be built in that Cloud (although they can be).
- supports Alpine releases from 3.13 onwards (including Edge).
- cloud-init is used for system configuration (for physical machines YAML files are stored in a small FAT partition).
- resultant disk images are intended for server, rather than desktop, use.


## Host packages required

Alpine:

- busybox
- e2fsprogs
- parted
- qemu-aarch64 (optional)
- qemu-arm (optional)
- qemu-openrc (optional)
- qemu-x86 (optional)
- qemu-x86_64 (optional)
- util-linux

Debian:

- binfmt-support (optional)
- coreutils
- e2fsprogs
- mount
- parted
- qemu-user-static (optional)
- wget

## Cloud images

The ```generic``` cloud disk image works with multiple cloud providers.

Individual cloud provider specific images (with provider-specific tools built-in) can also be built:

- aliyun (Alibaba Cloud)
- aws
- azure
- digitalocean
- gce
- hetzner
- scaleway
- vultr

Resultant disk images then need to be imported into whichever Clouds using cloud-specific method(s). More information on this is detailed in individual READMEs in the Cloud directory.

## Physical machine images

Can create disk images for the follow machines:

- pc (x86 and x86_64), either BIOS or UEFI based
- rpi2, a Raspberry Pi model 2b (armv7 and also, **only** for late-model 2b's, aarch64)
- rpi3, a Raspberry Pi model 3b (aarch64 and armv7)
- rpi4, a Raspberry Pi model 4b (aarch64 and armv7)


## VM images

Can create disk images for the following hypervisors:

- Openstack
- ProxMox
- QEMU
- RHEVm
- VMWare
- VSphere

Resultant disk images can then be converted using ```qemu-img convert``` to the required format for the hypervisor, i.e. OVA, QCOW2.

## Examples

With no options specified the default it to build a x86_64 image running Alpine Edge for use with the QEMU hypervisor:

    create-alpine-disk-image

Build a **generic** x86_64 Cloud image running Alpine 3.13 that can be used with multiple Cloud Providers:

    create-alpine-disk-image -c generic -r 3.13

Build a AWS x86_64 image running Alpine 3.13:

    create-alpine-disk-image -c aws -r 3.13

Build a AWS aarch64 image running Alpine Edge:

    create-alpine-disk-image -c aws -a aarch64

Build a Raspberry Pi 4 aarch64 image running Alpine 3.13:

    create-alpine-disk-image -p rpi4 -r 3.13

Build a Raspberry Pi 3 armv7 image running Alpine Edge:

    create-alpine-disk-image -p rpi3 -a armv7
