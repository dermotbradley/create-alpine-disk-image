# Azure

## Status

Work-in-progress

## Creating a disk image

```
create-alpine-disk-image --cloud azure
```

## Linux tools for Azure

The Microsoft [Azule CLI](https://github.com/Azure/azure-cli) is not yet packaged for Alpine.

The Microsoft utility azcopy is not yet packaged for Alpine and appears to require .NET Core. A more lightweight Python alternative, also not yet packaged for Alpine, is [blobxfer](https://github.com/Azure/blobxfer).

## Importing a disk image

- convert the RAW image to a VHD image:
```
qemu-img convert -f raw -O vhd alpine-3.13.raw alpine-3.13.vhd
```
- calculate the size of the image in bytes:
```
wc -c alpine-3.13.vhd
```
- create an empty managed disk for the image:
```
az disk create -n <yourdiskname> -g <yourresourcegroupname> -l <yourregion> --for-upload --upload-size-bytes <size in bytes> --sku standard_lrs
```
- generate a writeable SAS (Shared Access Signature):
```
az disk grant-access -n <yourdiskname> -g <yourresourcegroupname> --access-level Write --duration-in-seconds 86400
```
- upload the VHD disk image to the managed disk:
```
blobxfer upload --local-path "alpine-3.13.vhd" --storage-url "<accessSas value from previous command>"
```
- revoke the SAS:
```
az disk revoke-access -n <yourdiskname> -g <yourresourcegroupname>
```
