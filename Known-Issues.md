# Known issue not yet addressed

- inodes are not set appropriately to take into account later partition
  growth. The root filesystem should be formatted will enough inodes
  based on the assumption it will be grown later.

- 4K device sector are not presently handled. This means disk images will not
  work optimally on physical/VM/cloud machines that provide a storage device
  with 4K logical sector sizes, indeed for UEFI machines they will likely not
  boot as the ESP partition will not be sized appropriately (the minimal FAT
  filesystem size for 4K sector devices is larger than for 512-byte sector
  devices). In the future the script will add an option to specify sector size
  and will take this into account when partitioning the disk image, installing
  the bootloader and formatting any LUKS filesystem.

- encrypted disk images when dd'ed onto disks will have known passphrase/key
  and volume key. The planned bootable image installer utility will reencrypt
  disk images (in ramdisk) before dd'ing them to the destination device so
  that each time the same disk image is installed its volume key will be unique.
