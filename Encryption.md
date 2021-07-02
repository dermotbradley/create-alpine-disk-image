# Encryption

Enables the encryption of disk image's root filesystem (and /boot if GRUB is
bootloader).

Remote unlocking of encryption via SSH is a work-in-progress.

Command-line options to control encryption are:

- --encrypt
- --encrypt_remote_unlock
- --remote_unlock_network_module
- --remote_unlock_static_gateway
- --remote_unlock_static_interface
- --remote_unlock_static_ip
- --remote_unlock_static_netmask
- --ssh_public_key

## GRUB

Full disk encryption (including /boot) it supported using GRUB.

Currently LUKS version 1 filesystems are created. The aim is to, *in the near
future*, create LUKS version 2 filesystems for Alpine >= 3.14 and Edge once
issues related to LUKS2 have been resolved.

A keyfile is created, in additional to a passphrase, so that the user is not
prompted for the passphrase twice (by Grub and then by cryptsetup) during
boot - the keyfile is stored in the initramfs.

## Syslinux

Encryption of root filesystem is supported however in that case a separate
unencrypted /boot partition is created.

## Raspberry Pi

Encryption of root filesystem is supported.

## Remote unlocking of encryption

This is a work-in-progress.
