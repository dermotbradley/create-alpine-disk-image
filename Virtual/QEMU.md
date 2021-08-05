# QEMU

## Status

| Arch     | Boot type | Bootloader | Status     |
|:--------:|:---------:|:----------:|:----------:|
| aarch64  | UEFI      | Grub       | Working    |
| x86      | BIOS      | Grub       | Not tested |
| x86      | BIOS      | Syslinux   | Not tested |
| x86_64   | BIOS      | Grub       | Working    |
| x86_64   | BIOS      | Syslinux   | Working    |
| x86_64   | UEFI      | Grub       | Working    |
| x86_64   | UEFI      | Syslinux   | Working    |

## Creating a disk image

For aarch64 boot type of UEFI and Grub bootloader is assumed. For x86 boot type of BIOS and Syslinux bootloader is assumed. For x86_64 boot type of UEFI and Syslinux bootloader is assumed.

For aarch64 UEFI VMs:

```
create-alpine-disk-image --arch aarch64 --script-filename create.sh
sudo ./create.sh
```

For x86_64 BIOS-based VMs using Grub:

```
create-alpine-disk-image --bootloader grub --boottype bios --script-filename create.sh
sudo ./create.sh
```

For x86_64 BIOS-based VMs using Syslinux:

```
create-alpine-disk-image --boottype bios --script-filename create.sh
sudo ./create.sh
```

For x86_64 UEFI-based VMs using Grub:

```
create-alpine-disk-image --bootloader grub --script-filename create.sh
sudo ./create.sh
```

For x86_64 UEFI-based VMs using Syslinux:

```
create-alpine-disk-image --script-filename create.sh
sudo ./create.sh
```

## Using a disk image

RAW disk images work fine with QEMU but QCOW2 images are preferred.

- (optionally) convert the RAW image to a QCOW2 image

```
qemu-img convert -f raw -O qcow2 alpine-3.14.img alpine-3.14.qcow2
```

- run the image

For aarch64:

```
qemu-system-aarch64 \
  -name qemu-aarch64 \
  -nodefaults \
  -k en-gb \
  -machine virt \
  -cpu cortex-a53 \
  -m 512 \
  -smp cpus=1 \
  -display none \
  -drive if=pflash,format=raw,readonly,file=/usr/share/AAVMF/AAVMF_CODE.fd \
  -drive if=pflash,format=raw,file=./AAVMF_VARS.fd \
  -device virtio-scsi-device,id=scsi \
  -drive file=qemu-aarch64.qcow2,if=scsi,format=qcow2,id=hd0 \
  -device scsi-hd,drive=hd0 \
  -netdev tap,id=mynet0,script=no,downscript=no \
  -device virtio-net-pci,netdev=mynet0 \
  -object cryptodev-backend-builtin,id=cryptodev0 \
  -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
  -object rng-random,id=rng0 \
  -device virtio-rng-pci,rng=rng0,max-bytes=1024,period=1000
```

x86_64 BIOS using Syslinux:

You can replace ```-serial stdio``` with either ```-vga std``` or ```-vga virtio``` to use alternative display drivers.

The references to ```scsi-cd"```, ```scsh-hd```, and ```virtio-scsi-pci``` ensure that the _virtio-scsi_ driver is used. You can change these to use the _virtio-blk_ driver instead but the virtio-scsi driver is generally preferred.

```
qemu-system-x86_64 \
  -name qemu-bios-syslinux \
  -nodefaults \
  -enable-kvm \
  -k en-gb \
  -machine type=q35,accel=kvm,usb=off,vmport=off \
  -m 512 \
  -smp cpus=1 \
  -serial stdio \
  -boot menu=off \
  -device virtio-scsi-pci,id=scsi \
  -drive file=qemu-bios-syslinux.qcow2,id=hd0,if=scsi,format=qcow2 \
  -device scsi-hd,drive=hd0 \
  -drive file=${SEED}-seed.img,id=cd0,if=scsi,format=raw \
  ${DISK_OPTIONS} \
  -device scsi-cd,drive=cd0 \
  -object cryptodev-backend-builtin,id=cryptodev0 \
  -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
  -device virtio-keyboard-pci \
  -netdev tap,id=mynet0,ifname=${TAP},script=no,downscript=no \
  -device virtio-net-pci,netdev=mynet0,mac=${MAC} \
  -object rng-random,id=rng0 \
  -device virtio-rng-pci,rng=rng0,max-bytes=1024,period=1000 \
  -monitor telnet:127.0.0.1:${MONITOR_PORT},server,nowait \
  -device virtio-serial \
  -chardev pty,id=qga0 \
  -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
```

x86_64 UEFI using either Grub or Syslinux:

The OVMF_VARS.fd file is used to store UEFI settings (a separate file for each VM).

```
cp /usr/share/OVMF/OVMF_VARS.fd OVMF_VARS.fd
qemu-system-x86_64 \
  -name qemu-uefi \
  -nodefaults \
  -enable-kvm \
  -k en-gb \
  -machine type=q35,accel=kvm,usb=off,vmport=off \
  -m 512 \
  -smp cpus=1 \
  -vga std \
  -boot menu=off \
  -drive if=pflash,format=raw,readonly,file=/usr/share/OVMF/OVMF_CODE.fd \
  -drive if=pflash,format=raw,file=./OVMF_VARS.fd \
  -drive file=qemu-uefi-grub.qcow2,if=virtio,format=qcow2 \
  -object cryptodev-backend-builtin,id=cryptodev0 \
  -device virtio-crypto-pci,id=crypto0,cryptodev=cryptodev0 \
  -device virtio-keyboard-pci \
  -netdev tap,id=mynet0,ifname=${TAP},script=no,downscript=no \
  -device virtio-net-pci,netdev=mynet0,mac=${MAC},romfile="" \
  -object rng-random,id=rng0 \
  -device virtio-rng-pci,rng=rng0,max-bytes=1024,period=1000 \
  -monitor telnet:127.0.0.1:4445,server,nowait \
  -device virtio-serial \
  -chardev pty,id=qga0 \
  -device virtserialport,chardev=qga0,name=org.qemu.guest_agent.0
```

## cloud-init user-data

The following is the *minimum* user-data you should specify so that you can login both via the console (using a password) and via SSH (using a SSH key) as the default user ('```alpine```' but changeable when you create the disk image):

```
# Set default user's password (for console login use)
password: test

# Authorised Keys: add to those of the default user
ssh_authorized_keys:
  - ssh-rsa SSH-paste-rest-of-public-key-here
```

Unlike when used with a Cloud Provider, when using cloud-init on a Virtual Machine typically the configuration is provided via an ISO9660-formatted disk image containing the configuration in YAML files.

To create a suitable ISO image run the cloud-localds command in a directory containing three files named ```meta-data.yaml```, ```network-config-v2.yaml```, and ```user-data.yaml```. The cloud-localds command is provided by the Alpine cloud-utils package and the Debian & Ubuntu cloud-image-utils packages.

An example command:

```
cloud-localds \
  --disk-format raw \
  --filesystem iso9660 \
  --network-config=network-config-v2.yaml \
  cidata.iso \
  user-data.yaml \
  meta-data.yaml
```

Various examples of cloud-init YAML configuration files are contained in the config-examples subdirectory.
