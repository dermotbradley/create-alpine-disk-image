# CHANGELOG for create-alpine-disk-image

### Version 0.2-dev (UNRELEASED)

* Completely reworked, splitting the code into several included "defines" and "functions" files. This was done in order to keep the code manageable and also in preparation for adding additional scripts.
* Documented PC & RPI, and QEMU & Virtualbox image creation and use.
* Changed script logging to use UTC so that timestamps outside and inside chroot match.
* Added support for LUKS encrypted root filesystem. LUKS2 support is not yet working.
* Added support for LVM root filesystem.
* Added support for LVM on LUKS.
* Added support for Doas as well as, or instead of, Sudo.
* Added support for selecting the DHCP client to use.
* Added support for selecting the filesystem type to use for rootfs.
* Added "--harden" option.
* Added "--optimise" option. This controls several things including: reduction of modules included in initramfs to a minimal required set, grub-install placing reduced set of GRUB modules inside /boot/grub/ directory.
* For Raspberry Pis added support for hardware RTC.
* Enable acpid on physical x86/x86_64 machine types. tiny-power-button is used for Cloud machines and VMs except for QEMU/Virtualbox/VMWare VMs where their own agents manage things.
* For physical machines added options to specify the intended CPU vendor (AMD/Intel) and graphics chip vendor (AMD/Intel/Nvidia) so that only relevant CPU microcode are loaded and drivers placed in initramfs.
* Completely restructured how things works - create-alpine-disk-image now requires no privileges as it simply creates another secondary shell script which then needs to be run as user 'root' to actually generate the disk image.
* Added lots of new options, use "./create-alpine-disk-image --help" to see the full list.
* Reworked how partition sizing is determined (taking into account LVM overheads etc).
* Don't install chrony for KVM-based Virtual Machines (i.e. libvirtd, lxd, ProxMox, QEMU) as they should use kvm-clock to sync with host name.
* TRIM support for SSD-based physical machines.
* Experimental: "--without-cloud-init" option.
* Experimental: Syslinux with UEFI.
* Experimental: support for Bootcharts.
* Work-in-progress: support for other SSH servers than OpenSSH.
* Work-in-progress: add LXD VM support.

### Version 0.1 (08/06/2021)

* Initial version. Still undergoing extensive work and testing.
