#!/bin/bash
# This script makes the initramfs image and moves it to my kernel directory.
rm ../../hp-kernel-tenderloin/img.gz
make image
mv initramfs.cpio.gz ../../hp-kernel-tenderloin/img.gz
