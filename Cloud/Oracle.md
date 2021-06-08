# Oracle Cloud

## Status

Work-in-progress

## Creating a disk image

For x86_64 VMs:

```
create-alpine-disk-image --cloud oracle
```

For Arm VMs:

```
create-alpine-disk-image --arch aarch64 --cloud oracle
```

## Importing a disk image

- convert the RAW image to a QCOW2 image:
```
qemu-img convert -f raw -O qcow2 alpine-3.13.img alpine-3.13.qcow2
```

- load the disk image into an Object Storage bucket:
```
oci os object put -bn <destination_bucket_name> --file <path_to_the_QCOW2_file>
```

- Open the navigation menu and click Compute. Under Compute, click Custom Images.

- Click Import Image.

- In the Create in Compartment list, select the compartment that you want to import the image to.

- Enter a Name for the image.

- For the Operating System, select Linux.

- Select the Import from an Object Storage bucket option.

- Select the Bucket that you uploaded the image to.

- In the Object Name list, select the image file that you uploaded.

- For the Image Type, select QCOW2.

- In the Launch Mode area, select Paravirtualized Mode.

- Show Tagging Options: If you have permissions to create a resource, then you also have permissions to apply free-form tags to that resource. To apply a defined tag, you must have permissions to use the tag namespace. For more information about tagging, see Resource Tags. If you are not sure whether to apply tags, skip this option (you can apply tags later).

- Click Import Image.

The imported image appears in the Custom Images list for the compartment, with a state of
Importing. When the import completes successfully, the state changes to Available.
If the state doesn't change, or no entry appears in the Custom Images list, the import failed.
Ensure that you have read access to the Object Storage object, and that the object contains a
supported image.

- Complete the post-import tasks.

## Post import tasks

- If you want to use the image on AMD or X6-based shapes, add the shapes to the image's list of compatible shapes.

- Create an instance based on the custom image. For the image source, select Custom Images, and then select the image that you imported.

- Connect to the instance using SSH.

## cloud-init user-data

The following is the minimum user-data you should specify:

```
# Set default user's password (for console login use)
password: test

# Authorised Keys: add to those of the default user
ssh_authorized_keys:
  - ssh-rsa SSH-paste-rest-of-public-key-here
```
