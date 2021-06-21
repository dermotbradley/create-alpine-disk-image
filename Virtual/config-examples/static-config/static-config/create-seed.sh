#!/bin/sh

echo "Creating cloud-init ISO..."
rm -f ../static-seed.img
cloud-localds \
  --verbose \
  --disk-format raw \
  --filesystem iso9660 \
  --network-config=network-config-v2.yaml \
  ../static-seed.img \
  user-data.yaml \
  meta-data.yaml

exit
