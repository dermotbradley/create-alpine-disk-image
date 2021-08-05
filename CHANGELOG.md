# CHANGELOG for create-alpine-disk-image

### Version 0.2-dev (UNRELEASED)

* Documented QEMU & Virtualbox image creation and use.
* Syslinux with UEFI is now functional.
* Changed script logging to use UTC so that timestamps outside and inside chroot agree.
* Modified grub-install parameters so that a reduced set of GRUB modules are installed inside /boot/grub/ directory.
* Added support for LUKS encrypted root filesystem. LUK2 support is not yet working.
* Added support for Bootcharts.
* Enable acpid init.d for all machine types except QEMU/Virtualbox/VMWare VMs.
* For physical machines added options to specify the intended CPU vendor (AMD/Intel) and graphics chip vendor (AMD/Intel/Nvidia) so that only relevant CPU microcode are loaded and drivers placed in initramfs.
* Completely restructured how things works - create-alpine-disk-image now requires no privileges as it simply creates another secondary shell script which then needs to be run as user 'root' to actually generate the disk image.

### Version 0.1 (08/06/2021)

* Initial version. Still undergoing extensive work and testing.
