# AWS

## Status

Work-in-progress

## Creating a disk image

For x86_64 VMs:

```
create-alpine-disk-image --cloud aws --script-filename create.sh
sudo ./create.sh
```

For Arm VMs:

```
create-alpine-disk-image --arch aarch64 --cloud aws --script-filename create.sh
sudo ./create.sh
```

## Importing a disk image as an AMI

- load the disk image into an S3 bucket:
```
aws s3 cp alpine.raw s3://image-bucket/
```
- create a file details.json with the following contents:
```
[
  {
    "Description": "Alpine AWS 3.13",
    "Format": "RAW",
    "UserBucket": {
        "S3Bucket": "image-bucket",
        "S3Key": "alpine-3.13-aws.raw"
    }
}]
```
- import the disk image from the S3 bucket to create an AMI:
```
aws ec2 import --architecture [ i386 | x86_64 | arm64 ] --description "Alpine 3.13" --disk-containers "file://details.json"
```
