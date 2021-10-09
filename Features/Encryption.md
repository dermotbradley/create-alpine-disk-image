# Encryption

Enables the encryption of disk image's root filesystem (and /boot if GRUB is
bootloader).

Optional remote unlocking of encryption via SSH is a work-in-progress.

Command-line options to control encryption are:

- --encrypt
- --encrypt-passphrase
- --encrypt-remote-unlock
- --remote-unlock-network-module
- --remote-unlock-ssh-port
- --remote-unlock-static-gateway
- --remote-unlock-static-interface
- --remote-unlock-static-ip
- --remote-unlock-static-netmask
- --ssh-public-key

## LUKS key slots used

Key Slot 0 stores the passphrase to unlock the encrypted partition.

When GRUB is the bootloader (and only if remote unlocking is not enabled) then Key Slot 1 is also used for the keyfile used to automatically unlock the root filesystem (after GRUB has unlocked the boot files). This is to avoid having to enter the passphrase twice (once for GRUB and then again for the initramfs to unlock the root filesystem).

## GRUB

Full disk encryption (including /boot) it supported using GRUB, as long as
remote unlock is *not enabled*. If remote unlock is enabled then
GRUB-encryption will not be enabled (as that would defeat the whole point of
remote encryption unlock) and only normal LUKS encryption is used.

Currently for GRUB use LUKS version 1 filesystems are created. The aim is to, *in the near future*, create LUKS version 2 filesystems for Alpine >= 3.14 & Edge once issues related to GRUB & LUKS2 have been resolved.

A keyfile is created (when remote unlock is not enabled), in additional to a
passphrase, so that the user is not prompted for the passphrase twice (by
GRUB and then by cryptsetup) during boot - the keyfile is stored in the
initramfs and the file permissions of both the keyfile and /boot/initramfs
are set accordingly.

## Syslinux

Encryption of root filesystem is supported however in that case a separate
unencrypted /boot partition is created.

## Raspberry Pi

Encryption of root filesystem is supported.

## Remote unlocking of encryption

This is a work-in-progress.
