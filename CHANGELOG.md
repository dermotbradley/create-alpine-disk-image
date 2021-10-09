# CHANGELOG for create-alpine-disk-image

### Version 0.2-dev (UNRELEASED)

* Documented PC & RPI, and QEMU & Virtualbox image creation and use.
* Syslinux with UEFI is now functional.
* Changed script logging to use UTC so that timestamps outside and inside chroot match.
* Modified grub-install parameters so that a reduced set of GRUB modules are installed inside /boot/grub/ directory.
* Added support for LUKS encrypted root filesystem. LUKS2 support is not yet working.
* Added support for LVM root filesystem.
* Added support for Bootcharts.
* Added support for Doas as well as, or instead of Sudo.
* Added support for selecting the DHCP client to use.
* Added support for selecting the filesystem type to use for rootfs.
* For Raspberry Pis added support for hardware RTC.
* Enable acpid on physical x86/x86_64 machine types. tiny-power-button is used for Cloud machines and VMs except for QEMU/Virtualbox/VMWare VMs where their own agents manage things.
* For physical machines added options to specify the intended CPU vendor (AMD/Intel) and graphics chip vendor (AMD/Intel/Nvidia) so that only relevant CPU microcode are loaded and drivers placed in initramfs.
* Completely restructured how things works - create-alpine-disk-image now requires no privileges as it simply creates another secondary shell script which then needs to be run as user 'root' to actually generate the disk image.
* Added new options: "--add-packages", "--auth-control", "--bootloader-password", "--create-boot-partition", "--dhcp-client", "--disk-image-size", "--enable-utmp", "--firewall", "--for-ssd", "--fs-type", "--full-hostname", "--harden", "-kernel-type", "--minimise-users-groups", "--no-grub-encryption", "--rpi-poe-hat", "--rpi-rtc", "--short-hostname", "--ssh-server", "--timezone"
* Reworked how partition sizing is determined (taking into account LVM overheads etc).
* Work-in-progress: support for other SSH servers than OpenSSH.
* Work-in-progress: TRIM support for SSD-based physical machines.

### Version 0.1 (08/06/2021)

* Initial version. Still undergoing extensive work and testing.
